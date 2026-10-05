import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;

import '../../../app/app.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/enums.dart';
import '../../../core/services/progress/learning_activity_store.dart';
import '../../../core/services/vocabulary/mastery_policy.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/services/review/review_engine.dart';
import '../../../core/help/context_help_icon.dart';
import '../../../core/help/help_catalog.dart';
import '../../../core/widgets/lexora_widgets.dart';

class ReviewCardData {
  const ReviewCardData({
    required this.reviewItem,
    required this.prompt,
    required this.answer,
    required this.itemType,
  });

  final ReviewItemRow reviewItem;
  final String prompt;
  final String answer;
  final String itemType;
}

class ReviewSessionState {
  const ReviewSessionState({
    this.cards = const [],
    this.index = 0,
    this.revealed = false,
    this.correct = 0,
    this.incorrect = 0,
    this.skipped = 0,
    this.completed = false,
    this.loading = true,
  });

  final List<ReviewCardData> cards;
  final int index;
  final bool revealed;
  final int correct;
  final int incorrect;
  final int skipped;
  final bool completed;
  final bool loading;

  ReviewCardData? get current =>
      index < cards.length ? cards[index] : null;

  int get total => cards.length;
  int get reviewed => correct + incorrect + skipped;
  double get accuracy =>
      reviewed == 0 ? 0 : correct / (correct + incorrect).clamp(1, 9999);

  ReviewSessionState copyWith({
    List<ReviewCardData>? cards,
    int? index,
    bool? revealed,
    int? correct,
    int? incorrect,
    int? skipped,
    bool? completed,
    bool? loading,
  }) {
    return ReviewSessionState(
      cards: cards ?? this.cards,
      index: index ?? this.index,
      revealed: revealed ?? this.revealed,
      correct: correct ?? this.correct,
      incorrect: incorrect ?? this.incorrect,
      skipped: skipped ?? this.skipped,
      completed: completed ?? this.completed,
      loading: loading ?? this.loading,
    );
  }
}

class ReviewSessionController extends Notifier<ReviewSessionState> {
  final _engine = const ReviewEngine();

  @override
  ReviewSessionState build() {
    Future.microtask(_load);
    return const ReviewSessionState();
  }

  Future<void> _load() async {
    final db = ref.read(appDatabaseProvider);
    final now = DateTime.now();
    final end = DateTime(now.year, now.month, now.day)
        .add(const Duration(days: 1));
    final due = await (db.select(db.reviewItems)
          ..where((t) => t.nextReviewAt.isSmallerThanValue(end))
          ..orderBy([(t) => OrderingTerm.asc(t.nextReviewAt)])
          ..limit(20))
        .get();

    final cards = <ReviewCardData>[];
    for (final item in due) {
      if (item.itemType == ReviewItemType.word.storageValue) {
        final word = await (db.select(db.words)
              ..where((t) => t.id.equals(item.itemId)))
            .getSingleOrNull();
        if (word != null) {
          cards.add(
            ReviewCardData(
              reviewItem: item,
              prompt: word.word,
              answer: word.arabicMeaning,
              itemType: item.itemType,
            ),
          );
        }
      } else if (item.itemType == ReviewItemType.vocabulary.storageValue) {
        final entry = await (db.select(db.vocabularyEntries)
              ..where((row) => row.id.equals(item.itemId)))
            .getSingleOrNull();
        if (entry != null) {
          final progress = await (db.select(db.userVocabulary)
                ..where((row) => row.entryId.equals(entry.id)))
              .getSingleOrNull();
          cards.add(
            ReviewCardData(
              reviewItem: item,
              prompt: entry.lemma,
              answer: progress?.userArabicMeaning?.isNotEmpty == true
                  ? progress!.userArabicMeaning!
                  : entry.arabicMeaning,
              itemType: item.itemType,
            ),
          );
        }
      } else if (item.itemType == ReviewItemType.sentence.storageValue) {
        final sentence = await (db.select(db.sentences)
              ..where((t) => t.id.equals(item.itemId)))
            .getSingleOrNull();
        if (sentence != null) {
          cards.add(
            ReviewCardData(
              reviewItem: item,
              prompt: sentence.sentence,
              answer: sentence.arabicTranslation,
              itemType: item.itemType,
            ),
          );
        }
      }
    }

    state = ReviewSessionState(cards: cards, loading: false, completed: cards.isEmpty);
  }

  void reveal() => state = state.copyWith(revealed: true);

