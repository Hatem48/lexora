import 'package:flutter_test/flutter_test.dart';

bool inQuietHours(
  int minuteOfDay,
  (int, int) start,
  (int, int) end,
) {
  final startM = start.$1 * 60 + start.$2;
  final endM = end.$1 * 60 + end.$2;
  if (startM == endM) return false;
  if (startM < endM) {
    return minuteOfDay >= startM && minuteOfDay < endM;
  }
  return minuteOfDay >= startM || minuteOfDay < endM;
}

void main() {
  test('overnight quiet hours cover late night and early morning', () {
    expect(inQuietHours(23 * 60, (22, 0), (7, 0)), isTrue);
    expect(inQuietHours(3 * 60, (22, 0), (7, 0)), isTrue);
    expect(inQuietHours(12 * 60, (22, 0), (7, 0)), isFalse);
  });

  test('same-day quiet hours', () {
    expect(inQuietHours(14 * 60, (13, 0), (15, 0)), isTrue);
    expect(inQuietHours(16 * 60, (13, 0), (15, 0)), isFalse);
  });
}
