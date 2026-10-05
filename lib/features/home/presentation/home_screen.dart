import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/enums.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/help/help_catalog.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../../progress/domain/cefr_artwork.dart';
import '../../progress/presentation/catalog_progress_section.dart';
import '../../progress/presentation/cefr_artwork_card.dart';
import '../../notifications/domain/in_app_notice.dart';
import '../../notifications/presentation/notice_providers.dart';
import '../../notifications/presentation/notification_center_screen.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/presentation/account_avatar.dart';
import '../domain/dashboard_stats.dart';
import 'dashboard_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _greeting(AppLocalizations l10n, String name) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.goodMorning(name);
    if (hour < 17) return l10n.goodAfternoon(name);
    return l10n.goodEvening(name);
  }

  String _recTitle(AppLocalizations l10n, DashboardRecommendation r) {
    return switch (r.titleKey) {
      'moreB1Vocabulary' => l10n.moreB1Vocabulary,
      'sentencePatterns' => l10n.sentencePatterns,
      'speakingPractice' => l10n.speakingPractice,
      _ => r.titleKey,
    };
  }

  String _recSubtitle(AppLocalizations l10n, DashboardRecommendation r) {
    return switch (r.subtitleKey) {
      'needMoreWords' => l10n.needMoreWords,
      'addMorePatterns' => l10n.addMorePatterns,
      'sentencesWithoutPractice' =>
        l10n.sentencesWithoutPractice(r.count ?? 0),
      _ => r.subtitleKey,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);
    final auth = ref.watch(authProvider);
    final statsAsync = ref.watch(dashboardStatsProvider);
    final accountName = auth.user?.displayName.trim() ?? '';
    final name = accountName.isNotEmpty
        ? auth.user!.firstName
        : (settings.displayName.trim().isEmpty
            ? l10n.appName
            : settings.displayName.trim());

    return Scaffold(
      body: SafeArea(
        child: statsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => EmptyState(
            title: l10n.errorGeneric,
            message: e.toString(),
            actionLabel: l10n.retry,
            onAction: () => ref.invalidate(dashboardStatsProvider),
          ),
          data: (stats) {
            final next = stats.currentLevel.next;
            final art = ref.watch(catalogProgressProvider).asData?.value;
            final code = stats.currentLevel.code;
            final recognized = art?.recognizedFor(code) ?? 0;
            final total = art?.totals[code] ?? 0;
            final painted = paintingWordCount(recognized: recognized, total: total);

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(dashboardStatsProvider);
                ref.invalidate(catalogProgressProvider);
              },
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenPadding,
                  AppSpacing.md,
                  AppSpacing.screenPadding,
                  AppSpacing.xxxl,
                ),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _greeting(l10n, name),
                          style: theme.textTheme.headlineMedium,
                        ),
                      ),
                      NotificationBell(
                        unread: unreadNoticeCount(
                          ref.watch(inAppNoticesProvider).asData?.value ??
                              const [],
                        ),
                        tooltip: l10n.notifications,
                        onPressed: () => context.push('/notifications'),
                      ),
                      GestureDetector(
                        onTap: () => context.push('/settings'),
                        child: AccountAvatar(user: auth.user, radius: 20),
                      ),
                    ],
                  ).animate().fadeIn(duration: 350.ms),
                  const SizedBox(height: AppSpacing.lg),
                  CefrArtworkCard(
                    level: code,
                    mastered: painted,
                    total: total,
                    onTap: () => context.push(levelArtPath(code)),
                    help: true,
                  ).animate().fadeIn(delay: 80.ms).slideY(begin: 0.05, end: 0),
                  if (next != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(l10n.keepGoingTo(next.code)),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: AppSpacing.sm,
                    crossAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 1.45,
                    children: [
                      StatTile(
                        label: l10n.words,
                        value: '${stats.wordsCount}',
                        color: AppColors.primary,
                      ),
                      StatTile(
                        label: l10n.sentences,
                        value: '${stats.sentencesCount}',
                        color: AppColors.info,
                      ),
                      StatTile(
                        label: l10n.mastered,
                        value: '${stats.masteredCount}',
                        color: AppColors.success,
                        help: HelpTopic.masteredWords,
                      ),
                      StatTile(
                        label: l10n.dueToday,
                        value: '${stats.dueTodayCount}',
                        color: AppColors.warning,
                        help: HelpTopic.reviewSystem,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sectionGap),
                  SectionHeader(
                    title: l10n.yourCefrProgress,
                    help: HelpTopic.cefr,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LexoraCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: CefrLevel.values.map((level) {
                        final ring = stats.cefrProgress[level] ??
                            const CefrLevelProgress(known: 0, total: 0);
                        final fill = ring.known == 0
                            ? 0.0
                            : ring.fraction < 0.08
                                ? 0.08
                                : ring.fraction;
                        return Column(
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CircularProgressIndicator(
                                    value: fill,
                                    strokeWidth: 4,
                                    backgroundColor: AppColors.border,
                                    color: AppColors.cefrColor(level.code),
                                  ),
                                  Center(
                                    child: Text(
                                      '${ring.known}',
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: ring.known > 99 ? 8 : 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              level.code,
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sectionGap),
                  SectionHeader(title: l10n.continueLearning),
                  const SizedBox(height: AppSpacing.md),
                  LexoraCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stats.dueTodayCount == 0
                              ? l10n.allCaughtUp
                              : l10n.itemsNeedReview(
                                  stats.dueWords,
                                  stats.dueSentences,
                                ),
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        LexoraPrimaryButton(
                          label: l10n.startReview,
                          icon: Icons.play_arrow_rounded,
                          onPressed: () => context.push('/review'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sectionGap),
                  LexoraCard(
                    onTap: () => context.push('/topics'),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.grid_view_rounded,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.topicsTitle,
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                l10n.topicsSubtitle,
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.textTertiary,
                        ),
                      ],
                    ),
                  ),
                  if (stats.recommendations.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sectionGap),
                    SectionHeader(title: l10n.whatYouNeedToAdd),
                    const SizedBox(height: AppSpacing.md),
                    ...stats.recommendations.map((rec) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: LexoraCard(
                          onTap: () {
                            if (rec.titleKey == 'sentencePatterns') {
                              context.push('/patterns');
                            } else if (rec.titleKey == 'moreB1Vocabulary') {
                              context.go('/words');
                            } else if (rec.titleKey == 'speakingPractice') {
                              context.push('/speaking');
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: AppColors.primary
                                      .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  rec.icon == 'mic'
                                      ? Icons.mic_none_rounded
                                      : rec.icon == 'pattern'
                                          ? Icons.account_tree_outlined
                                          : Icons.auto_stories_outlined,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _recTitle(l10n, rec),
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    Text(
                                      _recSubtitle(l10n, rec),
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: AppColors.textTertiary,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