  Future<void> rate(ReviewRating rating) async {
    final card = state.current;
    if (card == null) return;

    HapticFeedback.selectionClick();
    final db = ref.read(appDatabaseProvider);
    final item = card.reviewItem;
    final result = _engine.schedule(
      rating: rating,
      easeFactor: item.easeFactor,
      intervalDays: item.intervalDays,
      repetitions: item.repetitions,
    );

    final now = DateTime.now();
    await (db.update(db.reviewItems)..where((t) => t.id.equals(item.id)))
        .write(
      ReviewItemsCompanion(
        easeFactor: Value(result.easeFactor),
        intervalDays: Value(result.intervalDays),
        repetitions: Value(result.repetitions),
        nextReviewAt: Value(result.nextReviewAt),
        updatedAt: Value(now),
      ),
    );

    await db.into(db.reviewHistory).insert(
          ReviewHistoryCompanion.insert(
            id: const Uuid().v4(),
            reviewItemId: item.id,
            itemType: item.itemType,
            itemId: item.itemId,
            rating: rating.value,
            previousInterval: item.intervalDays,
            newInterval: result.intervalDays,
            reviewedAt: now,
          ),
        );
    await LearningActivityStore(db).add(reviews: 1);

    if (item.itemType == ReviewItemType.word.storageValue) {
      await (db.update(db.words)..where((t) => t.id.equals(item.itemId)))
          .write(
        WordsCompanion(
          masteryStatus: Value(result.masteryStatus.storageValue),
          reviewCount: Value(item.repetitions + 1),
          lastReviewedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    } else if (item.itemType == ReviewItemType.vocabulary.storageValue) {
      await (db.update(db.userVocabulary)
            ..where((row) => row.entryId.equals(item.itemId)))
          .write(
        UserVocabularyCompanion(
          status: Value(
            const MasteryPolicy().statusAfterReview(result.masteryStatus),
          ),
          lastUsedAt: Value(now),
        ),
      );
    } else if (item.itemType == ReviewItemType.sentence.storageValue) {
      await (db.update(db.sentences)..where((t) => t.id.equals(item.itemId)))
          .write(
        SentencesCompanion(
          masteryStatus: Value(result.masteryStatus.storageValue),
          reviewCount: Value(item.repetitions + 1),
          lastReviewedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    }

    final nextIndex = state.index + 1;
    final done = nextIndex >= state.cards.length;
    state = state.copyWith(
      index: nextIndex,
      revealed: false,
      correct: result.isCorrect ? state.correct + 1 : state.correct,
      incorrect: result.isCorrect ? state.incorrect : state.incorrect + 1,
      completed: done,
    );
  }
}

final reviewSessionProvider =
    NotifierProvider.autoDispose<ReviewSessionController, ReviewSessionState>(
  ReviewSessionController.new,
);

class ReviewSessionScreen extends ConsumerWidget {
  const ReviewSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(reviewSessionProvider);
    final theme = Theme.of(context);
    final pronunciation = ref.watch(pronunciationServiceProvider);
    final accent = ref.watch(settingsProvider).accent;

    if (state.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.completed) {
      final accuracy = ((state.accuracy) * 100).round();
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.emoji_events_outlined,
                      color: AppColors.success, size: 40),
                ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.reviewComplete,
                    style: theme.textTheme.headlineLarge),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  children: [
                    _SummaryStat(label: l10n.reviewed, value: '${state.reviewed}'),
                    _SummaryStat(label: l10n.correct, value: '${state.correct}'),
                    _SummaryStat(
                        label: l10n.incorrect, value: '${state.incorrect}'),
                    _SummaryStat(label: l10n.skipped, value: '${state.skipped}'),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  width: 140,
                  height: 140,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: state.accuracy.clamp(0.0, 1.0),
                        strokeWidth: 10,
                        backgroundColor: AppColors.border,
                        color: AppColors.primary,
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('$accuracy%',
                                style: theme.textTheme.headlineLarge),
                            Text(l10n.accuracy,
                                style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                LexoraPrimaryButton(
                  label: l10n.backToHome,
                  onPressed: () => context.go('/home'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final card = state.current!;
    final progress =
        state.total == 0 ? 0.0 : (state.index) / state.total;

    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.review}  ${state.index + 1} / ${state.total}'),
        actions: const [
          ContextHelpIcon(topic: HelpTopic.reviewSystem),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                value: progress == 0 ? 0.02 : progress,
                minHeight: 8,
                backgroundColor: AppColors.border,
                color: AppColors.primary,
              ),
            ),
            const Spacer(),
            LexoraCard(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () =>
                          pronunciation.speak(card.prompt, accent: accent),
                      icon: const Icon(Icons.volume_up_rounded),
                      color: AppColors.primary,
                    ),
                  ),
                  LtrText(
                    card.prompt,
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  if (!state.revealed)
                    TextButton(
                      onPressed: () =>
                          ref.read(reviewSessionProvider.notifier).reveal(),
                      child: Text(l10n.tapToSeeTranslation),
                    )
                  else
                    RtlText(
                      card.answer,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: AppColors.primary,
                      ),
                    ).animate().fadeIn(),
                ],
              ),
            ),
            const Spacer(),
            if (state.revealed)
              Row(
                children: [
                  _RateButton(
                    label: l10n.forgot,
                    color: AppColors.error,
                    onTap: () => ref
                        .read(reviewSessionProvider.notifier)
                        .rate(ReviewRating.forgot),
                  ),
                  _RateButton(
                    label: l10n.difficult,
                    color: AppColors.warning,
                    onTap: () => ref
                        .read(reviewSessionProvider.notifier)
                        .rate(ReviewRating.difficult),
                  ),
                  _RateButton(
                    label: l10n.good,
                    color: AppColors.primary,
                    onTap: () => ref
                        .read(reviewSessionProvider.notifier)
                        .rate(ReviewRating.good),
                  ),
                  _RateButton(
                    label: l10n.easy,
                    color: AppColors.success,
                    onTap: () => ref
                        .read(reviewSessionProvider.notifier)
                        .rate(ReviewRating.easy),
                  ),
                ],
              ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

class _RateButton extends StatelessWidget {
  const _RateButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  const _SummaryStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
