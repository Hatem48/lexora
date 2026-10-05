import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/enums.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/startup_provider.dart';
import '../../../core/help/context_help_icon.dart';
import '../../../core/help/help_catalog.dart';
import '../../../core/widgets/lexora_widgets.dart';

class CatalogProgress {
  const CatalogProgress({
    required this.totals,
    required this.discovered,
    required this.learning,
    required this.masteredByLevel,
    required this.mastered,
    required this.academic,
    required this.ielts,
    required this.toefl,
    required this.discoveredThisWeek,
  });

  final Map<String, int> totals;
  final Map<String, int> discovered;
  final Map<String, int> learning;
  final Map<String, int> masteredByLevel;
  final int mastered;
  final int academic;
  final int ielts;
  final int toefl;
  final int discoveredThisWeek;
}

final catalogProgressProvider = FutureProvider<CatalogProgress>((ref) async {
  ref.watch(startupTickProvider);
  final db = ref.watch(appDatabaseProvider);
  final weekAgo = DateTime.now().subtract(const Duration(days: 7));

  Future<Map<String, int>> grouped(String sql) async {
    final rows = await db.customSelect(
      sql,
      readsFrom: {db.vocabularyEntries, db.userVocabulary},
    ).get();
    return {
      for (final row in rows) row.read<String>('level'): row.read<int>('c'),
    };
  }

  final totals = await grouped(
    'SELECT cefr_level AS level, COUNT(*) AS c FROM vocabulary_entries GROUP BY cefr_level',
  );
  final discovered = await grouped(
    '''
    SELECT e.cefr_level AS level, COUNT(*) AS c
    FROM user_vocabulary u
    JOIN vocabulary_entries e ON e.id = u.entry_id
    WHERE u.status = 'discovered'
    GROUP BY e.cefr_level
    ''',
  );
  final learning = await grouped(
    '''
    SELECT e.cefr_level AS level, COUNT(*) AS c
    FROM user_vocabulary u
    JOIN vocabulary_entries e ON e.id = u.entry_id
    WHERE u.status IN ('learning', 'reviewing')
    GROUP BY e.cefr_level
    ''',
  );
  final masteredByLevel = await grouped(
    '''
    SELECT e.cefr_level AS level, COUNT(*) AS c
    FROM user_vocabulary u
    JOIN vocabulary_entries e ON e.id = u.entry_id
    WHERE u.status = 'mastered'
    GROUP BY e.cefr_level
    ''',
  );

  Future<int> count(String sql, {List<Variable> variables = const []}) async {
    final row = await db.customSelect(
      sql,
      variables: variables,
      readsFrom: {db.vocabularyEntries, db.userVocabulary},
    ).getSingle();
    return row.read<int>('c');
  }

  return CatalogProgress(
    totals: totals,
    discovered: discovered,
    learning: learning,
    masteredByLevel: masteredByLevel,
    mastered: await count(
      "SELECT COUNT(*) AS c FROM user_vocabulary WHERE status = 'mastered'",
    ),
    academic: await count(
      '''
      SELECT COUNT(*) AS c
      FROM user_vocabulary u
      JOIN vocabulary_entries e ON e.id = u.entry_id
      WHERE e.academic = 1
      ''',
    ),
    ielts: await count(
      '''
      SELECT COUNT(*) AS c
      FROM user_vocabulary u
      JOIN vocabulary_entries e ON e.id = u.entry_id
      WHERE e.ielts_relevant = 1
      ''',
    ),
    toefl: await count(
      '''
      SELECT COUNT(*) AS c
      FROM user_vocabulary u
      JOIN vocabulary_entries e ON e.id = u.entry_id
      WHERE e.toefl_relevant = 1
      ''',
    ),
    discoveredThisWeek: await count(
      'SELECT COUNT(*) AS c FROM user_vocabulary WHERE first_discovered_at >= ?',
      variables: [Variable<DateTime>(weekAgo)],
    ),
  );
});

class CatalogProgressSection extends ConsumerWidget {
  const CatalogProgressSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final stats = ref.watch(catalogProgressProvider);
    return stats.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.catalogProgress,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const ContextHelpIcon(topic: HelpTopic.vocabularyProgress),
            ],
          ),
          const SizedBox(height: 4),
          Text(l10n.catalogStatsNote),
          const SizedBox(height: 12),
          LexoraCard(
            child: Column(
              children: [
                for (final level in CefrLevel.values) ...[
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      level.code,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _Metric(
                    label: l10n.masteredProgress(
                      data.masteredByLevel[level.code] ?? 0,
                      data.totals[level.code] ?? 0,
                    ),
                    value: '',
                    help: level == CefrLevel.a1 ? HelpTopic.masteredWords : null,
                  ),
                  _Metric(
                    label: l10n.learningProgressCount(
                      data.learning[level.code] ?? 0,
                    ),
                    value: '',
                    help: level == CefrLevel.a1 ? HelpTopic.learningWords : null,
                  ),
                  _Metric(
                    label: l10n.discoveredProgressCount(
                      data.discovered[level.code] ?? 0,
                    ),
                    value: '',
                    help: level == CefrLevel.a1
                        ? HelpTopic.discoveredWords
                        : null,
                  ),
                  if (level != CefrLevel.c2) const Divider(height: 20),
                ],
                const SizedBox(height: 8),
                Text(l10n.levelCollectionNote),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          LexoraCard(
            child: Column(
              children: [
                _Metric(
                  label: l10n.masteredCatalog,
                  value: '${data.mastered}',
                ),
                const Divider(height: 24),
                _Metric(
                  label: l10n.academicCatalog,
                  value: '${data.academic}',
                  help: HelpTopic.academicTag,
                ),
                const Divider(height: 24),
                _Metric(label: l10n.ieltsRelevant, value: '${data.ielts}'),
                const Divider(height: 24),
                _Metric(label: l10n.toeflRelevant, value: '${data.toefl}'),
                const Divider(height: 24),
                _Metric(
                  label: l10n.discoveredThisWeek,
                  value: '${data.discoveredThisWeek}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value, this.help});

  final String label;
  final String value;
  final HelpTopic? help;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (help != null) ContextHelpIcon(topic: help!),
        Expanded(child: Text(label)),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
