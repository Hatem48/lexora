import 'models.dart';

/// Higher rank numbers are less frequent. Missing signals are omitted,
/// not treated as zero, unless that source file was loaded and the word
/// is known to be absent from it.
int? priorityScore({
  required PriorityConfig config,
  required String cefr,
  required int? ngslRank,
  required int? spokenRank,
  required bool? academic,
  required int? newsRelevance,
  required bool ieltsRelevant,
  required bool toeflRelevant,
  required int? maxNgslRank,
  required int? maxSpokenRank,
  required int? maxNewsRank,
}) {
  final parts = <({double weight, double value})>[];

  void add(double weight, double value) {
    if (weight > 0) parts.add((weight: weight, value: value));
  }

  if (ngslRank != null && maxNgslRank != null) {
    add(config.generalFrequency, _frequency(ngslRank, maxNgslRank));
  }
  if (spokenRank != null && maxSpokenRank != null) {
    add(config.spokenFrequency, _frequency(spokenRank, maxSpokenRank));
  }
  if (academic != null) {
    add(config.academic, academic ? 1 : 0);
  }
  final cefrScore = config.cefrScores[cefr];
  if (cefrScore != null) add(config.cefr, cefrScore);
  if (newsRelevance != null && maxNewsRank != null) {
    add(config.newsRelevance, _frequency(newsRelevance, maxNewsRank));
  }
  if (ieltsRelevant) add(config.ielts, 1);
  if (toeflRelevant) add(config.toefl, 1);

  if (parts.isEmpty) return null;
  final denominator = parts.fold<double>(0, (sum, part) => sum + part.weight);
  final numerator = parts.fold<double>(
    0,
    (sum, part) => sum + part.weight * part.value,
  );
  return (1000 * numerator / denominator).round();
}

double _frequency(int rank, int maxRank) {
  if (maxRank <= 1) return 1;
  final clamped = rank.clamp(1, maxRank);
  return 1 - ((clamped - 1) / (maxRank - 1));
}
