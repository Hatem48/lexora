import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/app.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/enums.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/services/topics/topic_question_payload.dart';
import '../../../core/services/topics/topic_repository.dart';
import '../../../core/services/vocabulary/vocabulary_discovery_repository.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../../home/presentation/dashboard_providers.dart';
import '../../progress/presentation/catalog_progress_section.dart';
import 'imported_content_providers.dart';
import 'topic_icons.dart';
import 'topic_providers.dart';
import 'topic_question_card.dart';

class TopicDetailScreen extends ConsumerStatefulWidget {
  const TopicDetailScreen({super.key, required this.topicId});

  final String topicId;

  @override
  ConsumerState<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends ConsumerState<TopicDetailScreen> {
  String? _cefr;
  TopicWordFilter _filter = TopicWordFilter.all;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref
          .read(importedContentMarksProvider.notifier)
          .markTopicSeen(widget.topicId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final board = ref.watch(topicBoardProvider);
    final cards = board.asData?.value.cards;
    TopicCardData? card;
    if (cards != null) {
      for (final item in cards) {
        if (item.id == widget.topicId) card = item;
      }
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            card == null
                ? l10n.topicsTitle
                : localizedPair(context, card.nameEn, card.nameAr),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.topicVocabulary),
              Tab(text: l10n.topicSentences),
              Tab(text: l10n.topicProgressTab),
              Tab(text: l10n.topicQuestions),
            ],
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 52,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                children: [
                  for (final level in [null, ...CefrLevel.values.map((e) => e.code)])
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(level ?? l10n.all),
                        selected: _cefr == level,
                        onSelected: (_) => setState(() => _cefr = level),
                      ),
                    ),
                  for (final filter in TopicWordFilter.values)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(_filterLabel(l10n, filter)),
                        selected: _filter == filter,
                        onSelected: (_) => setState(() => _filter = filter),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _WordsTab(
                    topicId: widget.topicId,
                    cefr: _cefr,
                    filter: _filter,
                  ),
                  _SentencesTab(topicId: widget.topicId, cefr: _cefr),
                  _ProgressTab(topicId: widget.topicId),
                  _QuestionsTab(topicId: widget.topicId, cefr: _cefr),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _filterLabel(AppLocalizations l10n, TopicWordFilter filter) {
    return switch (filter) {
      TopicWordFilter.all => l10n.all,
      TopicWordFilter.locked => l10n.filterLocked,
      TopicWordFilter.discovered => l10n.filterDiscovered,
      TopicWordFilter.learning => l10n.filterLearning,
      TopicWordFilter.reviewing => l10n.filterReviewing,
      TopicWordFilter.mastered => l10n.filterMastered,
    };
  }
}

class _WordsTab extends ConsumerWidget {
  const _WordsTab({
    required this.topicId,
    required this.cefr,
    required this.filter,
  });

  final String topicId;
  final String? cefr;
  final TopicWordFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final words = ref.watch(
      topicWordsProvider((id: topicId, cefr: cefr, filter: filter)),
    );
    final pronunciation = ref.watch(pronunciationServiceProvider);
    final settings = ref.watch(settingsProvider);
    final accent = settings.accent;

