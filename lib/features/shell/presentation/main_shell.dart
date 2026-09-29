import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/lexora_widgets.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  /// Bottom-nav visual index: 0 home, 1 words, 2 add, 3 sentences, 4 progress.
  /// Branch index: 0 home, 1 words, 2 sentences, 3 progress (no add branch).
  int get _navIndex {
    final branch = navigationShell.currentIndex;
    return branch >= 2 ? branch + 1 : branch;
  }

  int _branchForNavIndex(int navIndex) {
    return navIndex > 2 ? navIndex - 1 : navIndex;
  }

  void _onDestinationSelected(BuildContext context, int navIndex) {
    if (navIndex == 2) {
      HapticFeedback.mediumImpact();
      _showAddSheet(context);
      return;
    }
    final branch = _branchForNavIndex(navIndex);
    navigationShell.goBranch(
      branch,
      initialLocation: branch == navigationShell.currentIndex,
    );
  }

  Future<void> _showAddSheet(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.navAdd,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.lg),
                _AddAction(
                  icon: Icons.menu_book_rounded,
                  title: l10n.addWord,
                  subtitle: l10n.addWordDescription,
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/words/add');
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                _AddAction(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: l10n.addSentence,
                  subtitle: l10n.addSentenceDescription,
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/sentences/add');
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                _AddAction(
                  icon: Icons.account_tree_outlined,
                  title: l10n.addPattern,
                  subtitle: l10n.addPatternDescription,
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/patterns/add');
                  },
                ),
                _AddAction(
                  icon: Icons.article_outlined,
                  title: l10n.writeBlog,
                  subtitle: l10n.writeBlogDescription,
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/blog');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.sizeOf(context);

    // Force full-screen layout. Scaffold+go_router was shrink-wrapping to the
    // bottom nav height under loose constraints, centering the bar mid-screen.
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Material(
        color: isDark ? AppColors.backgroundDark : AppColors.background,
        child: Column(
          children: [
            Expanded(child: navigationShell),
            Material(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              elevation: 8,
              shadowColor: Colors.black.withValues(alpha: 0.12),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      _NavItem(
                        icon: Icons.home_outlined,
                        selectedIcon: Icons.home_rounded,
                        label: l10n.navHome,
                        selected: _navIndex == 0,
                        onTap: () => _onDestinationSelected(context, 0),
                      ),
                      _NavItem(
                        icon: Icons.menu_book_outlined,
                        selectedIcon: Icons.menu_book_rounded,
                        label: l10n.navWords,
                        selected: _navIndex == 1,
                        onTap: () => _onDestinationSelected(context, 1),
                      ),
                      Expanded(
                        child: Center(
                          child: Semantics(
                            button: true,
                            label: l10n.navAdd,
                            child: GestureDetector(
                              onTap: () => _onDestinationSelected(context, 2),
                              child: Container(
                                width: 58,
                                height: 58,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: AppColors.primaryGradient,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary
                                          .withValues(alpha: 0.4),
                                      blurRadius: 16,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.add_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      _NavItem(
                        icon: Icons.chat_bubble_outline_rounded,
                        selectedIcon: Icons.chat_bubble_rounded,
                        label: l10n.navSentences,
                        selected: _navIndex == 3,
                        onTap: () => _onDestinationSelected(context, 3),
                      ),
                      _NavItem(
                        icon: Icons.insights_outlined,
                        selectedIcon: Icons.insights_rounded,
                        label: l10n.navProgress,
                        selected: _navIndex == 4,
                        onTap: () => _onDestinationSelected(context, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textSecondary;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(selected ? selectedIcon : icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddAction extends StatelessWidget {
  const _AddAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LexoraCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}
