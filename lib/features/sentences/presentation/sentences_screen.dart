import 'dart:async';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../../app/app.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/constants/enums.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/services/vocabulary/vocabulary_discovery_repository.dart';
import '../../home/presentation/dashboard_providers.dart';
import '../../progress/presentation/catalog_progress_section.dart';
import '../../../core/widgets/content_filter_sheet.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../../categories/data/category_repository.dart';
import '../../categories/presentation/categories_screen.dart';
import '../../vocabulary/presentation/discovery_summary_dialog.dart';

final sentencesListProvider = StreamProvider.autoDispose
    .family<List<SentenceRow>, SentencesQuery>((ref, query) {
  final db = ref.watch(appDatabaseProvider);
  final select = db.select(db.sentences);

  if (query.cefr != null) {
    select.where((t) => t.cefrLevel.equals(query.cefr!));
  }
  if (query.favoritesOnly) {
    select.where((t) => t.isFavorite.equals(true));
  }
  if (query.mastery != null) {
    select.where((t) => t.masteryStatus.equals(query.mastery!.storageValue));
  }
  if (query.search.trim().isNotEmpty) {
    final term = '%${query.search.trim()}%';
    select.where(
      (t) => t.sentence.like(term) | t.arabicTranslation.like(term),
    );
  }
  if (query.categoryId != null) {
    final sub = db.selectOnly(db.sentenceCategories)
      ..addColumns([db.sentenceCategories.sentenceId])
      ..where(db.sentenceCategories.categoryId.equals(query.categoryId!));
    select.where((t) => t.id.isInQuery(sub));
  }

  switch (query.sort) {
    case ContentSort.alphabetical:
      select.orderBy([(t) => OrderingTerm.asc(t.sentence)]);
    case ContentSort.cefr:
      select.orderBy([(t) => OrderingTerm.asc(t.cefrLevel)]);
    case ContentSort.mostReviewed:
      select.orderBy([(t) => OrderingTerm.desc(t.reviewCount)]);
    case ContentSort.leastReviewed:
      select.orderBy([(t) => OrderingTerm.asc(t.reviewCount)]);
    case ContentSort.mastery:
      select.orderBy([(t) => OrderingTerm.asc(t.masteryStatus)]);
    case ContentSort.recentlyAdded:
      select.orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
  }

  return select.watch();
});

class SentencesQuery {
  const SentencesQuery({
    this.search = '',
    this.cefr,
    this.categoryId,
    this.mastery,
    this.favoritesOnly = false,
    this.sort = ContentSort.recentlyAdded,
  });

  final String search;
  final String? cefr;
  final String? categoryId;
  final MasteryStatus? mastery;
  final bool favoritesOnly;
  final ContentSort sort;

  @override
  bool operator ==(Object other) =>
      other is SentencesQuery &&
      other.search == search &&
      other.cefr == cefr &&
      other.categoryId == categoryId &&
      other.mastery == mastery &&
      other.favoritesOnly == favoritesOnly &&
      other.sort == sort;

  @override
  int get hashCode =>
      Object.hash(search, cefr, categoryId, mastery, favoritesOnly, sort);
}

class SentencesScreen extends ConsumerStatefulWidget {
  const SentencesScreen({super.key});

  @override
  ConsumerState<SentencesScreen> createState() => _SentencesScreenState();
}

