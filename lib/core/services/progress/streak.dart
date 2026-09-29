/// Consecutive calendar-day streaks from review timestamps.
class StreakStats {
  const StreakStats({required this.current, required this.longest});

  final int current;
  final int longest;
}

DateTime _day(DateTime value) => DateTime(value.year, value.month, value.day);

StreakStats streakStats(Iterable<DateTime> reviewedAt, {DateTime? today}) {
  final days = reviewedAt.map(_day).toSet().toList()..sort();
  if (days.isEmpty) return const StreakStats(current: 0, longest: 0);

  var longest = 1;
  var run = 1;
  for (var i = 1; i < days.length; i++) {
    final gap = days[i].difference(days[i - 1]).inDays;
    run = gap == 1 ? run + 1 : 1;
    if (run > longest) longest = run;
  }

  final now = _day(today ?? DateTime.now());
  final latest = days.last;
  if (latest.isBefore(now.subtract(const Duration(days: 1)))) {
    return StreakStats(current: 0, longest: longest);
  }

  final set = days.toSet();
  var current = 0;
  var cursor = latest;
  while (set.contains(cursor)) {
    current++;
    cursor = cursor.subtract(const Duration(days: 1));
  }
  return StreakStats(current: current, longest: longest);
}

List<int> reviewsPerDay(Iterable<DateTime> reviewedAt, {DateTime? today}) {
  final end = _day(today ?? DateTime.now());
  final counts = List<int>.filled(7, 0);
  for (final value in reviewedAt) {
    final day = _day(value);
    final index = 6 - end.difference(day).inDays;
    if (index >= 0 && index < 7) counts[index]++;
  }
  return counts;
}
