import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/app.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../../progress/presentation/catalog_progress_section.dart';
import '../../topics/presentation/topic_icons.dart';
import '../../topics/presentation/topic_providers.dart';

final catalogWordProvider = FutureProvider.autoDispose
    .family<({VocabularyEntryRow entry, UserVocabularyRow? progress}), String>(
        (ref, id) async {
  final db = ref.watch(appDatabaseProvider);
  final entry = await (db.select(db.vocabularyEntries)
        ..where((row) => row.id.equals(id)))
      .getSingle();
  final progress = await (db.select(db.userVocabulary)
        ..where((row) => row.entryId.equals(id)))
      .getSingleOrNull();
  return (entry: entry, progress: progress);
});

class CatalogWordScreen extends ConsumerWidget {
  const CatalogWordScreen({super.key, required this.entryId});

  final String entryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final word = ref.watch(catalogWordProvider(entryId));
    final pronunciation = ref.watch(pronunciationServiceProvider);
    final accent = ref.watch(settingsProvider).accent;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.vocabulary)),
      body: word.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.wordNotFound)),
        data: (data) {
          final entry = data.entry;
          final progress = data.progress;
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.lemma,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.listen,
                    onPressed: () => pronunciation.speak(
                      entry.lemma,
                      accent: accent,
                    ),
                    icon: const Icon(Icons.volume_up_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  CefrBadge(level: entry.cefrLevel),
                  Chip(label: Text(partOfSpeechLabel(l10n, entry.partOfSpeech))),
                  if (entry.academic) Chip(label: Text(l10n.academicWord)),
                  if (entry.ieltsRelevant) Chip(label: Text(l10n.ieltsRelevant)),
                  if (entry.toeflRelevant) Chip(label: Text(l10n.toeflRelevant)),
                ],
              ),
              const SizedBox(height: 16),
              LexoraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.arabicMeaning),
                    const SizedBox(height: 8),
                    Text(entry.definitionEn),
                    if (entry.phonetic != null) ...[
                      const SizedBox(height: 8),
                      Text(entry.phonetic!),
                    ],
                    const SizedBox(height: 12),
                    Text(
                      entry.exampleSentence,
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _EntryTopics(entryId: entry.id),
              if (progress != null) ...[
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final status in VocabularyStatus.values)
                      ChoiceChip(
                        label: Text(_statusLabel(l10n, status)),
                        selected: progress.status == status.storageValue,
                        onSelected: (_) => _setStatus(ref, status),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                LexoraCard(
                  child: Column(
                    children: [
                      _Row(label: l10n.status, value: progress.status),
                      const Divider(height: 24),
                      _Row(
                        label: l10n.usageCount,
                        value: '${progress.usageCount}',
                      ),
                      const Divider(height: 24),
                      _Row(
                        label: l10n.firstDiscovered,
                        value: _date(progress.firstDiscoveredAt),
                      ),
                      const Divider(height: 24),
                      _Row(
                        label: l10n.lastUsed,
                        value: _date(progress.lastUsedAt),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  String _date(DateTime value) {
    final local = value.toLocal();
    final month = local.month.toString().padLeft(2, '0');
    final day = local.day.toString().padLeft(2, '0');
    return '${local.year}-$month-$day';
  }

  String _statusLabel(AppLocalizations l10n, VocabularyStatus status) {
    return switch (status) {
      VocabularyStatus.discovered => l10n.statusDiscovered,
      VocabularyStatus.learning => l10n.statusLearning,
      VocabularyStatus.reviewing => l10n.statusReviewing,
      VocabularyStatus.mastered => l10n.statusMastered,
    };
  }

  Future<void> _setStatus(WidgetRef ref, VocabularyStatus status) async {
    final db = ref.read(appDatabaseProvider);
    await (db.update(db.userVocabulary)
          ..where((row) => row.entryId.equals(entryId)))
        .write(UserVocabularyCompanion(status: Value(status.storageValue)));
    ref.invalidate(catalogWordProvider(entryId));
    ref.invalidate(catalogProgressProvider);
  }
}

class _EntryTopics extends ConsumerWidget {
  const _EntryTopics({required this.entryId});

  final String entryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(entryTopicsProvider(entryId));
    return topics.maybeWhen(
      data: (items) {
        if (items.isEmpty) return const SizedBox.shrink();
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final topic in items)
              ActionChip(
                label: Text(localizedPair(context, topic.nameEn, topic.nameAr)),
                onPressed: () => context.push('/topics/${topic.topicId}'),
              ),
          ],
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
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
        Text(value),
      ],
    );
  }
}