class _SentencesScreenState extends ConsumerState<SentencesScreen> {
  final _searchController = TextEditingController();
  final _filterLaunch = ContentFilterLaunch();
  String _search = '';
  ContentFilterState _filters = const ContentFilterState();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openFilters() async {
    if (!_filterLaunch.tryEnter()) return;
    setState(() {});
    try {
      final cached = ref.read(categoriesListProvider).asData?.value;
      final categories = cached ??
          await ref
              .read(categoriesListProvider.future)
              .catchError((_) => <CategoryRow>[]);
      if (!mounted) return;
      final next = await showContentFilterSheet(
        context: context,
        initial: _filters,
        categories: categories,
      );
      if (next != null && mounted) setState(() => _filters = next);
    } finally {
      _filterLaunch.leave();
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final query = SentencesQuery(
      search: _search,
      cefr: _filters.cefr,
      categoryId: _filters.categoryId,
      mastery: _filters.mastery,
      favoritesOnly: _filters.favoritesOnly,
      sort: _filters.sort,
    );
    final async = ref.watch(sentencesListProvider(query));
    final pronunciation = ref.watch(pronunciationServiceProvider);
    final settings = ref.watch(settingsProvider);
    final accent = settings.accent;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.sentences),
        actions: [
          IconButton(
            tooltip: l10n.filters,
            onPressed: _filterLaunch.busy ? null : _openFilters,
            icon: Badge(
              isLabelVisible: _filters.hasActiveFilters,
              child: const Icon(Icons.tune_rounded),
            ),
          ),
          IconButton(
            onPressed: () => context.push('/sentences/add'),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: LexoraSearchField(
              controller: _searchController,
              hintText: l10n.search,
              onChanged: (v) {
                _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 280), () {
                  setState(() => _search = v);
                });
              },
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(l10n.all),
                    selected: _filters.cefr == null,
                    onSelected: (_) => setState(
                      () => _filters = _filters.copyWith(clearCefr: true),
                    ),
                  ),
                ),
                ...CefrLevel.values.map(
                  (level) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(level.code),
                      selected: _filters.cefr == level.code,
                      onSelected: (_) => setState(
                        () => _filters = _filters.copyWith(cefr: level.code),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(l10n.favorites),
                    selected: _filters.favoritesOnly,
                    onSelected: (v) => setState(
                      () => _filters = _filters.copyWith(favoritesOnly: v),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: async.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => EmptyState(
                title: l10n.errorGeneric,
                message: e.toString(),
              ),
              data: (items) {
                if (items.isEmpty) {
                  return EmptyState(
                    title: l10n.noSentencesYet,
                    message: l10n.noSentencesYetMessage,
                    actionLabel: l10n.addYourFirstSentence,
                    onAction: () => context.push('/sentences/add'),
                    icon: Icons.chat_bubble_outline_rounded,
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final s = items[index];
                    return LexoraCard(
                      onTap: () => context.push('/sentences/${s.id}'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: LtrText(
                                  s.sentence,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              IconButton(
                                onPressed: () => pronunciation.speak(
                                  s.sentence,
                                  accent: accent,
                                  speed: settings.playbackSpeed,
                                ),
                                icon: const Icon(Icons.volume_up_rounded),
                                color: AppColors.primary,
                              ),
                              IconButton(
                                tooltip: l10n.speakingPractice,
                                onPressed: () =>
                                    context.push('/speaking?id=${s.id}'),
                                icon: const Icon(Icons.mic_none_rounded),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          RtlText(
                            s.arabicTranslation,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          if (s.notes != null && s.notes!.trim().isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              s.notes!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                          const SizedBox(height: 10),
                          CefrBadge(level: s.cefrLevel),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddSentenceScreen extends ConsumerStatefulWidget {
  const AddSentenceScreen({super.key});

  @override
  ConsumerState<AddSentenceScreen> createState() => _AddSentenceScreenState();
}

class _AddSentenceScreenState extends ConsumerState<AddSentenceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sentenceCtrl = TextEditingController();
  final _translationCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  CefrLevel _cefr = CefrLevel.b1;
  bool _inReview = true;
  bool _reminder = false;
  bool _favorite = false;
  bool _saving = false;
  Set<String> _categoryIds = {};

  @override
  void dispose() {
    _sentenceCtrl.dispose();
    _translationCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final db = ref.read(appDatabaseProvider);
    final now = DateTime.now();
    final id = const Uuid().v4();

    await db.into(db.sentences).insert(
          SentencesCompanion.insert(
            id: id,
            sentence: _sentenceCtrl.text.trim(),
            arabicTranslation: _translationCtrl.text.trim(),
            cefrLevel: _cefr.code,
            notes: Value(
              _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
            ),
            isFavorite: Value(_favorite),
            inReviewSystem: Value(_inReview),
            reminderEnabled: Value(_reminder),
            createdAt: now,
            updatedAt: now,
          ),
        );

    if (_categoryIds.isNotEmpty) {
      await ref
          .read(categoryRepositoryProvider)
          .setSentenceCategories(id, _categoryIds);
    }

    if (_inReview) {
      await db.into(db.reviewItems).insert(
            ReviewItemsCompanion.insert(
              id: const Uuid().v4(),
              itemType: ReviewItemType.sentence.storageValue,
              itemId: id,
              nextReviewAt: now,
              createdAt: now,
              updatedAt: now,
            ),
          );
    }

    final summary = await VocabularyDiscoveryRepository(db).analyzeAndRecord(
      text: _sentenceCtrl.text.trim(),
      discoveredIn: 'sentence',
      sourceId: id,
    );
    ref.invalidate(catalogProgressProvider);
    ref.invalidate(dashboardStatsProvider);

    if (mounted) {
      setState(() => _saving = false);
      await showDiscoverySummary(context, summary);
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addSentence)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _sentenceCtrl,
              textDirection: TextDirection.ltr,
              maxLines: 3,
              decoration: InputDecoration(labelText: l10n.sentences),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _translationCtrl,
              textDirection: TextDirection.rtl,
              maxLines: 3,
              decoration: InputDecoration(labelText: l10n.arabicTranslation),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
            ),
            const SizedBox(height: 16),
            Text(l10n.cefrLevel, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: CefrLevel.values
                  .map(
                    (level) => ChoiceChip(
                      label: Text(level.code),
                      selected: _cefr == level,
                      onSelected: (_) => setState(() => _cefr = level),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesCtrl,
              decoration: InputDecoration(labelText: l10n.notes),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Text(l10n.categories, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            CategoryPicker(
              selectedIds: _categoryIds,
              onChanged: (ids) => setState(() => _categoryIds = ids),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.addToReviewSystem),
              value: _inReview,
              onChanged: (v) => setState(() => _inReview = v),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.addReminderNotification),
              value: _reminder,
              onChanged: (v) => setState(() => _reminder = v),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.favorite),
              value: _favorite,
              onChanged: (v) => setState(() => _favorite = v),
            ),
            const SizedBox(height: 16),
            LexoraPrimaryButton(
              label: l10n.saveSentence,
              isLoading: _saving,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}

class SentenceDetailsScreen extends ConsumerStatefulWidget {
  const SentenceDetailsScreen({super.key, required this.sentenceId});

  final String sentenceId;

  @override
  ConsumerState<SentenceDetailsScreen> createState() =>
      _SentenceDetailsScreenState();
}

class _SentenceDetailsScreenState extends ConsumerState<SentenceDetailsScreen> {
  final _notesCtrl = TextEditingController();
  var _notesReady = false;

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _saveNotes();
    super.deactivate();
  }

  Future<void> _saveNotes() async {
    if (!_notesReady) return;
    final db = ref.read(appDatabaseProvider);
    final text = _notesCtrl.text.trim();
    await (db.update(db.sentences)
          ..where((row) => row.id.equals(widget.sentenceId)))
        .write(
      SentencesCompanion(
        notes: Value(text.isEmpty ? null : text),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final db = ref.watch(appDatabaseProvider);
    final stream = (db.select(db.sentences)
          ..where((row) => row.id.equals(widget.sentenceId)))
        .watchSingleOrNull();

    return StreamBuilder<SentenceRow?>(
      stream: stream,
      builder: (context, snapshot) {
        final sentence = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting &&
            sentence == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (sentence == null) {
          return Scaffold(
            appBar: AppBar(),
            body: EmptyState(
              title: l10n.errorGeneric,
              message: '',
              actionLabel: l10n.backToHome,
              onAction: () => context.go('/home'),
            ),
          );
        }
        if (!_notesReady) {
          _notesCtrl.text = sentence.notes ?? '';
          _notesReady = true;
        }
        final pronunciation = ref.watch(pronunciationServiceProvider);
        final settings = ref.watch(settingsProvider);

        return Scaffold(
          appBar: AppBar(title: Text(l10n.sentences)),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              LtrText(
                sentence.sentence,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              RtlText(
                sentence.arabicTranslation,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              CefrBadge(level: sentence.cefrLevel),
              const SizedBox(height: 20),
              LexoraPrimaryButton(
                label: l10n.listen,
                icon: Icons.volume_up_rounded,
                onPressed: () => pronunciation.speak(
                  sentence.sentence,
                  accent: settings.accent,
                  speed: settings.playbackSpeed,
                ),
              ),
              const SizedBox(height: 24),
              Text(l10n.notes, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              TextField(
                controller: _notesCtrl,
                minLines: 3,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: l10n.noNotesYet,
                  alignLabelWithHint: true,
                ),
                onEditingComplete: _saveNotes,
                onTapOutside: (_) => _saveNotes(),
              ),
            ],
          ),
        );
      },
    );
  }
}
