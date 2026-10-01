import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/services/grammar/grammar_scoring.dart';
import '../../../core/services/progress/activity_policy.dart';
import '../../../core/services/progress/learning_activity_store.dart';
import '../../../core/widgets/lexora_widgets.dart';

final grammarTopicsProvider = StreamProvider<List<GrammarTopicRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.grammarTopics)
        ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]))
      .watch();
});

class GrammarListScreen extends ConsumerWidget {
  const GrammarListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final topics = ref.watch(grammarTopicsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.grammarTitle)),
      body: topics.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (items) {
          if (items.isEmpty) {
            return EmptyState(
              title: l10n.grammarTitle,
              message: l10n.grammarSampleNote,
            );
          }
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            children: [
              Text(l10n.grammarSampleNote),
              const SizedBox(height: 12),
              for (final topic in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: LexoraCard(
                    onTap: () => context.push('/grammar/${topic.id}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Localizations.localeOf(context).languageCode == 'ar'
                              ? topic.titleAr
                              : topic.titleEn,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (topic.cefrLevel != null) ...[
                          const SizedBox(height: 8),
                          CefrBadge(level: topic.cefrLevel!),
                        ],
                        if (topic.isDevelopmentSample) ...[
                          const SizedBox(height: 8),
                          Text(l10n.developmentSample),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class GrammarLessonScreen extends ConsumerStatefulWidget {
  const GrammarLessonScreen({super.key, required this.topicId});

  final String topicId;

  @override
  ConsumerState<GrammarLessonScreen> createState() => _GrammarLessonScreenState();
}

class _GrammarLessonScreenState extends ConsumerState<GrammarLessonScreen> {
  final _answers = <String, TextEditingController>{};
  String? _feedback;

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
    final arabic = Localizations.localeOf(context).languageCode == 'ar';
    return Scaffold(
      appBar: AppBar(title: Text(l10n.grammarTitle)),
      body: FutureBuilder(
        future: _load(db),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final topic = data.topic;
          final lesson = data.lesson;
          final mastered = data.mastered;
          final unlocked = const UnlockPolicy().advancedPracticeUnlocked(mastered);
          final exercises = [
            for (final exercise in data.exercises)
              if (!exercise.isAdvanced || unlocked) exercise,
          ];
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            children: [
              Text(
                arabic ? topic.titleAr : topic.titleEn,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (topic.isDevelopmentSample) Text(l10n.developmentSample),
              Text(topic.classificationNote),
              const SizedBox(height: 12),
              Text(unlocked ? l10n.advancedPracticeUnlocked : l10n.advancedPracticeLocked),
              const SizedBox(height: 16),
              _Block(l10n.grammarUse, arabic ? lesson.useAr : lesson.useEn),
              _Block(l10n.grammarStructure, lesson.structure, ltr: true),
              _Block(l10n.grammarPositive, lesson.positiveExample, ltr: true),
              _Block(l10n.grammarNegative, lesson.negativeExample, ltr: true),
              _Block(l10n.grammarQuestion, lesson.questionExample, ltr: true),
              _Block(
                l10n.grammarMistake,
                '${lesson.mistakeWrong}\n${lesson.mistakeRight}',
                ltr: true,
              ),
              const SizedBox(height: 8),
              Text(l10n.grammarPractice, style: Theme.of(context).textTheme.titleMedium),
              for (final exercise in exercises) ...[
                const SizedBox(height: 12),
                Text(exercise.prompt, textDirection: TextDirection.ltr),
                if (exercise.choicesJson != '[]')
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final choice in _choices(exercise.choicesJson))
                        ChoiceChip(
                          label: Text(choice),
                          selected: _controller(exercise.id).text == choice,
                          onSelected: (_) => setState(
                            () => _controller(exercise.id).text = choice,
                          ),
                        ),
                    ],
                  )
                else
                  TextField(
                    controller: _controller(exercise.id),
                    textDirection: TextDirection.ltr,
                  ),
              ],
              if (_feedback != null) ...[
                const SizedBox(height: 12),
                Text(_feedback!),
              ],
              const SizedBox(height: 16),
              LexoraPrimaryButton(
                label: l10n.grammarCheck,
                onPressed: () => _check(db, exercises),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<({GrammarTopicRow topic, GrammarLessonRow lesson, List<GrammarExerciseRow> exercises, int mastered})>
      _load(AppDatabase db) async {
    final topic = await (db.select(db.grammarTopics)
          ..where((row) => row.id.equals(widget.topicId)))
        .getSingle();
    final lesson = await (db.select(db.grammarLessons)
          ..where((row) => row.topicId.equals(widget.topicId)))
        .getSingle();
    final exercises = await (db.select(db.grammarExercises)
          ..where((row) => row.lessonId.equals(lesson.id))
          ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]))
        .get();
    final mastered = await db.customSelect(
      "SELECT COUNT(*) AS c FROM user_vocabulary WHERE status = 'mastered'",
    ).getSingle();
    return (
      topic: topic,
      lesson: lesson,
      exercises: exercises,
      mastered: mastered.read<int>('c'),
    );
  }

  List<String> _choices(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! List) return const [];
    return [for (final item in decoded) '$item'];
  }

  Future<void> _check(
    AppDatabase db,
    List<GrammarExerciseRow> exercises,
  ) async {
    final score = scoreGrammar([
      for (final exercise in exercises)
        GrammarAnswer(
          prompt: exercise.prompt,
          given: _controller(exercise.id).text,
          expected: exercise.answer,
        ),
    ]);
    final now = DateTime.now();
    final existing = await (db.select(db.userGrammarProgress)
          ..where((row) => row.topicId.equals(widget.topicId)))
        .getSingleOrNull();
    await db.into(db.userGrammarProgress).insertOnConflictUpdate(
          UserGrammarProgressCompanion.insert(
            topicId: widget.topicId,
            status: Value(score.passed ? 'completed' : 'learning'),
            bestScore: Value(
              score.correct > (existing?.bestScore ?? 0)
                  ? score.correct
                  : (existing?.bestScore ?? 0),
            ),
            attempts: Value((existing?.attempts ?? 0) + 1),
            completedAt: Value(score.passed ? now : existing?.completedAt),
            updatedAt: now,
          ),
        );
    await LearningActivityStore(db).add(exercises: 1);
    if (!mounted) return;
    setState(() {
      _feedback = score.passed
          ? AppLocalizations.of(context).grammarCorrect
          : AppLocalizations.of(context).grammarTryAgain;
    });
  }
}

class _Block extends StatelessWidget {
  const _Block(this.title, this.body, {this.ltr = false});

  final String title;
  final String body;
  final bool ltr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: LexoraCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Text(body, textDirection: ltr ? TextDirection.ltr : null),
          ],
        ),
      ),
    );
  }
}
