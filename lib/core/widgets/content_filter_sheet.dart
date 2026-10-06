import 'package:flutter/material.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/enums.dart';
import '../../../core/database/app_database.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../../features/categories/presentation/category_icons.dart';

class ContentFilterState {
  const ContentFilterState({
    this.cefr,
    this.categoryId,
    this.mastery,
    this.favoritesOnly = false,
    this.sort = ContentSort.recentlyAdded,
  });

  final String? cefr;
  final String? categoryId;
  final MasteryStatus? mastery;
  final bool favoritesOnly;
  final ContentSort sort;

  ContentFilterState copyWith({
    String? cefr,
    bool clearCefr = false,
    String? categoryId,
    bool clearCategory = false,
    MasteryStatus? mastery,
    bool clearMastery = false,
    bool? favoritesOnly,
    ContentSort? sort,
  }) {
    return ContentFilterState(
      cefr: clearCefr ? null : (cefr ?? this.cefr),
      categoryId: clearCategory ? null : (categoryId ?? this.categoryId),
      mastery: clearMastery ? null : (mastery ?? this.mastery),
      favoritesOnly: favoritesOnly ?? this.favoritesOnly,
      sort: sort ?? this.sort,
    );
  }

  bool get hasActiveFilters =>
      cefr != null ||
      categoryId != null ||
      mastery != null ||
      favoritesOnly ||
      sort != ContentSort.recentlyAdded;
}

/// Ignores extra taps while a filter sheet is already opening.
class ContentFilterLaunch {
  bool _busy = false;

  bool get busy => _busy;

  bool tryEnter() {
    if (_busy) return false;
    _busy = true;
    return true;
  }

  void leave() {
    _busy = false;
  }
}

/// Opens the filter sheet without waiting for [loadCategories].
///
/// Category rows already in memory are shown immediately. Otherwise the sheet
/// opens on the first frame and fills the category section when the future completes.
Future<ContentFilterState?> openContentFilters({
  required ContentFilterLaunch launch,
  required List<CategoryRow>? cached,
  required Future<List<CategoryRow>> Function() loadCategories,
  required Future<ContentFilterState?> Function(
    List<CategoryRow> categories,
    Future<List<CategoryRow>>? categoriesFuture,
  ) show,
}) async {
  if (!launch.tryEnter()) return null;
  try {
    final pending = cached == null ? loadCategories() : null;
    return await show(cached ?? const [], pending);
  } finally {
    launch.leave();
  }
}

Future<ContentFilterState?> showContentFilterSheet({
  required BuildContext context,
  required ContentFilterState initial,
  required List<CategoryRow> categories,
  Future<List<CategoryRow>>? categoriesFuture,
  bool showMastery = true,
}) {
  return showModalBottomSheet<ContentFilterState>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (context) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.92,
        ),
        child: _ContentFilterSheet(
          initial: initial,
          categories: categories,
          categoriesFuture: categoriesFuture,
          showMastery: showMastery,
        ),
      );
    },
  );
}

class _ContentFilterSheet extends StatefulWidget {
  const _ContentFilterSheet({
    required this.initial,
    required this.categories,
    required this.categoriesFuture,
    required this.showMastery,
  });

  final ContentFilterState initial;
  final List<CategoryRow> categories;
  final Future<List<CategoryRow>>? categoriesFuture;
  final bool showMastery;

  @override
  State<_ContentFilterSheet> createState() => _ContentFilterSheetState();
}

class _ContentFilterSheetState extends State<_ContentFilterSheet> {
  late ContentFilterState _state;
  late List<CategoryRow> _categories;
  var _loadingCategories = false;

  @override
  void initState() {
    super.initState();
    _state = widget.initial;
    _categories = widget.categories;
    final pending = widget.categoriesFuture;
    if (pending == null) return;
    _loadingCategories = true;
    pending.then((rows) {
      if (!mounted) return;
      setState(() {
        _categories = rows;
        _loadingCategories = false;
      });
    }, onError: (_, _) {
      if (!mounted) return;
      setState(() => _loadingCategories = false);
    });
  }

  String _sortLabel(AppLocalizations l10n, ContentSort sort) {
    return switch (sort) {
      ContentSort.recentlyAdded => l10n.sortRecentlyAdded,
      ContentSort.alphabetical => l10n.sortAlphabetical,
      ContentSort.cefr => l10n.sortCefr,
      ContentSort.mostReviewed => l10n.sortMostReviewed,
      ContentSort.leastReviewed => l10n.sortLeastReviewed,
      ContentSort.mastery => l10n.sortMastery,
    };
  }

  String _masteryLabel(AppLocalizations l10n, MasteryStatus status) {
    return switch (status) {
      MasteryStatus.newItem => l10n.masteryNew,
      MasteryStatus.learning => l10n.masteryLearning,
      MasteryStatus.reviewing => l10n.masteryReviewing,
      MasteryStatus.mastered => l10n.mastered,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.filters,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      _state = const ContentFilterState();
                    }),
                    child: Text(l10n.clearFilters),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(l10n.cefrLevel, style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilterChip(
                    label: Text(l10n.all),
                    selected: _state.cefr == null,
                    onSelected: (_) => setState(
                      () => _state = _state.copyWith(clearCefr: true),
                    ),
                  ),
                  ...CefrLevel.values.map(
                    (level) => FilterChip(
                      label: Text(level.code),
                      selected: _state.cefr == level.code,
                      onSelected: (_) => setState(
                        () => _state = _state.copyWith(cefr: level.code),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(l10n.categories, style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilterChip(
                    label: Text(l10n.all),
                    selected: _state.categoryId == null,
                    onSelected: (_) => setState(
                      () => _state = _state.copyWith(clearCategory: true),
                    ),
                  ),
                  if (_loadingCategories)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ..._categories.map((c) {
                    final label = isRtl && (c.nameAr?.isNotEmpty ?? false)
                        ? c.nameAr!
                        : c.name;
                    return FilterChip(
                      avatar: Icon(categoryIcon(c.iconName), size: 16),
                      label: Text(label),
                      selected: _state.categoryId == c.id,
                      onSelected: (_) => setState(
                        () => _state = _state.copyWith(categoryId: c.id),
                      ),
                    );
                  }),
                ],
              ),
              if (widget.showMastery) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.mastery, style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: Text(l10n.all),
                      selected: _state.mastery == null,
                      onSelected: (_) => setState(
                        () => _state = _state.copyWith(clearMastery: true),
                      ),
                    ),
                    ...MasteryStatus.values.map(
                      (m) => FilterChip(
                        label: Text(_masteryLabel(l10n, m)),
                        selected: _state.mastery == m,
                        onSelected: (_) => setState(
                          () => _state = _state.copyWith(mastery: m),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.favorites),
                value: _state.favoritesOnly,
                onChanged: (v) => setState(
                  () => _state = _state.copyWith(favoritesOnly: v),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(l10n.sortBy, style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ContentSort.values.map((sort) {
                  return ChoiceChip(
                    label: Text(_sortLabel(l10n, sort)),
                    selected: _state.sort == sort,
                    onSelected: (_) => setState(
                      () => _state = _state.copyWith(sort: sort),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),
              LexoraPrimaryButton(
                label: l10n.applyFilters,
                onPressed: () => Navigator.pop(context, _state),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
