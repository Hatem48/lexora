import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/services/progress/streak.dart';

void main() {
  final today = DateTime(2026, 9, 29);

  test('current streak counts consecutive days through today', () {
    final stats = streakStats([
      DateTime(2026, 9, 27, 8),
      DateTime(2026, 9, 28, 9),
      DateTime(2026, 9, 29, 10),
    ], today: today);
    expect(stats.current, 3);
    expect(stats.longest, 3);
  });

  test('a gap ends the current streak', () {
    final stats = streakStats([
      DateTime(2026, 9, 20),
      DateTime(2026, 9, 21),
      DateTime(2026, 9, 22),
      DateTime(2026, 9, 26),
    ], today: today);
    expect(stats.current, 0);
    expect(stats.longest, 3);
  });

  test('reviewsPerDay fills the last seven days', () {
    final counts = reviewsPerDay([
      DateTime(2026, 9, 29, 1),
      DateTime(2026, 9, 29, 2),
      DateTime(2026, 9, 23),
    ], today: today);
    expect(counts, [1, 0, 0, 0, 0, 0, 2]);
  });
}
