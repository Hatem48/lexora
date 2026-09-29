import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/constants/enums.dart';
import 'package:lexora/core/services/review/review_engine.dart';

void main() {
  const engine = ReviewEngine();

  group('ReviewEngine', () {
    test('forgot resets repetitions and keeps item learning', () {
      final result = engine.schedule(
        rating: ReviewRating.forgot,
        easeFactor: 2.5,
        intervalDays: 6,
        repetitions: 3,
        now: DateTime(2026, 1, 1),
      );

      expect(result.repetitions, 0);
      expect(result.intervalDays, 0);
      expect(result.masteryStatus, MasteryStatus.learning);
      expect(result.isCorrect, isFalse);
      expect(result.easeFactor, lessThan(2.5));
    });

    test('good first review schedules for tomorrow', () {
      final result = engine.schedule(
        rating: ReviewRating.good,
        easeFactor: 2.5,
        intervalDays: 0,
        repetitions: 0,
        now: DateTime(2026, 1, 1),
      );

      expect(result.intervalDays, 1);
      expect(result.repetitions, 1);
      expect(result.isCorrect, isTrue);
      expect(result.nextReviewAt, DateTime(2026, 1, 2));
    });

    test('easy increases ease factor', () {
      final result = engine.schedule(
        rating: ReviewRating.easy,
        easeFactor: 2.5,
        intervalDays: 3,
        repetitions: 2,
        now: DateTime(2026, 1, 1),
      );

      expect(result.easeFactor, greaterThan(2.5));
      expect(result.intervalDays, greaterThan(3));
      expect(result.isCorrect, isTrue);
    });
  });
}
