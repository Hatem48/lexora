import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_detection_engine.dart';

void main() {
  const index = VocabularyIndex({
    'develop': 'develop',
    'develops': 'develop',
    'developed': 'develop',
    'developing': 'develop',
    'development': 'development',
    'developments': 'development',
  });

  test('inflections map to one lemma and development stays separate', () {
    final hits = VocabularyDetectionEngine.detect(
      'Develop developed DEVELOPING development',
      index,
    );
    final byId = {for (final hit in hits) hit.entryId: hit.occurrences};
    expect(byId['develop'], 3);
    expect(byId['development'], 1);
    expect(hits.map((hit) => hit.entryId).toSet(), {'develop', 'development'});
  });

  test('punctuation and parentheses do not block a match', () {
    final hits = VocabularyDetectionEngine.detect(
      'develop. develop! (develop)',
      index,
    );
    expect(hits, hasLength(1));
    expect(hits.single.entryId, 'develop');
    expect(hits.single.occurrences, 3);
  });

  test('unknown words are ignored', () {
    final hits = VocabularyDetectionEngine.detect('xyzzy qwerty', index);
    expect(hits, isEmpty);
  });
}
