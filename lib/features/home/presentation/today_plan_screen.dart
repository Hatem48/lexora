import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../domain/daily_plan.dart';
import 'daily_plan_controller.dart';
import 'dashboard_providers.dart';

class TodayPlanScreen extends ConsumerWidget {
  const TodayPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final plan = ref.watch(dailyPlanProvider);
    final stats = ref.watch(dashboardStatsProvider).asData?.value;
    final level = stats?.currentLevel.code ?? 'A1';
    final due = stats?.dueTodayCount ?? 0;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.todayPlanTitle)),
      body: plan.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => EmptyState(
          title: l10n.errorGeneric,
          message: error.toString(),
          actionLabel: l10n.retry,
          onAction: () => ref.invalidate(dailyPlanProvider),
        ),
        data: (state) {
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            children: [
              LexoraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.journeyStep(
                        state.journeyFinished ? dailyJourneySteps : state.step + 1,
                        dailyJourneySteps,
                      ),
                      textDirection: TextDirection.ltr,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(_journeyText(l10n, state.step, level, due)),
                    if (!state.journeyFinished) ...[
                      const SizedBox(height: AppSpacing.md),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: FilledButton(
                          onPressed: () =>
                              ref.read(dailyPlanProvider.notifier).acknowledge(),
                          child: Text(l10n.gotIt),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.todayTasks,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final id in dailyTaskIds) ...[
                DailyTaskTile(
                  title: _taskTitle(l10n, id, level),
                  detail: _taskDetail(l10n, id, due),
                  done: state.done.contains(id),
                  onOpen: () => _open(context, id),
                  onToggle: () => ref.read(dailyPlanProvider.notifier).toggle(id),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
            ],
          );
        },
      ),
    );
  }

  String _journeyText(AppLocalizations l10n, int step, String level, int due) {
    return switch (step) {
      0 => l10n.todayJourneyFocus(level),
      1 => due > 0
          ? l10n.todayJourneyReview(due)
          : l10n.todayJourneyReviewClear,
      _ => l10n.todayJourneyList,
    };
  }

  String _taskTitle(AppLocalizations l10n, String id, String level) {
    return switch (id) {
      'review' => l10n.taskReview,
      'words' => l10n.taskWords(level),
      'sentence' => l10n.taskSentence,
      'topic' => l10n.taskTopic,
      _ => id,
    };
  }

  String _taskDetail(AppLocalizations l10n, String id, int due) {
    return switch (id) {
      'review' => l10n.taskReviewDetail(due),
      'words' => l10n.taskWordsDetail,
      'sentence' => l10n.taskSentenceDetail,
      'topic' => l10n.taskTopicDetail,
      _ => '',
    };
  }

  void _open(BuildContext context, String id) {
    final route = dailyTaskRoute(id);
    if (route == null) return;
    if (route == '/words' || route == '/sentences') {
      context.go(route);
    } else {
      context.push(route);
    }
  }
}

class DailyTaskTile extends StatelessWidget {
  const DailyTaskTile({
    super.key,
    required this.title,
    required this.detail,
    required this.done,
    required this.onOpen,
    required this.onToggle,
  });

  final String title;
  final String detail;
  final bool done;
  final VoidCallback onOpen;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurface.withValues(alpha: 0.62);
    return LexoraCard(
      onTap: onOpen,
      child: Row(
        children: [
          IconButton(
            tooltip: title,
            onPressed: onToggle,
            icon: Icon(
              done ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: done ? theme.colorScheme.primary : muted,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    decoration: done ? TextDecoration.lineThrough : null,
                    color: done ? muted : null,
                  ),
                ),
                if (detail.isNotEmpty)
                  Text(
                    detail,
                    style: theme.textTheme.bodySmall?.copyWith(
                      decoration: done ? TextDecoration.lineThrough : null,
                      color: muted,
                    ),
                  ),
              ],
            ),
          ),
          Icon(
            Directionality.of(context) == TextDirection.rtl
                ? Icons.chevron_left_rounded
                : Icons.chevron_right_rounded,
            color: muted,
          ),
        ],
      ),
    );
  }
}
