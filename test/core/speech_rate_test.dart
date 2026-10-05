import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/constants/enums.dart';
import 'package:lexora/core/services/pronunciation/pronunciation_service.dart';

void main() {
  test('iOS speech stays well below the fastest rate', () {
    expect(
      speechRateFor(PlaybackSpeed.normal, platform: TargetPlatform.iOS),
      lessThan(0.5),
    );
    expect(
      speechRateFor(PlaybackSpeed.slow, platform: TargetPlatform.iOS),
      lessThan(
        speechRateFor(PlaybackSpeed.normal, platform: TargetPlatform.iOS),
      ),
    );
    expect(
      speechRateFor(PlaybackSpeed.normal, platform: TargetPlatform.android),
      lessThan(0.9),
    );
  });
}
