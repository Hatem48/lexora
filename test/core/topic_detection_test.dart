import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/services/topics/topic_detection_engine.dart';

void main() {
  test('one weak link does not detect a topic', () {
    final signals = TopicDetectionEngine.detect(const [
      TopicTermLink(topicId: 'daily-life', entryId: 'day', weight: 2),
    ]);
    expect(signals, isEmpty);
  });

  test('one strong link is not enough on its own', () {
    final signals = TopicDetectionEngine.detect(const [
      TopicTermLink(topicId: 'education', entryId: 'school', weight: 4),
    ]);
    expect(signals, isEmpty);
  });

  test('several strong links detect the topic', () {
    final signals = TopicDetectionEngine.detect(const [
      TopicTermLink(topicId: 'education', entryId: 'school', weight: 4),
      TopicTermLink(topicId: 'education', entryId: 'writing', weight: 3),
      TopicTermLink(topicId: 'education', entryId: 'academic', weight: 3),
      TopicTermLink(topicId: 'university', entryId: 'school', weight: 3),
    ]);
    expect(signals.map((signal) => signal.topicId), ['education']);
    expect(signals.single.strongCount, 3);
  });
}
