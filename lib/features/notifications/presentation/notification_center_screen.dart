import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/help/context_help_icon.dart';
import '../../../core/help/help_catalog.dart';
import '../../../core/services/progress/achievement_catalog.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../data/notice_read_store.dart';
import '../domain/in_app_notice.dart';
import 'notice_providers.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({
    super.key,
    required this.unread,
    required this.onPressed,
    required this.tooltip,
  });

  final int unread;
  final VoidCallback onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final badge = noticeBadgeLabel(unread);
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Badge(
        isLabelVisible: badge != null,
        label: Text(badge ?? ''),
        child: const Icon(Icons.notifications_none_rounded),
      ),
    );
  }
}

class NotificationCenterScreen extends ConsumerWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final notices = ref.watch(inAppNoticesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notificationCenter),
        actions: [
          const ContextHelpIcon(topic: HelpTopic.notifications),
          if (notices.asData?.value.any((notice) => !notice.isRead) ?? false)
            TextButton(
              onPressed: () => _mark(ref, [
                for (final notice in notices.asData!.value)
                  if (!notice.isRead) notice.id,
              ]),
              child: Text(l10n.markAllRead),
            ),
        ],
      ),
      body: notices.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => EmptyState(
          title: l10n.errorGeneric,
          message: error.toString(),
          actionLabel: l10n.retry,
          onAction: () => ref.invalidate(inAppNoticesProvider),
        ),
        data: (items) => NotificationCenterBody(
          notices: items,
          onOpen: (notice) async {
            await _mark(ref, [notice.id]);
            if (!context.mounted) return;
            context.push(notificationRoute(notice.route));
          },
        ),
      ),
    );
  }

  Future<void> _mark(WidgetRef ref, List<String> ids) async {
    if (ids.isEmpty) return;
    await NoticeReadStore(ref.read(appDatabaseProvider)).markRead(ids);
    ref.invalidate(inAppNoticesProvider);
  }
}

class NotificationCenterBody extends StatelessWidget {
  const NotificationCenterBody({
    super.key,
    required this.notices,
    required this.onOpen,
  });

  final List<InAppNotice> notices;
  final ValueChanged<InAppNotice> onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (notices.isEmpty) {
      return EmptyState(
        title: l10n.noNewNotifications,
        message: l10n.notificationsHelp,
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      itemCount: notices.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final notice = notices[index];
        final copy = noticeCopy(l10n, notice, Localizations.localeOf(context));
        return LexoraCard(
          onTap: () => onOpen(notice),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                notice.isRead
                    ? Icons.notifications_none_rounded
                    : Icons.notifications_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(copy.$1, style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(copy.$2),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

(String, String) noticeCopy(
  AppLocalizations l10n,
  InAppNotice notice,
  Locale locale,
) {
  final arabic = locale.languageCode == 'ar';
  return switch (notice.kind) {
    NoticeKind.dueWords => (
        l10n.dueWordsNoticeTitle,
        l10n.dueWordsNotice(notice.count),
      ),
    NoticeKind.dueSentences => (
        l10n.dueSentencesNoticeTitle,
        l10n.dueSentencesNotice(notice.count),
      ),
    NoticeKind.dailyLearning => (
        l10n.dailyLearningNoticeTitle,
        l10n.dailyLearningNotice,
      ),
    NoticeKind.streak => (
        l10n.streakNoticeTitle,
        l10n.streakNotice(notice.count),
      ),
    NoticeKind.achievement => () {
        final definition = AchievementCatalog.byId(notice.achievementId ?? '');
        if (definition == null) {
          return (l10n.achievementUnlocked, l10n.achievements);
        }
        return (
          l10n.achievementUnlocked,
          arabic ? definition.titleAr : definition.titleEn,
        );
      }(),
  };
}
