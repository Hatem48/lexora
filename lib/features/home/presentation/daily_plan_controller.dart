import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/daily_plan.dart';

final dailyPlanProvider =
    AsyncNotifierProvider<DailyPlanController, DailyPlanState>(
  DailyPlanController.new,
);

class DailyPlanController extends AsyncNotifier<DailyPlanState> {
  @override
  Future<DailyPlanState> build() async {
    final prefs = await SharedPreferences.getInstance();
    return planForDay(
      stored: decodeDailyPlan(prefs.getString(dailyPlanPrefsKey)),
      today: dailyPlanDay(DateTime.now()),
    );
  }

  Future<void> acknowledge() async {
    final current = state.asData?.value;
    if (current == null) return;
    await _save(acknowledgeStep(current));
  }

  Future<void> toggle(String taskId) async {
    final current = state.asData?.value;
    if (current == null) return;
    await _save(toggleDailyTask(current, taskId));
  }

  Future<void> _save(DailyPlanState next) async {
    state = AsyncData(next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(dailyPlanPrefsKey, encodeDailyPlan(next));
  }
}
