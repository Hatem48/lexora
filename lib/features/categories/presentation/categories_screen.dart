import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../data/category_repository.dart';
import 'category_icons.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final async = ref.watch(categoriesListProvider);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.categories)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditor(context, ref),
        child: const Icon(Icons.add_rounded),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => EmptyState(
          title: l10n.errorGeneric,
          message: e.toString(),
          actionLabel: l10n.retry,
          onAction: () => ref.invalidate(categoriesListProvider),
        ),
        data: (categories) {
          if (categories.isEmpty) {
            return EmptyState(
              title: l10n.noCategoriesYet,
              message: l10n.noCategoriesYetMessage,
              actionLabel: l10n.addCategory,
              onAction: () => _showEditor(context, ref),
              icon: Icons.folder_outlined,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding,
              AppSpacing.sm,
              AppSpacing.screenPadding,
              100,
            ),
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final c = categories[index];
              final title = isRtl && (c.nameAr?.isNotEmpty ?? false)
                  ? c.nameAr!
                  : c.name;
              final subtitle = isRtl && (c.nameAr?.isNotEmpty ?? false)
                  ? c.name
                  : c.nameAr;

              return LexoraCard(
                onTap: () => _showEditor(context, ref, existing: c),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        categoryIcon(c.iconName),
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: Theme.of(context).textTheme.titleMedium),
                          if (subtitle != null && subtitle.isNotEmpty)
                            Text(
                              subtitle,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          if (c.isSystem)
                            Text(
                              l10n.systemCategory,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: AppColors.textTertiary),
                            ),
                        ],
                      ),
                    ),
                    if (!c.isSystem)
                      IconButton(
                        tooltip: l10n.delete,
                        onPressed: () => _confirmDelete(context, ref, c),
                        icon: const Icon(Icons.delete_outline_rounded),
                        color: AppColors.error,
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    CategoryRow category,
  ) async {
    final l10n = AppLocalizations.of(context);
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
    if (ok != true || !context.mounted) return;

    final deleted =
        await ref.read(categoryRepositoryProvider).delete(category.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          deleted ? l10n.categoryDeleted : l10n.cannotDeleteSystemCategory,
        ),
      ),
    );
  }

  Future<void> _showEditor(
    BuildContext context,
    WidgetRef ref, {
    CategoryRow? existing,
  }) async {
    final l10n = AppLocalizations.of(context);
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final nameArCtrl = TextEditingController(text: existing?.nameAr ?? '');
    var iconName = existing?.iconName ?? 'folder';
    final formKey = GlobalKey<FormState>();

    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      existing == null ? l10n.addCategory : l10n.editCategory,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      controller: nameCtrl,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(labelText: l10n.categoryNameEn),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      controller: nameArCtrl,
                      textDirection: TextDirection.rtl,
                      decoration:
                          InputDecoration(labelText: l10n.categoryNameAr),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(l10n.categoryIcon,
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: kCategoryIconChoices.map((name) {
                        final selected = iconName == name;
                        return ChoiceChip(
                          label: Icon(
                            categoryIcon(name),
                            size: 20,
                            color: selected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                          selected: selected,
                          onSelected: (_) =>
                              setModalState(() => iconName = name),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    LexoraPrimaryButton(
                      label: l10n.save,
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;
                        final repo = ref.read(categoryRepositoryProvider);
                        if (existing == null) {
                          await repo.create(
                            name: nameCtrl.text,
                            nameAr: nameArCtrl.text,
                            iconName: iconName,
                          );
                        } else {
                          await repo.update(
                            id: existing.id,
                            name: nameCtrl.text,
                            nameAr: nameArCtrl.text,
                            iconName: iconName,
                          );
                        }
                        if (context.mounted) Navigator.pop(context, true);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );

    nameCtrl.dispose();
    nameArCtrl.dispose();
    if (saved == true && context.mounted) {
      // Stream updates automatically.
    }
  }
}

/// Multi-select chips for assigning categories on add/edit forms.
class CategoryPicker extends ConsumerWidget {
  const CategoryPicker({
    super.key,
    required this.selectedIds,
    required this.onChanged,
  });

  final Set<String> selectedIds;
  final ValueChanged<Set<String>> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final async = ref.watch(categoriesListProvider);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return async.when(
      loading: () => const SizedBox(
        height: 40,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      error: (_, _) => const SizedBox.shrink(),
      data: (categories) {
        if (categories.isEmpty) {
          return Text(
            l10n.noCategoriesYet,
            style: Theme.of(context).textTheme.bodySmall,
          );
        }
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((c) {
            final selected = selectedIds.contains(c.id);
            final label = isRtl && (c.nameAr?.isNotEmpty ?? false)
                ? c.nameAr!
                : c.name;
            return FilterChip(
              avatar: Icon(categoryIcon(c.iconName), size: 16),
              label: Text(label),
              selected: selected,
              onSelected: (v) {
                final next = Set<String>.from(selectedIds);
                if (v) {
                  next.add(c.id);
                } else {
                  next.remove(c.id);
                }
                onChanged(next);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
