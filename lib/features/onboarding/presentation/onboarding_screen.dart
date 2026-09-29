import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/enums.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/widgets/lexora_widgets.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;

  late String _locale;
  late CefrLevel _level;
  late PronunciationAccent _accent;
  late int _dailyGoal;
  late bool _reminders;

  @override
  void initState() {
    super.initState();
    final s = ref.read(settingsProvider);
    _locale = s.localeCode;
    _level = s.cefrLevel;
    _accent = s.accent;
    _dailyGoal = s.dailyGoal;
    _reminders = s.remindersEnabled;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _next() async {
    if (_page < 4) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
      return;
    }
    final current = ref.read(settingsProvider);
    await ref.read(settingsProvider.notifier).completeOnboarding(
          current.copyWith(
            localeCode: _locale,
            cefrLevel: _level,
            accent: _accent,
            dailyGoal: _dailyGoal,
            remindersEnabled: _reminders,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
              child: Row(
                children: [
                  if (_page > 0)
                    IconButton(
                      onPressed: () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 280),
                        curve: Curves.easeOutCubic,
                      ),
                      icon: const Icon(Icons.arrow_back_rounded),
                    )
                  else
                    const SizedBox(width: 48),
                  Expanded(
                    child: Row(
                      children: List.generate(5, (i) {
                        final active = i <= _page;
                        return Expanded(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            height: 4,
                            decoration: BoxDecoration(
                              color:
                                  active ? AppColors.primary : AppColors.border,
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  _OnboardPage(
                    title: l10n.onboardingLanguageTitle,
                    subtitle: l10n.onboardingLanguageSubtitle,
                    child: Column(
                      children: [
                        _ChoiceCard(
                          selected: _locale == 'en',
                          title: 'English',
                          onTap: () => setState(() => _locale = 'en'),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _ChoiceCard(
                          selected: _locale == 'ar',
                          title: 'العربية',
                          onTap: () => setState(() => _locale = 'ar'),
                        ),
                      ],
                    ),
                  ),
                  _OnboardPage(
                    title: l10n.onboardingLevelTitle,
                    subtitle: l10n.onboardingLevelSubtitle,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: CefrLevel.values.map((level) {
                        final selected = _level == level;
                        return ChoiceChip(
                          label: Text(level.code),
                          selected: selected,
                          onSelected: (_) => setState(() => _level = level),
                          selectedColor:
                              AppColors.primary.withValues(alpha: 0.15),
                          labelStyle: theme.textTheme.labelLarge?.copyWith(
                            color: selected
                                ? AppColors.primary
                                : theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  _OnboardPage(
                    title: l10n.onboardingAccentTitle,
                    subtitle: l10n.onboardingAccentSubtitle,
                    child: Column(
                      children: [
                        _ChoiceCard(
                          selected: _accent == PronunciationAccent.american,
                          title: l10n.americanNatural,
                          onTap: () => setState(
                            () => _accent = PronunciationAccent.american,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _ChoiceCard(
                          selected: _accent == PronunciationAccent.british,
                          title: l10n.britishNatural,
                          onTap: () => setState(
                            () => _accent = PronunciationAccent.british,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _OnboardPage(
                    title: l10n.onboardingGoalTitle,
                    subtitle: l10n.onboardingGoalSubtitle,
                    child: Column(
                      children: [10, 20, 30, 50].map((goal) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: _ChoiceCard(
                            selected: _dailyGoal == goal,
                            title: l10n.goalItems(goal),
                            onTap: () => setState(() => _dailyGoal = goal),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  _OnboardPage(
                    title: l10n.onboardingRemindersTitle,
                    subtitle: l10n.onboardingRemindersSubtitle,
                    child: Column(
                      children: [
                        _ChoiceCard(
                          selected: _reminders,
                          title: l10n.enableReminders,
                          onTap: () => setState(() => _reminders = true),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _ChoiceCard(
                          selected: !_reminders,
                          title: l10n.disableReminders,
                          onTap: () => setState(() => _reminders = false),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: LexoraPrimaryButton(
                label: _page == 4 ? l10n.getStarted : l10n.next,
                onPressed: _next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardPage extends StatelessWidget {
  const _OnboardPage({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.lg),
          Text(title, style: theme.textTheme.headlineLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          child,
        ],
      ),
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.selected,
    required this.title,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LexoraCard(
      onTap: onTap,
      color: selected ? AppColors.primary.withValues(alpha: 0.08) : null,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: selected ? AppColors.primary : null,
                  ),
            ),
          ),
          Icon(
            selected ? Icons.check_circle_rounded : Icons.circle_outlined,
            color: selected ? AppColors.primary : AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}
