import 'dart:async';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../../app/app.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/widgets/content_filter_sheet.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../../categories/data/category_repository.dart';
import '../../categories/presentation/categories_screen.dart';

final wordsListProvider =
    StreamProvider.autoDispose.family<List<WordRow>, WordsQuery>((ref, query) {
  final db = ref.watch(appDatabaseProvider);
  final select = db.select(db.words);

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
      (t) => t.word.like(term) | t.arabicMeaning.like(term),
    );
  }
  if (query.categoryId != null) {
    final sub = db.selectOnly(db.wordCategories)
      ..addColumns([db.wordCategories.wordId])
      ..where(db.wordCategories.categoryId.equals(query.categoryId!));
    select.where((t) => t.id.isInQuery(sub));
  }

  switch (query.sort) {
    case ContentSort.alphabetical:
      select.orderBy([(t) => OrderingTerm.asc(t.word)]);
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

class WordsQuery {
  const WordsQuery({
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
      other is WordsQuery &&
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

class WordsScreen extends ConsumerStatefulWidget {
  const WordsScreen({super.key});

  @override
  ConsumerState<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends ConsumerState<WordsScreen> {
  final _searchController = TextEditingController();
  String _search = '';
  ContentFilterState _filters = const ContentFilterState();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 280), () {
      setState(() => _search = value);
    });
  }

  Future<void> _openFilters() async {
    final categories = await ref
        .read(categoriesListProvider.future)
        .catchError((_) => <CategoryRow>[]);
    if (!mounted) return;
    final next = await showContentFilterSheet(
      context: context,
      initial: _filters,
      categories: categories,
    );
    if (next != null && mounted) setState(() => _filters = next);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final query = WordsQuery(
      search: _search,
      cefr: _filters.cefr,
      categoryId: _filters.categoryId,
      mastery: _filters.mastery,
      favoritesOnly: _filters.favoritesOnly,
      sort: _filters.sort,
    );
    final wordsAsync = ref.watch(wordsListProvider(query));
    final pronunciation = ref.watch(pronunciationServiceProvider);
    final accent = ref.watch(settingsProvider).accent;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.words),
        actions: [
          IconButton(
            tooltip: l10n.filters,
            onPressed: _openFilters,
            icon: Badge(
              isLabelVisible: _filters.hasActiveFilters,
              child: const Icon(Icons.tune_rounded),
            ),
          ),
          IconButton(
            onPressed: () => context.push('/words/add'),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding,
              0,
              AppSpacing.screenPadding,
              AppSpacing.sm,
            ),
            child: LexoraSearchField(
              controller: _searchController,
              hintText: l10n.search,
              onChanged: _onSearch,
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
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
                ...CefrLevel.values.map((level) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(level.code),
                      selected: _filters.cefr == level.code,
                      onSelected: (_) => setState(
                        () => _filters = _filters.copyWith(cefr: level.code),
                      ),
                    ),
                  );
                }),
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
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: wordsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => EmptyState(
                title: l10n.errorGeneric,
                message: e.toString(),
                actionLabel: l10n.retry,
                onAction: () => ref.invalidate(wordsListProvider(query)),
              ),
              data: (words) {
                if (words.isEmpty) {
                  return EmptyState(
                    title: l10n.noWordsYet,
                    message: l10n.noWordsYetMessage,
                    actionLabel: l10n.addYourFirstWord,
                    onAction: () => context.push('/words/add'),
                    icon: Icons.menu_book_outlined,
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding,
                    AppSpacing.sm,
                    AppSpacing.screenPadding,
                    AppSpacing.xxxl,
                  ),
                  itemCount: words.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final word = words[index];
                    return LexoraCard(
                      onTap: () => context.push('/words/${word.id}'),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LtrText(
                                  word.word,
                                  style:
                                      Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 4),
                                RtlText(
                                  word.arabicMeaning,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    CefrBadge(level: word.cefrLevel),
                                    const SizedBox(width: 8),
                                    Text(
                                      word.partOfSpeech,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            tooltip: l10n.pronunciation,
                            onPressed: () => pronunciation.speak(
                              word.word,
                              accent: accent,
                            ),
                            icon: const Icon(Icons.volume_up_rounded),
                            color: AppColors.primary,
                          ),
                          Icon(
                            word.isFavorite
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: word.isFavorite
                                ? AppColors.warning
                                : AppColors.textTertiary,
                          ),
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

class AddWordScreen extends ConsumerStatefulWidget {
  const AddWordScreen({super.key});

  @override
  ConsumerState<AddWordScreen> createState() => _AddWordScreenState();
}

class _AddWordScreenState extends ConsumerState<AddWordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _wordCtrl = TextEditingController();
  final _meaningCtrl = TextEditingController();
  final _exampleCtrl = TextEditingController();
  final _exampleArCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  CefrLevel _cefr = CefrLevel.b1;
  PartOfSpeech _pos = PartOfSpeech.noun;
  bool _inReview = true;
  bool _saving = false;
  Set<String> _categoryIds = {};

  @override
  void dispose() {
    _wordCtrl.dispose();
    _meaningCtrl.dispose();
    _exampleCtrl.dispose();
    _exampleArCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _save({required bool addAnother}) async {
    final l10n = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final db = ref.read(appDatabaseProvider);
    final word = _wordCtrl.text.trim();

    final existing = await (db.select(db.words)
          ..where((t) => t.word.lower().equals(word.toLowerCase())))
        .get();
    if (existing.isNotEmpty && mounted) {
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.wordAlreadyExists)),
      );
      return;
    }

    final now = DateTime.now();
    final id = const Uuid().v4();
    await db.into(db.words).insert(
          WordsCompanion.insert(
            id: id,
            word: word,
            arabicMeaning: _meaningCtrl.text.trim(),
            cefrLevel: _cefr.code,
            partOfSpeech: _pos.storageValue,
            exampleSentence: Value(
              _exampleCtrl.text.trim().isEmpty
                  ? null
                  : _exampleCtrl.text.trim(),
            ),
            exampleTranslation: Value(
              _exampleArCtrl.text.trim().isEmpty
                  ? null
                  : _exampleArCtrl.text.trim(),
            ),
            notes: Value(
              _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
            ),
            inReviewSystem: Value(_inReview),
            createdAt: now,
            updatedAt: now,
          ),
        );

    if (_categoryIds.isNotEmpty) {
      await ref
          .read(categoryRepositoryProvider)
          .setWordCategories(id, _categoryIds);
    }

    if (_inReview) {
      await db.into(db.reviewItems).insert(
            ReviewItemsCompanion.insert(
              id: const Uuid().v4(),
              itemType: ReviewItemType.word.storageValue,
              itemId: id,
              nextReviewAt: now,
              createdAt: now,
              updatedAt: now,
            ),
          );
    }

    if (!mounted) return;
    setState(() => _saving = false);
    if (addAnother) {
      _formKey.currentState!.reset();
      _wordCtrl.clear();
      _meaningCtrl.clear();
      _exampleCtrl.clear();
      _exampleArCtrl.clear();
      _notesCtrl.clear();
      setState(() => _categoryIds = {});
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addWord)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            TextFormField(
              controller: _wordCtrl,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(labelText: l10n.word),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _meaningCtrl,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(labelText: l10n.arabicMeaning),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.cefrLevel, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: CefrLevel.values.map((level) {
                return ChoiceChip(
                  label: Text(level.code),
                  selected: _cefr == level,
                  onSelected: (_) => setState(() => _cefr = level),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
            DropdownButtonFormField<PartOfSpeech>(
              // ignore: deprecated_member_use
              value: _pos,
              decoration: InputDecoration(labelText: l10n.partOfSpeech),
              items: PartOfSpeech.values
                  .map(
                    (p) => DropdownMenuItem(
                      value: p,
                      child: Text(partOfSpeechLabel(l10n, p.storageValue)),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _pos = v ?? _pos),
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _exampleCtrl,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(labelText: l10n.exampleSentence),
              maxLines: 2,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _exampleArCtrl,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(labelText: l10n.arabicTranslation),
              maxLines: 2,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _notesCtrl,
              decoration: InputDecoration(labelText: l10n.notes),
              maxLines: 3,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.categories, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppSpacing.sm),
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
            const SizedBox(height: AppSpacing.lg),
            LexoraPrimaryButton(
              label: l10n.saveWord,
              isLoading: _saving,
              onPressed: () => _save(addAnother: false),
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: _saving ? null : () => _save(addAnother: true),
              child: Text(l10n.saveAndAddAnother),
            ),
          ],
        ),
      ),
    );
  }
}

class WordDetailsScreen extends ConsumerWidget {
  const WordDetailsScreen({super.key, required this.wordId});

  final String wordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final db = ref.watch(appDatabaseProvider);
    final stream = (db.select(db.words)..where((t) => t.id.equals(wordId)))
        .watchSingleOrNull();

    return StreamBuilder<WordRow?>(
      stream: stream,
      builder: (context, snapshot) {
        final word = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting &&
            word == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (word == null) {
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

        final pronunciation = ref.watch(pronunciationServiceProvider);
        final accent = ref.watch(settingsProvider).accent;

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () async {
                  await (db.update(db.words)..where((t) => t.id.equals(word.id)))
                      .write(
                    WordsCompanion(
                      isFavorite: Value(!word.isFavorite),
                      updatedAt: Value(DateTime.now()),
                    ),
                  );
                },
                icon: Icon(
                  word.isFavorite ? Icons.star_rounded : Icons.star_outline,
                  color: word.isFavorite ? AppColors.warning : null,
                ),
              ),
              IconButton(
                onPressed: () async {
                  final ok = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l10n.confirmDelete),
                      content: Text(l10n.confirmDeleteMessage),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(l10n.cancel),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(l10n.delete),
                        ),
                      ],
                    ),
                  );
                  if (ok == true) {
                    await db.transaction(() async {
                      await (db.delete(db.wordCategories)
                            ..where((t) => t.wordId.equals(word.id)))
                          .go();
                      await (db.delete(db.sentenceWords)
                            ..where((t) => t.wordId.equals(word.id)))
                          .go();
                      final reviews = await (db.select(db.reviewItems)
                            ..where(
                              (t) =>
                                  t.itemId.equals(word.id) &
                                  t.itemType.equals(
                                    ReviewItemType.word.storageValue,
                                  ),
                            ))
                          .get();
                      for (final review in reviews) {
                        await (db.delete(db.reviewHistory)
                              ..where((t) => t.reviewItemId.equals(review.id)))
                            .go();
                      }
                      await (db.delete(db.reviewItems)
                            ..where(
                              (t) =>
                                  t.itemId.equals(word.id) &
                                  t.itemType.equals(
                                    ReviewItemType.word.storageValue,
                                  ),
                            ))
                          .go();
                      await (db.delete(db.words)
                            ..where((t) => t.id.equals(word.id)))
                          .go();
                    });
                    if (context.mounted) context.pop();
                  }
                },
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            children: [
              LtrText(
                word.word,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              if (word.phonetic != null) ...[
                const SizedBox(height: 6),
                LtrText(
                  word.phonetic!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
              const SizedBox(height: 8),
              RtlText(
                word.arabicMeaning,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: 8,
                children: [
                  CefrBadge(level: word.cefrLevel),
                  Chip(label: Text(partOfSpeechLabel(l10n, word.partOfSpeech))),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              LexoraPrimaryButton(
                label: l10n.listen,
                icon: Icons.volume_up_rounded,
                onPressed: () =>
                    pronunciation.speak(word.word, accent: accent),
              ),
              if (word.exampleSentence != null) ...[
                const SizedBox(height: AppSpacing.sectionGap),
                Text(l10n.examples,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: AppSpacing.sm),
                LexoraCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LtrText(word.exampleSentence!),
                      if (word.exampleTranslation != null) ...[
                        const SizedBox(height: 8),
                        RtlText(
                          word.exampleTranslation!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
              if (word.notes != null && word.notes!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sectionGap),
                Text(l10n.notes,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: AppSpacing.sm),
                LexoraCard(child: Text(word.notes!)),
              ],
            ],
          ),
        );
      },
    );
  }
}
