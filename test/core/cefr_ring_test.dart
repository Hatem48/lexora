import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/features/home/domain/dashboard_stats.dart';

void main() {
  test('a CEFR ring uses words the learner has met', () {
    const empty = CefrLevelProgress(known: 0, total: 400);
    const started = CefrLevelProgress(known: 12, total: 400);
    const full = CefrLevelProgress(known: 10, total: 8);

    expect(empty.fraction, 0);
    expect(started.fraction, 0.03);
    expect(full.fraction, 1);
  });
}
