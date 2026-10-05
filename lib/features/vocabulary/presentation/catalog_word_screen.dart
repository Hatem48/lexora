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
import '../../../core/services/progress/learning_activity_store.dart';
import '../../../core/services/vocabulary/mastery_policy.dart';
import '../../../core/services/vocabulary/word_form_slots.dart';
import '../../../core/help/context_help_icon.dart';
import '../../../core/help/help_catalog.dart';
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
    final settings = ref.watch(settingsProvider);
    final accent = settings.accent;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.vocabulary),
        actions: const [
          ContextHelpIcon(topic: HelpTopic.vocabularyDiscovery),
        ],
      ),
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
                      speed: settings.playbackSpeed,
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
                  if (entry.academic) ...[
                    Chip(label: Text(l10n.academicWord)),
                    const ContextHelpIcon(topic: HelpTopic.academicTag),
                  ],
                  _RankTags(entryId: entry.id),
                ],
              ),
              const SizedBox(height: 16),
              _DetailBlock(
                icon: Icons.public_rounded,
                title: l10n.arabicMeaning,
                text: _firstNonEmpty(
                  progress?.userArabicMeaning,
                  entry.arabicMeaning,
                ),
                empty: l10n.definitionUnavailable,
                direction: TextDirection.rtl,
              ),
              _DetailBlock(
                icon: Icons.menu_book_outlined,
                title: l10n.definition,
                text: entry.definitionEn,
                empty: l10n.definitionUnavailable,
                direction: TextDirection.ltr,
              ),
              _DetailBlock(
                icon: Icons.chat_bubble_outline_rounded,
                title: l10n.exampleSentence,
                text: _firstNonEmpty(progress?.userExample, entry.exampleSentence),
                empty: l10n.exampleUnavailable,
                direction: TextDirection.ltr,
              ),
              _FormsBlock(entry: entry),
              _DetailBlock(
                icon: Icons.school_outlined,
                title: l10n.grammarUsageUnavailable,
                text: '',
                empty: l10n.grammarUsageUnavailable,
                direction: TextDirection.ltr,
              ),
              if (progress != null)
                _CompletionForm(entryId: entry.id, progress: progress),
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

  String _firstNonEmpty(String? primary, String fallback) {
    if (primary != null && primary.trim().isNotEmpty) return primary.trim();
    return fallback.trim();
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
    await AchievementService(db).sync();
    ref.invalidate(catalogWordProvider(entryId));
    ref.invalidate(catalogProgressProvider);
  }
}

class _DetailBlock extends StatelessWidget {
  const _DetailBlock({
    required this.icon,
    required this.title,
    required this.text,
    required this.empty,
    required this.direction,
  });

  final IconData icon;
  final String title;
  final String text;
  final String empty;
  final TextDirection direction;

  @override
  Widget build(BuildContext context) {
    final missing = text.trim().isEmpty;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: LexoraCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              missing ? empty : text,
              textDirection: direction,
            ),
          ],
        ),
      ),
    );
  }
}

class _FormsBlock extends ConsumerWidget {
  const _FormsBlock({required this.entry});

  final VocabularyEntryRow entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final db = ref.watch(appDatabaseProvider);
    final forms = (db.select(db.vocabularyForms)
          ..where((row) => row.entryId.equals(entry.id)))
        .watch();
    return StreamBuilder(
      stream: forms,
      builder: (context, snapshot) {
        final surfaces = [
          for (final row in snapshot.data ?? <VocabularyFormRow>[]) row.surface,
        ];
        final slots = WordFormSlots.fromCatalog(
          partOfSpeech: entry.partOfSpeech,
          lemma: entry.lemma,
          surfaces: surfaces,
        );
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: LexoraCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.wordForms,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    const ContextHelpIcon(topic: HelpTopic.wordForms),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  slots.hasAny ? surfaces.join(', ') : l10n.formsUnavailable,
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RankTags extends ConsumerWidget {
  const _RankTags({required this.entryId});

  final String entryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final db = ref.watch(appDatabaseProvider);
    final rank = (db.select(db.vocabularyEntryRanks)
          ..where((row) => row.entryId.equals(entryId)))
        .watchSingleOrNull();
    return StreamBuilder(
      stream: rank,
      builder: (context, snapshot) {
        final row = snapshot.data;
        return Wrap(
          spacing: 8,
          children: [
            if (row?.frequencyRank != null) Chip(label: Text(l10n.generalTag)),
            if (row?.spokenRelevance != null) ...[
              Chip(label: Text(l10n.spokenTag)),
              const ContextHelpIcon(topic: HelpTopic.spokenTag),
            ],
          ],
        );
      },
    );
  }
}

class _CompletionForm extends ConsumerStatefulWidget {
  const _CompletionForm({required this.entryId, required this.progress});

  final String entryId;
  final UserVocabularyRow progress;

  @override
  ConsumerState<_CompletionForm> createState() => _CompletionFormState();
}

class _CompletionFormState extends ConsumerState<_CompletionForm> {
  late final TextEditingController _meaning;
  late final TextEditingController _example;
  late final TextEditingController _translation;

  @override
  void initState() {
    super.initState();
    _meaning = TextEditingController(text: widget.progress.userArabicMeaning ?? '');
    _example = TextEditingController(text: widget.progress.userExample ?? '');
    _translation = TextEditingController(
      text: widget.progress.userExampleTranslation ?? '',
    );
  }

  @override
  void dispose() {
    _meaning.dispose();
    _example.dispose();
    _translation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        TextFormField(
          controller: _meaning,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(labelText: l10n.arabicMeaning),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _example,
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(labelText: l10n.exampleSentence),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _translation,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(labelText: l10n.arabicTranslation),
        ),
        const SizedBox(height: 12),
        LexoraPrimaryButton(
          label: l10n.saveCompletion,
          onPressed: () async {
            final db = ref.read(appDatabaseProvider);
            final meaning = _meaning.text.trim();
            final status = widget.progress.status ==
                    VocabularyStatus.mastered.storageValue
                ? widget.progress.status
                : const MasteryPolicy().statusAfterCompletion(
                    hasMeaning: meaning.isNotEmpty,
                  );
            await (db.update(db.userVocabulary)
                  ..where((row) => row.entryId.equals(widget.entryId)))
                .write(
              UserVocabularyCompanion(
                userArabicMeaning: Value(meaning.isEmpty ? null : meaning),
                userExample: Value(
                  _example.text.trim().isEmpty ? null : _example.text.trim(),
                ),
                userExampleTranslation: Value(
                  _translation.text.trim().isEmpty
                      ? null
                      : _translation.text.trim(),
                ),
                status: Value(status),
                lastUsedAt: Value(DateTime.now()),
              ),
            );
            ref.invalidate(catalogWordProvider(widget.entryId));
            ref.invalidate(catalogProgressProvider);
          },
        ),
      ],
    );
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
