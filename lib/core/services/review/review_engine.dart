import '../../constants/enums.dart';

/// SM-2 inspired spaced repetition engine.
/// Isolated so the algorithm can be upgraded without touching UI or storage.
class ReviewEngine {
  const ReviewEngine();

  ReviewScheduleResult schedule({
    required ReviewRating rating,
    required double easeFactor,
    required int intervalDays,
    required int repetitions,
    DateTime? now,
  }) {
    final timestamp = now ?? DateTime.now();
    var ef = easeFactor;
    var interval = intervalDays;
    var reps = repetitions;

    switch (rating) {
      case ReviewRating.forgot:
        reps = 0;
        interval = 0;
        ef = (ef - 0.2).clamp(1.3, 3.0);
      case ReviewRating.difficult:
        if (reps == 0) {
          interval = 1;
        } else {
          interval = (interval * 1.2).round().clamp(1, 3650);
        }
        reps += 1;
        ef = (ef - 0.15).clamp(1.3, 3.0);
      case ReviewRating.good:
        if (reps == 0) {
          interval = 1;
        } else if (reps == 1) {
          interval = 3;
        } else {
          interval = (interval * ef).round().clamp(1, 3650);
        }
        reps += 1;
        ef = (ef + 0.0).clamp(1.3, 3.0);
      case ReviewRating.easy:
        if (reps == 0) {
          interval = 2;
        } else if (reps == 1) {
          interval = 4;
        } else {
          interval = (interval * ef * 1.3).round().clamp(1, 3650);
        }
        reps += 1;
        ef = (ef + 0.15).clamp(1.3, 3.0);
    }

    final mastery = _masteryFor(reps: reps, rating: rating, interval: interval);
    final nextReviewAt = interval == 0
        ? timestamp
        : DateTime(timestamp.year, timestamp.month, timestamp.day)
            .add(Duration(days: interval));

    return ReviewScheduleResult(
      easeFactor: ef,
      intervalDays: interval,
      repetitions: reps,
      nextReviewAt: nextReviewAt,
      masteryStatus: mastery,
      isCorrect: rating == ReviewRating.good || rating == ReviewRating.easy,
    );
  }

  MasteryStatus _masteryFor({
    required int reps,
    required ReviewRating rating,
    required int interval,
  }) {
    if (rating == ReviewRating.forgot) return MasteryStatus.learning;
    if (interval >= 21 && reps >= 4) return MasteryStatus.mastered;
    if (reps >= 2) return MasteryStatus.reviewing;
    return MasteryStatus.learning;
  }
}

class ReviewScheduleResult {
  const ReviewScheduleResult({
    required this.easeFactor,
    required this.intervalDays,
    required this.repetitions,
    required this.nextReviewAt,
    required this.masteryStatus,
    required this.isCorrect,
  });

  final double easeFactor;
  final int intervalDays;
  final int repetitions;
  final DateTime nextReviewAt;
  final MasteryStatus masteryStatus;
  final bool isCorrect;
}
