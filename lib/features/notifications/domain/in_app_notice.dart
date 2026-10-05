enum NoticeKind {
  dueWords,
  dueSentences,
  dailyLearning,
  streak,
  achievement,
}

class InAppNotice {
  const InAppNotice({
    required this.id,
    required this.kind,
    required this.createdAt,
    required this.route,
    this.count = 0,
    this.achievementId,
    this.isRead = false,
  });

  final String id;
  final NoticeKind kind;
  final DateTime createdAt;
  final String route;
  final int count;
  final String? achievementId;
  final bool isRead;

  InAppNotice copyWith({bool? isRead}) {
    return InAppNotice(
      id: id,
      kind: kind,
      createdAt: createdAt,
      route: route,
      count: count,
      achievementId: achievementId,
      isRead: isRead ?? this.isRead,
    );
  }
}

/// Live learning signals. Read state is applied afterwards.
List<InAppNotice> buildInAppNotices({
  required int dueWords,
  required int dueSentences,
  required bool studiedToday,
  required int currentStreak,
  required List<({String id, DateTime unlockedAt})> uncelebrated,
  required DateTime now,
}) {
  final day = '${now.year}-${now.month}-${now.day}';
  final notices = <InAppNotice>[];
  if (dueWords > 0) {
    notices.add(
      InAppNotice(
        id: 'due-words-$dueWords',
        kind: NoticeKind.dueWords,
        createdAt: now,
        route: '/review',
        count: dueWords,
      ),
    );
  }
  if (dueSentences > 0) {
    notices.add(
      InAppNotice(
        id: 'due-sentences-$dueSentences',
        kind: NoticeKind.dueSentences,
        createdAt: now,
        route: '/review',
        count: dueSentences,
      ),
    );
  }
  if (!studiedToday && currentStreak > 0) {
    notices.add(
      InAppNotice(
        id: 'streak-$day-$currentStreak',
        kind: NoticeKind.streak,
        createdAt: now,
        route: '/home',
        count: currentStreak,
      ),
    );
  } else if (!studiedToday) {
    notices.add(
      InAppNotice(
        id: 'daily-$day',
        kind: NoticeKind.dailyLearning,
        createdAt: now,
        route: '/review',
      ),
    );
  }
  for (final item in uncelebrated) {
    notices.add(
      InAppNotice(
        id: 'achievement-${item.id}',
        kind: NoticeKind.achievement,
        createdAt: item.unlockedAt,
        route: routeForAchievement(item.id),
        achievementId: item.id,
      ),
    );
  }
  return notices;
}

String routeForAchievement(String id) {
  if (id.startsWith('level-') && id.length > 'level-'.length) {
    return '/progress/level/${id.substring('level-'.length).toUpperCase()}';
  }
  return '/progress';
}

/// Only known in-app routes may be opened from a notice or a local reminder.
String notificationRoute(String? payload) {
  if (payload == '/home' || payload == '/review' || payload == '/progress') {
    return payload!;
  }
  if (payload != null && payload.startsWith('/progress/level/')) {
    final level = payload.split('/').last.toUpperCase();
    const known = {'A1', 'A2', 'B1', 'B2', 'C1', 'C2'};
    if (known.contains(level)) return '/progress/level/$level';
  }
  return '/review';
}

int unreadNoticeCount(Iterable<InAppNotice> notices) {
  var count = 0;
  for (final notice in notices) {
    if (!notice.isRead) count++;
  }
  return count;
}

String? noticeBadgeLabel(int unread) {
  if (unread <= 0) return null;
  if (unread > 9) return '9+';
  return '$unread';
}

List<InAppNotice> applyReadState(
  List<InAppNotice> notices,
  Set<String> readIds,
) {
  return [
    for (final notice in notices)
      notice.copyWith(isRead: readIds.contains(notice.id)),
  ];
}

List<InAppNotice> markNoticesRead(
  List<InAppNotice> notices, {
  String? id,
}) {
  return [
    for (final notice in notices)
      notice.copyWith(isRead: id == null || notice.id == id || notice.isRead),
  ];
}
