import 'streak.dart';

/// A calendar day counts toward the streak only after real study.
class ActivityStreakPolicy {
  const ActivityStreakPolicy();

  static const minimumActiveSeconds = 60;

  bool dayCounts({
    required int reviews,
    required int exercises,
    required int activeSeconds,
  }) {
    return reviews > 0 ||
        exercises > 0 ||
        activeSeconds >= minimumActiveSeconds;
  }

  StreakStats fromDays(
    Iterable<({DateTime day, int reviews, int exercises, int activeSeconds})>
        days, {
    DateTime? today,
  }) {
    final qualifying = [
      for (final day in days)
        if (dayCounts(
          reviews: day.reviews,
          exercises: day.exercises,
          activeSeconds: day.activeSeconds,
        ))
          day.day,
    ];
    return streakStats(qualifying, today: today);
  }
}

/// Active study time. Background and idle gaps are excluded.
class LearningTimePolicy {
  const LearningTimePolicy();

  static const idleTimeout = Duration(minutes: 2);

  Duration elapsed({
    required bool foreground,
    required DateTime? segmentStart,
    required DateTime lastPulse,
    required DateTime now,
  }) {
    if (!foreground || segmentStart == null) return Duration.zero;
    final end = now.difference(lastPulse) > idleTimeout ? lastPulse : now;
    final span = end.difference(segmentStart);
    if (span.isNegative) return Duration.zero;
    return span;
  }
}

class UnlockPolicy {
  const UnlockPolicy();

  /// Extra practice becomes available. Word CEFR levels stay unchanged.
  static const advancedPracticeMasteredWords = 10;

  bool advancedPracticeUnlocked(int masteredWords) =>
      masteredWords >= advancedPracticeMasteredWords;
}
