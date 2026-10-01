import 'package:drift/drift.dart' hide Column;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/enums.dart';
import '../../../core/database/app_database.dart';
import '../../../core/services/progress/activity_policy.dart';
import '../../../core/services/progress/streak.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../../progress/presentation/catalog_progress_section.dart';

class ProgressSnapshot {
  const ProgressSnapshot({
    required this.wordsPct,
    required this.sentencesPct,
    required this.wordsThisWeek,
    required this.sentencesThisWeek,
    required this.reviewsCompleted,
    required this.currentStreak,
    required this.longestStreak,
    required this.reviewsLast7Days,
  });

  final double wordsPct;
  final double sentencesPct;
  final int wordsThisWeek;
  final int sentencesThisWeek;
  final int reviewsCompleted;
  final int currentStreak;
  final int longestStreak;
  final List<int> reviewsLast7Days;
}

final progressSnapshotProvider = FutureProvider.autoDispose
    .family<ProgressSnapshot, String?>((ref, level) async {
  final db = ref.watch(appDatabaseProvider);
  final weekAgo = DateTime.now().subtract(const Duration(days: 7));

  Future<({int total, int learned, int week})> counts(
    String table,
    ResultSetImplementation reads,
  ) async {
    final levelSql = level == null ? '' : ' AND cefr_level = ?';
    final vars = level == null ? <Variable>[] : [Variable<String>(level)];
    final totals = await db.customSelect(
      'SELECT COUNT(*) AS c FROM $table WHERE 1=1$levelSql',
      variables: vars,
      readsFrom: {reads},
    ).getSingle();
    final learned = await db.customSelect(
      "SELECT COUNT(*) AS c FROM $table WHERE mastery_status != 'new'$levelSql",
      variables: vars,
      readsFrom: {reads},
    ).getSingle();
    final week = await db.customSelect(
      'SELECT COUNT(*) AS c FROM $table WHERE created_at >= ?',
      variables: [Variable<DateTime>(weekAgo)],
      readsFrom: {reads},
    ).getSingle();
    return (
      total: totals.read<int>('c'),
      learned: learned.read<int>('c'),
      week: week.read<int>('c'),
    );
  }

  final words = await counts('words', db.words);
  final sentences = await counts('sentences', db.sentences);
  final reviewed = await (db.selectOnly(db.reviewHistory)
        ..addColumns([db.reviewHistory.reviewedAt]))
      .map((row) => row.read(db.reviewHistory.reviewedAt)!)
      .get();
  final learningDays = await db.select(db.learningDays).get();
  final activity = <DateTime, ({int reviews, int exercises, int activeSeconds})>{};
  for (final value in reviewed) {
    final day = DateTime(value.year, value.month, value.day);
    activity[day] = (reviews: 1, exercises: 0, activeSeconds: 0);
  }
  for (final row in learningDays) {
    final day = DateTime.parse(row.day);
    final current = activity[day];
    activity[day] = (
      reviews: (current?.reviews ?? 0) + row.reviews,
      exercises: row.exercises,
      activeSeconds: row.activeSeconds,
    );
  }
  final streaks = const ActivityStreakPolicy().fromDays(
    [
      for (final entry in activity.entries)
        (
          day: entry.key,
          reviews: entry.value.reviews,
          exercises: entry.value.exercises,
          activeSeconds: entry.value.activeSeconds,
        ),
    ],
  );
  return ProgressSnapshot(
    wordsPct: words.total == 0 ? 0 : words.learned / words.total,
    sentencesPct: sentences.total == 0 ? 0 : sentences.learned / sentences.total,
    wordsThisWeek: words.week,
    sentencesThisWeek: sentences.week,
    reviewsCompleted: reviewed.length,
    currentStreak: streaks.current,
    longestStreak: streaks.longest,
    reviewsLast7Days: reviewsPerDay(reviewed),
  );
});

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen> {
  CefrLevel? _level = CefrLevel.b1;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final snapshot = ref.watch(progressSnapshotProvider(_level?.code));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navProgress)),
      body: snapshot.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => EmptyState(
          title: l10n.errorGeneric,
          message: e.toString(),
          actionLabel: l10n.retry,
          onAction: () => ref.invalidate(progressSnapshotProvider(_level?.code)),
        ),
        data: (data) {
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            children: [
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final level in CefrLevel.values)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(level.code),
                          selected: _level == level,
                          onSelected: (_) => setState(() => _level = level),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: _DonutStat(label: l10n.words, percent: data.wordsPct),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DonutStat(
                      label: l10n.sentences,
                      percent: data.sentencesPct,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sectionGap),
              SectionHeader(title: l10n.learningOverTime),
              const SizedBox(height: AppSpacing.md),
              LexoraCard(
                child: SizedBox(
                  height: 180,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      minY: 0,
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            for (var i = 0; i < data.reviewsLast7Days.length; i++)
                              FlSpot(
                                i.toDouble(),
                                data.reviewsLast7Days[i].toDouble(),
                              ),
                          ],
                          isCurved: true,
                          color: AppColors.primary,
                          barWidth: 3,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppColors.primary.withValues(alpha: 0.12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sectionGap),
              LexoraCard(
                child: Column(
                  children: [
                    _MetricRow(
                      label: l10n.wordsLearnedThisWeek,
                      value: '${data.wordsThisWeek}',
                    ),
                    const Divider(height: 24),
                    _MetricRow(
                      label: l10n.sentencesLearnedThisWeek,
                      value: '${data.sentencesThisWeek}',
                    ),
                    const Divider(height: 24),
                    _MetricRow(
                      label: l10n.reviewsCompleted,
                      value: '${data.reviewsCompleted}',
                    ),
                    const Divider(height: 24),
                    _MetricRow(
                      label: l10n.currentStreak,
                      value: '${data.currentStreak}',
                    ),
                    const Divider(height: 24),
                    _MetricRow(
                      label: l10n.longestStreak,
                      value: '${data.longestStreak}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sectionGap),
              const CatalogProgressSection(),
              const SizedBox(height: AppSpacing.sectionGap),
              LexoraCard(
                onTap: () => context.push('/grammar'),
                child: Row(
                  children: [
                    const Icon(Icons.school_outlined),
                    const SizedBox(width: 12),
                    Expanded(child: Text(l10n.grammarTitle)),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DonutStat extends StatelessWidget {
  const _DonutStat({required this.label, required this.percent});

  final String label;
  final double percent;

  @override
  Widget build(BuildContext context) {
    final pct = (percent * 100).round();
    return LexoraCard(
      child: Column(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: percent == 0 ? 0 : percent.clamp(0.05, 1.0),
                  strokeWidth: 10,
                  backgroundColor: AppColors.border,
                  color: AppColors.primary,
                ),
                Center(
                  child: Text(
                    '$pct%',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(label, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Text(value, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
