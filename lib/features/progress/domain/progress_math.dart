/// Consecutive-day streaks from review timestamps. Days with no reviews break the run.
({int current, int longest}) reviewStreaks(Iterable<DateTime> reviewedAt, DateTime now) {
  final days = reviewedAt
      .map((d) => DateTime(d.year, d.month, d.day))
      .toSet()
      .toList()
    ..sort();
  if (days.isEmpty) return (current: 0, longest: 0);

  var longest = 1;
  var run = 1;
  for (var i = 1; i < days.length; i++) {
    final gap = days[i].difference(days[i - 1]).inDays;
    if (gap == 1) {
      run++;
      if (run > longest) longest = run;
    } else if (gap > 1) {
      run = 1;
    }
  }

  final today = DateTime(now.year, now.month, now.day);
  final sinceLast = today.difference(days.last).inDays;
  if (sinceLast > 1) return (current: 0, longest: longest);

  var current = 1;
  for (var i = days.length - 1; i > 0; i--) {
    if (days[i].difference(days[i - 1]).inDays == 1) {
      current++;
    } else {
      break;
    }
  }
  return (current: current, longest: longest);
}

/// Seven daily counts ending today, oldest first.
List<int> countsForLastDays(Map<DateTime, int> countsByDay, DateTime now) {
  final today = DateTime(now.year, now.month, now.day);
  return List.generate(7, (i) {
    final day = today.subtract(Duration(days: 6 - i));
    return countsByDay[day] ?? 0;
  });
}
