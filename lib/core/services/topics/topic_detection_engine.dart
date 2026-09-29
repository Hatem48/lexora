/// A catalog word linked to a topic, with a numeric relevance weight.
class TopicTermLink {
  const TopicTermLink({
    required this.topicId,
    required this.entryId,
    required this.weight,
  });

  final String topicId;
  final String entryId;
  final int weight;
}

class TopicSignal {
  const TopicSignal({
    required this.topicId,
    required this.score,
    required this.matchCount,
    required this.strongCount,
  });

  final String topicId;
  final int score;
  final int matchCount;
  final int strongCount;
}

/// Local topic scoring. One weak word never marks a topic as detected.
abstract final class TopicDetectionEngine {
  static const strongWeight = 3;

  static List<TopicSignal> detect(Iterable<TopicTermLink> links) {
    final byTopic = <String, List<TopicTermLink>>{};
    for (final link in links) {
      byTopic.putIfAbsent(link.topicId, () => []).add(link);
    }

    final signals = <TopicSignal>[];
    for (final entry in byTopic.entries) {
      final unique = <String, int>{};
      for (final link in entry.value) {
        final current = unique[link.entryId];
        if (current == null || link.weight > current) {
          unique[link.entryId] = link.weight;
        }
      }
      final score = unique.values.fold<int>(0, (sum, weight) => sum + weight);
      final strong = unique.values.where((weight) => weight >= strongWeight).length;
      final signal = TopicSignal(
        topicId: entry.key,
        score: score,
        matchCount: unique.length,
        strongCount: strong,
      );
      if (_isDetected(signal)) signals.add(signal);
    }

    signals.sort((a, b) => b.score.compareTo(a.score));
    return signals;
  }

  /// Two strong links, or three related links whose weights add up.
  static bool _isDetected(TopicSignal signal) {
    if (signal.strongCount >= 2) return true;
    return signal.matchCount >= 3 && signal.score >= 6;
  }
}
