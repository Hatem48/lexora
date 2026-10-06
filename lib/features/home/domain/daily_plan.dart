const dailyPlanPrefsKey = 'lexora_daily_plan';

const dailyJourneySteps = 3;

const dailyTaskIds = ['review', 'words', 'sentence', 'topic'];

String dailyPlanDay(DateTime now) {
  final local = now.toLocal();
  final month = local.month.toString().padLeft(2, '0');
  final day = local.day.toString().padLeft(2, '0');
  return '${local.year}-$month-$day';
}

String? dailyTaskRoute(String id) {
  return switch (id) {
    'review' => '/review',
    'words' => '/words',
    'sentence' => '/sentences',
    'topic' => '/topics',
    _ => null,
  };
}

class DailyPlanState {
  const DailyPlanState({
    required this.day,
    required this.step,
    required this.done,
  });

  final String day;
  final int step;
  final Set<String> done;

  bool get journeyFinished => step >= dailyJourneySteps;
}

DailyPlanState? decodeDailyPlan(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  final parts = raw.split('|');
  if (parts.length != 3 || parts[0].isEmpty) return null;
  final step = int.tryParse(parts[1]);
  if (step == null || step < 0) return null;
  final done = parts[2].isEmpty
      ? const <String>{}
      : parts[2].split(',').where((id) => id.isNotEmpty).toSet();
  return DailyPlanState(day: parts[0], step: step, done: done);
}

String encodeDailyPlan(DailyPlanState state) {
  final done = state.done.toList()..sort();
  return '${state.day}|${state.step}|${done.join(',')}';
}

DailyPlanState planForDay({
  required DailyPlanState? stored,
  required String today,
}) {
  if (stored == null || stored.day != today) {
    return DailyPlanState(day: today, step: 0, done: const {});
  }
  final step = stored.step > dailyJourneySteps ? dailyJourneySteps : stored.step;
  return DailyPlanState(
    day: today,
    step: step,
    done: stored.done.where(dailyTaskIds.contains).toSet(),
  );
}

DailyPlanState acknowledgeStep(DailyPlanState state) {
  if (state.journeyFinished) return state;
  return DailyPlanState(
    day: state.day,
    step: state.step + 1,
    done: state.done,
  );
}

DailyPlanState toggleDailyTask(DailyPlanState state, String taskId) {
  if (!dailyTaskIds.contains(taskId)) return state;
  final done = {...state.done};
  if (!done.remove(taskId)) done.add(taskId);
  return DailyPlanState(day: state.day, step: state.step, done: done);
}

int unfinishedDailyTasks(DailyPlanState state) {
  return dailyTaskIds.where((id) => !state.done.contains(id)).length;
}
