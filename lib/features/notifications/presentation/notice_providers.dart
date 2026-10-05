import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/enums.dart';
import '../../../core/database/app_database.dart';
import '../../../core/services/progress/activity_policy.dart';
import '../../../core/services/progress/learning_activity_store.dart';
import '../data/notice_read_store.dart';
import '../domain/in_app_notice.dart';

final inAppNoticesProvider = FutureProvider<List<InAppNotice>>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  final now = DateTime.now();
  final due = await db.customSelect(
    '''
    SELECT item_type AS type, COUNT(*) AS c
    FROM review_items
    WHERE next_review_at <= ?
    GROUP BY item_type
    ''',
    variables: [Variable<DateTime>(now)],
  ).get();
  var dueWords = 0;
  var dueSentences = 0;
  for (final row in due) {
    final type = row.read<String>('type');
    final count = row.read<int>('c');
    if (type == ReviewItemType.word.storageValue ||
        type == ReviewItemType.vocabulary.storageValue) {
      dueWords += count;
    } else if (type == ReviewItemType.sentence.storageValue ||
        type == ReviewItemType.pattern.storageValue) {
      dueSentences += count;
    }
  }

  final days = await db.select(db.learningDays).get();
  final streaks = const ActivityStreakPolicy().fromDays(
    [
      for (final day in days)
        (
          day: DateTime.parse(day.day),
          reviews: day.reviews,
          exercises: day.exercises,
          activeSeconds: day.activeSeconds,
        ),
    ],
    today: now,
  );
  final today = await (db.select(db.learningDays)
        ..where((row) => row.day.equals(LearningActivityStore.dayKey(now))))
      .getSingleOrNull();
  final studiedToday = today != null &&
      const ActivityStreakPolicy().dayCounts(
        reviews: today.reviews,
        exercises: today.exercises,
        activeSeconds: today.activeSeconds,
      );

  await AchievementService(db).sync(now: now);
  final achievements = await (db.select(db.userAchievements)
        ..where((row) => row.celebrated.equals(false)))
      .get();
  final reads = await NoticeReadStore(db).readIds();
  return applyReadState(
    buildInAppNotices(
      dueWords: dueWords,
      dueSentences: dueSentences,
      studiedToday: studiedToday,
      currentStreak: streaks.current,
      uncelebrated: [
        for (final row in achievements) (id: row.id, unlockedAt: row.unlockedAt),
      ],
      now: now,
    ),
    reads,
  );
});
