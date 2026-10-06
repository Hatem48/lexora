import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/widgets/content_filter_sheet.dart';
import 'package:lexora/features/home/domain/daily_plan.dart';

void main() {
  test('a second filter tap does nothing while the first sheet is opening', () async {
    final launch = ContentFilterLaunch();
    var calls = 0;
    final first = launch.tryEnter();
    final second = launch.tryEnter();
    expect(first, isTrue);
    expect(second, isFalse);
    expect(launch.busy, isTrue);
    calls++;
    launch.leave();
    expect(launch.tryEnter(), isTrue);
    calls++;
    expect(calls, 2);
  });

  test('today plan resets each day and keeps finished tasks on the list', () {
    const yesterday = DailyPlanState(
      day: '2026-10-05',
      step: 2,
      done: {'review', 'words'},
    );
    final today = planForDay(stored: yesterday, today: '2026-10-06');
    expect(today.step, 0);
    expect(today.done, isEmpty);
    expect(dailyTaskIds, hasLength(4));

    final sameDay = planForDay(stored: yesterday, today: '2026-10-05');
    expect(sameDay.step, 2);
    expect(sameDay.done, {'review', 'words'});

    final checked = toggleDailyTask(sameDay, 'review');
    expect(checked.done.contains('review'), isFalse);
    expect(dailyTaskIds, contains('review'));

    final marked = toggleDailyTask(checked, 'sentence');
    expect(marked.done, {'words', 'sentence'});
    expect(dailyTaskIds, containsAll(marked.done));
    expect(unfinishedDailyTasks(marked), 2);

    var step = DailyPlanState(day: '2026-10-06', step: 0, done: const {});
    step = acknowledgeStep(step);
    step = acknowledgeStep(step);
    step = acknowledgeStep(step);
    final finished = acknowledgeStep(step);
    expect(finished.step, dailyJourneySteps);
    expect(finished.journeyFinished, isTrue);
    expect(acknowledgeStep(finished).step, dailyJourneySteps);

    final raw = encodeDailyPlan(marked);
    expect(decodeDailyPlan(raw)!.done, marked.done);
    expect(dailyTaskRoute('words'), '/words');
    expect(dailyTaskRoute('topic'), '/topics');
  });
}
