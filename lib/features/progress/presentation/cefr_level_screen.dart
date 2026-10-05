import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/startup_provider.dart';
import '../../../core/services/progress/learning_activity_store.dart';
import '../../../core/help/context_help_icon.dart';
import '../../../core/help/help_catalog.dart';
import '../../../core/widgets/lexora_widgets.dart';
import 'catalog_progress_section.dart';
import 'cefr_artwork_card.dart';

class CefrLevelWord {
  const CefrLevelWord({
    required this.id,
    required this.lemma,
    required this.pos,
    required this.status,
  });

  final String id;
  final String lemma;
  final String pos;
  final String status;
}

final cefrLevelWordsProvider = FutureProvider.autoDispose
    .family<List<CefrLevelWord>, String>((ref, level) async {
  ref.watch(startupTickProvider);
  ref.watch(catalogProgressProvider);
  final db = ref.watch(appDatabaseProvider);
  final rows = await db.customSelect(
    '''
    SELECT e.id AS id, e.lemma AS lemma, e.part_of_speech AS pos,
           COALESCE(u.status, '') AS status
    FROM vocabulary_entries e
    LEFT JOIN user_vocabulary u ON u.entry_id = e.id
    WHERE e.cefr_level = ?
    ORDER BY e.lemma
    ''',
    variables: [Variable<String>(level.toUpperCase())],
    readsFrom: {db.vocabularyEntries, db.userVocabulary},
  ).get();
  return [
    for (final row in rows)
      CefrLevelWord(
        id: row.read<String>('id'),
        lemma: row.read<String>('lemma'),
        pos: row.read<String>('pos'),
        status: row.read<String>('status'),
      ),
  ];
});

class CefrLevelScreen extends ConsumerStatefulWidget {
  const CefrLevelScreen({super.key, required this.level});

  final String level;

  @override
  ConsumerState<CefrLevelScreen> createState() => _CefrLevelScreenState();
}

class _CefrLevelScreenState extends ConsumerState<CefrLevelScreen> {
  String _query = '';
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _celebrateIfComplete());
  }

  Future<void> _celebrateIfComplete() async {
    final db = ref.read(appDatabaseProvider);
    await AchievementService(db).sync();
    if (!mounted) return;
    final id = 'level-${widget.level.toLowerCase()}';
    final row = await (db.select(db.userAchievements)
          ..where((item) => item.id.equals(id)))
        .getSingleOrNull();
    if (row == null || row.celebrated || !mounted) return;
    final l10n = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.masterpieceCompleted(widget.level.toUpperCase())),
        content: Text(l10n.collectionNotOfficialLevel),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.done),
          ),
        ],
      ),
    );
    await AchievementService(db).markCelebrated(id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final code = widget.level.toUpperCase();
    final progress = ref.watch(catalogProgressProvider);
    final words = ref.watch(cefrLevelWordsProvider(code));

    return Scaffold(
      appBar: AppBar(
        title: Text(code, textDirection: TextDirection.ltr),
        actions: const [
          ContextHelpIcon(topic: HelpTopic.levelArtwork),
        ],
      ),
      body: progress.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => EmptyState(
          title: l10n.errorGeneric,
          message: error.toString(),
          actionLabel: l10n.retry,
          onAction: () => ref.invalidate(catalogProgressProvider),
        ),
        data: (data) {
          final mastered = data.masteredByLevel[code] ?? 0;
          final total = data.totals[code] ?? 0;
          final discovered = data.discovered[code] ?? 0;
          final learning = data.learning[code] ?? 0;
          final remaining = total - mastered < 0 ? 0 : total - mastered;
          final list = words.asData?.value ?? const <CefrLevelWord>[];
          final shown = [
            for (final word in list)
              if (_matches(word)) word,
          ];
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.screenPadding),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    CefrArtworkCard(
                      level: code,
                      mastered: mastered,
                      total: total,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(l10n.collectionNotOfficialLevel),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(label: Text(l10n.masteredCountOfTotal(mastered, total))),
                        Chip(label: Text(l10n.wordsRemainingCount(remaining))),
                        Chip(label: Text('${l10n.statusDiscovered} $discovered')),
                        Chip(label: Text('${l10n.statusLearning} $learning')),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search_rounded),
                        hintText: l10n.search,
                      ),
                      onChanged: (value) =>
                          setState(() => _query = value.trim().toLowerCase()),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final filter in [
                          'all',
                          'mastered',
                          'learning',
                          'discovered',
                          'remaining',
                        ])
                          FilterChip(
                            label: Text(_filterLabel(l10n, filter)),
                            selected: _filter == filter,
                            onSelected: (_) => setState(() => _filter = filter),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    if (words.isLoading) const LinearProgressIndicator(),
                  ]),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final word = shown[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenPadding,
                      ),
                      title: Text(word.lemma, textDirection: TextDirection.ltr),
                      subtitle: Text(
                        word.status.isEmpty ? l10n.artNotStarted : word.status,
                        textDirection: TextDirection.ltr,
                      ),
                      onTap: () => context.push('/vocabulary/${word.id}'),
                    );
                  },
                  childCount: shown.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  bool _matches(CefrLevelWord word) {
    if (_query.isNotEmpty && !word.lemma.toLowerCase().contains(_query)) {
      return false;
    }
    return switch (_filter) {
      'mastered' => word.status == 'mastered',
      'learning' => word.status == 'learning' || word.status == 'reviewing',
      'discovered' => word.status == 'discovered',
      'remaining' => word.status != 'mastered',
      _ => true,
    };
  }

  String _filterLabel(AppLocalizations l10n, String filter) {
    return switch (filter) {
      'mastered' => l10n.statusMastered,
      'learning' => l10n.statusLearning,
      'discovered' => l10n.statusDiscovered,
      'remaining' => l10n.remaining,
      _ => l10n.all,
    };
  }
}
