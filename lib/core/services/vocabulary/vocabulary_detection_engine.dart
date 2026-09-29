/// Offline tokenization for English vocabulary detection.
abstract final class VocabularyTokenizer {
  static final _token = RegExp("[A-Za-z]+(?:'[A-Za-z]+)?");

  static List<String> tokenize(String text) {
    return _token
        .allMatches(text)
        .map((match) => match.group(0)!.toLowerCase())
        .toList();
  }
}

class VocabularyIndex {
  const VocabularyIndex(this.surfaceToEntry);

  final Map<String, String> surfaceToEntry;

  String? lookup(String surface) => surfaceToEntry[surface.toLowerCase()];
}

class DetectionHit {
  const DetectionHit({required this.entryId, required this.occurrences});

  final String entryId;
  final int occurrences;
}

/// Matches normalized tokens to catalog lemmas. Unknown words are ignored.
abstract final class VocabularyDetectionEngine {
  static List<DetectionHit> detect(String text, VocabularyIndex index) {
    final counts = <String, int>{};
    for (final token in VocabularyTokenizer.tokenize(text)) {
      final entryId = index.lookup(token);
      if (entryId == null) continue;
      counts[entryId] = (counts[entryId] ?? 0) + 1;
    }
    return [
      for (final entry in counts.entries)
        DetectionHit(entryId: entry.key, occurrences: entry.value),
    ];
  }
}