    return words.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('$error')),
      data: (items) {
        if (items.isEmpty) {
          return EmptyState(
            title: l10n.topicEmptyWords,
            message: l10n.topicsSubtitle,
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final word = items[index];
            return LexoraCard(
              onTap: () => context.push('/vocabulary/${word.entryId}'),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          word.lemma,
                          textDirection: TextDirection.ltr,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(word.arabicMeaning),
                      ],
                    ),
                  ),
                  CefrBadge(level: word.cefr, compact: true),
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: l10n.listen,
                    onPressed: () => pronunciation.speak(
                      word.lemma,
                      accent: accent,
                      speed: settings.playbackSpeed,
                    ),
                    icon: const Icon(Icons.volume_up_rounded),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _SentencesTab extends ConsumerWidget {
  const _SentencesTab({required this.topicId, required this.cefr});

  final String topicId;
  final String? cefr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final sentences = ref.watch(
      topicSentencesProvider((id: topicId, cefr: cefr)),
    );
    final pronunciation = ref.watch(pronunciationServiceProvider);
    final settings = ref.watch(settingsProvider);
    final accent = settings.accent;

    return sentences.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('$error')),
      data: (items) {
        if (items.isEmpty) {
          return EmptyState(
            title: l10n.topicEmptySentences,
            message: l10n.topicsSubtitle,
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final sentence = items[index];
            return LexoraCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CefrBadge(level: sentence.cefr, compact: true),
                      const Spacer(),
                      IconButton(
                        tooltip: l10n.listen,
                        onPressed: () => pronunciation.speak(
                          sentence.sentenceEn,
                          accent: accent,
                          speed: settings.playbackSpeed,
                        ),
                        icon: const Icon(Icons.volume_up_rounded),
                      ),
                    ],
                  ),
                  Text(
                    sentence.sentenceEn,
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(sentence.sentenceAr),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _ProgressTab extends ConsumerWidget {
  const _ProgressTab({required this.topicId});

  final String topicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final progress = ref.watch(topicProgressProvider(topicId));
    return progress.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('$error')),
      data: (data) {
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            Text(l10n.catalogStatsNote),
            const SizedBox(height: 12),
            LexoraCard(
              child: Column(
                children: [
                  _Row(label: l10n.topicVocabulary, value: '${data.total}'),
                  const Divider(height: 24),
                  _Row(label: l10n.filterLocked, value: '${data.locked}'),
                  const Divider(height: 24),
                  _Row(label: l10n.filterDiscovered, value: '${data.discovered}'),
                  const Divider(height: 24),
                  _Row(label: l10n.filterLearning, value: '${data.learning}'),
                  const Divider(height: 24),
                  _Row(label: l10n.filterReviewing, value: '${data.reviewing}'),
                  const Divider(height: 24),
                  _Row(label: l10n.filterMastered, value: '${data.mastered}'),
                  const Divider(height: 24),
                  _Row(
                    label: l10n.discoveredThisWeek,
                    value: '${data.discoveredThisWeek}',
                  ),
                  const Divider(height: 24),
                  _Row(
                    label: l10n.topicProgressTab,
                    value: '${(data.progress * 100).round()}%',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            LexoraCard(
              child: Column(
                children: [
                  for (final level in data.levels) ...[
                    _Row(
                      label: level.level,
                      value: l10n.topicDiscoveredOf(level.unlocked, level.total),
                    ),
                    if (level != data.levels.last) const Divider(height: 24),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _QuestionsTab extends ConsumerStatefulWidget {
  const _QuestionsTab({required this.topicId, required this.cefr});

  final String topicId;
  final String? cefr;

  @override
  ConsumerState<_QuestionsTab> createState() => _QuestionsTabState();
}

class _QuestionsTabState extends ConsumerState<_QuestionsTab> {
  final _answers = <String, TextEditingController>{};
  List<String> _found = [];

  @override
  void dispose() {
    for (final controller in _answers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _controller(String id) =>
      _answers.putIfAbsent(id, TextEditingController.new);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final db = ref.watch(appDatabaseProvider);
    final query = db.select(db.topicQuestions)
      ..where((row) => row.topicId.equals(widget.topicId));
    if (widget.cefr != null) {
      query.where((row) => row.cefrLevel.equals(widget.cefr!));
    }
    query.orderBy([(row) => OrderingTerm.asc(row.sortOrder)]);
    return StreamBuilder(
      stream: query.watch(),
      builder: (context, snapshot) {
        final questions = snapshot.data ?? const <TopicQuestionRow>[];
        if (questions.isEmpty) {
          return EmptyState(
            title: l10n.topicQuestions,
            message: l10n.grammarSampleNote,
          );
        }
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            for (final question in questions) ...[
              if (question.isDevelopmentSample) Text(l10n.developmentSample),
              TopicQuestionCard(
                promptEn: question.promptEn,
                promptAr: question.promptAr,
                payload: TopicQuestionPayload.parse(question.suggestedAnswer),
                answerController: _controller(question.id),
                onSubmit: () => _submit(question),
              ),
              const SizedBox(height: 16),
            ],
            if (_found.isNotEmpty)
              Text('${l10n.wordsFound}: ${_found.join(', ')}'),
          ],
        );
      },
    );
  }

  Future<void> _submit(TopicQuestionRow question) async {
    final db = ref.read(appDatabaseProvider);
    final text = _controller(question.id).text.trim();
    if (text.isEmpty) return;
    await db.into(db.userTopicAnswers).insert(
          UserTopicAnswersCompanion.insert(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            questionId: question.id,
            answerText: text,
            createdAt: DateTime.now(),
          ),
        );
    final summary = await VocabularyDiscoveryRepository(db).analyzeAndRecord(
      text: text,
      discoveredIn: 'topic',
      sourceId: question.id,
    );
    if (!mounted) return;
    ref.invalidate(catalogProgressProvider);
    ref.invalidate(dashboardStatsProvider);
    setState(() {
      _found = summary.newlyDiscovered.map((word) => word.lemma).toList();
    });
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
