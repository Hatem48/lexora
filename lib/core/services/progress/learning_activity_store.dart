import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import 'achievement_catalog.dart';
import 'activity_policy.dart';

class LearningActivityStore {
  LearningActivityStore(this._db);

  final AppDatabase _db;

  static String dayKey(DateTime value) {
    final local = value.toLocal();
    final month = local.month.toString().padLeft(2, '0');
    final day = local.day.toString().padLeft(2, '0');
    return '${local.year}-$month-$day';
  }

  Future<void> add({
    int seconds = 0,
    int reviews = 0,
    int exercises = 0,
    DateTime? when,
  }) async {
    if (seconds == 0 && reviews == 0 && exercises == 0) return;
    final key = dayKey(when ?? DateTime.now());
    final existing = await (_db.select(_db.learningDays)
          ..where((row) => row.day.equals(key)))
        .getSingleOrNull();
    if (existing == null) {
      await _db.into(_db.learningDays).insert(
            LearningDaysCompanion.insert(
              day: key,
              activeSeconds: Value(seconds),
              reviews: Value(reviews),
              exercises: Value(exercises),
            ),
          );
    } else {
      await (_db.update(_db.learningDays)..where((row) => row.day.equals(key)))
          .write(
        LearningDaysCompanion(
          activeSeconds: Value(existing.activeSeconds + seconds),
          reviews: Value(existing.reviews + reviews),
          exercises: Value(existing.exercises + exercises),
        ),
      );
    }
    await AchievementService(_db).sync();
  }
}

class AchievementService {
  AchievementService(this._db);

  final AppDatabase _db;

  Future<List<UserAchievementRow>> uncelebrated() {
    return (_db.select(_db.userAchievements)
          ..where((row) => row.celebrated.equals(false))
          ..orderBy([(row) => OrderingTerm.asc(row.unlockedAt)]))
        .get();
  }

  Future<void> markCelebrated(String id) {
    return (_db.update(_db.userAchievements)..where((row) => row.id.equals(id)))
        .write(const UserAchievementsCompanion(celebrated: Value(true)));
  }

  Future<void> sync({DateTime? now}) async {
    final discovered = await _count(
      'SELECT COUNT(*) AS c FROM user_vocabulary',
    );
    final mastered = await _count(
      "SELECT COUNT(*) AS c FROM user_vocabulary WHERE status = 'mastered'",
    );
    final grammar = await _count(
      "SELECT COUNT(*) AS c FROM user_grammar_progress WHERE status = 'completed'",
    );
    final seconds = await _count(
      'SELECT COALESCE(SUM(active_seconds), 0) AS c FROM learning_days',
    );
    final masteredByLevel = await _grouped(
      '''
      SELECT e.cefr_level AS level, COUNT(*) AS c
      FROM user_vocabulary u
      JOIN vocabulary_entries e ON e.id = u.entry_id
      WHERE u.status = 'mastered'
      GROUP BY e.cefr_level
      ''',
    );
    final totals = await _grouped(
      'SELECT cefr_level AS level, COUNT(*) AS c FROM vocabulary_entries GROUP BY cefr_level',
    );
    final days = await _db.select(_db.learningDays).get();
    final streak = const ActivityStreakPolicy().fromDays(
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
    final earned = AchievementCatalog.earnedIds(
      discovered: discovered,
      mastered: mastered,
      grammarCompleted: grammar,
      streak: streak.longest,
      activeSeconds: seconds,
      masteredByLevel: masteredByLevel,
      totalsByLevel: totals,
    );
    final existing = {
      for (final row in await _db.select(_db.userAchievements).get()) row.id,
    };
    final timestamp = now ?? DateTime.now().toUtc();
    for (final id in earned) {
      if (existing.contains(id)) continue;
      await _db.into(_db.userAchievements).insert(
            UserAchievementsCompanion.insert(
              id: id,
              unlockedAt: timestamp,
            ),
          );
    }
  }

  Future<int> _count(String sql) async {
    final row = await _db.customSelect(sql).getSingle();
    return row.read<int>('c');
  }

  Future<Map<String, int>> _grouped(String sql) async {
    final rows = await _db.customSelect(sql).get();
    return {
      for (final row in rows) row.read<String>('level'): row.read<int>('c'),
    };
  }
}
