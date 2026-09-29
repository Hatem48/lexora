import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/constants/enums.dart';
import 'package:lexora/core/services/pronunciation/voice_ranker.dart';

void main() {
  test('prefers neural voice for the selected accent', () {
    final voices = [
      {'name': 'en-us-local', 'locale': 'en-US', 'quality': 'normal'},
      {'name': 'en-us-neural', 'locale': 'en-US', 'quality': 'high'},
      {'name': 'en-gb-neural', 'locale': 'en-GB', 'quality': 'high'},
    ];

    final best = bestVoice(voices, PronunciationAccent.american);
    expect(best?['name'], 'en-us-neural');
  });

  test('ignores non-english voices', () {
    final voices = [
      {'name': 'ar-local', 'locale': 'ar-SA'},
    ];
    expect(bestVoice(voices, PronunciationAccent.american), isNull);
  });
}
