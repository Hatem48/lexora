import 'dart:convert';

class PriorityConfig {
  const PriorityConfig({
    required this.catalogVersion,
    required this.generalFrequency,
    required this.spokenFrequency,
    required this.academic,
    required this.cefr,
    required this.newsRelevance,
    required this.ielts,
    required this.toefl,
    required this.topicRelevance,
    required this.cefrScores,
  });

  final int catalogVersion;
  final double generalFrequency;
  final double spokenFrequency;
  final double academic;
  final double cefr;
  final double newsRelevance;
  final double ielts;
  final double toefl;
  final double topicRelevance;
  final Map<String, double> cefrScores;

  factory PriorityConfig.parse(String raw) {
    final json = jsonDecode(raw);
    if (json is! Map<String, dynamic>) {
      throw const FormatException('priority config must be an object');
    }
    final weights = json['weights'];
    final scores = json['cefrScores'];
    if (weights is! Map<String, dynamic> || scores is! Map<String, dynamic>) {
      throw const FormatException('priority config is missing weights or cefrScores');
    }
    double weight(String key) {
      final value = weights[key];
      if (value is! num) {
        throw FormatException('priority weight "$key" must be a number');
      }
      return value.toDouble();
    }

    return PriorityConfig(
      catalogVersion: json['catalogVersion'] as int? ?? 1,
      generalFrequency: weight('generalFrequency'),
      spokenFrequency: weight('spokenFrequency'),
      academic: weight('academic'),
      cefr: weight('cefr'),
      newsRelevance: weight('newsRelevance'),
      ielts: weight('ielts'),
      toefl: weight('toefl'),
      topicRelevance: weight('topicRelevance'),
      cefrScores: {
        for (final entry in scores.entries)
          if (entry.value is num) entry.key: (entry.value as num).toDouble(),
      },
    );
  }
}

class CefrObservation {
  const CefrObservation({
    required this.lemma,
    required this.pos,
    required this.cefr,
    required this.sourceId,
    required this.displayLemma,
  });

  final String lemma;
  final String pos;
  final String cefr;
  final String sourceId;
  final String displayLemma;
}

class RankObservation {
  const RankObservation({
    required this.lemma,
    required this.pos,
    required this.rank,
    required this.sourceId,
  });

  final String lemma;
  final String? pos;
  final int rank;
  final String sourceId;
}

class FormObservation {
  const FormObservation({
    required this.lemma,
    required this.pos,
    required this.form,
  });

  final String lemma;
  final String pos;
  final String form;
}

class TopicMapping {
  const TopicMapping({
    required this.lemma,
    required this.pos,
    required this.topicId,
    required this.relevance,
  });

  final String lemma;
  final String pos;
  final String topicId;
  final String relevance;
}

class CatalogWord {
  CatalogWord({
    required this.id,
    required this.lemma,
    required this.pos,
    required this.cefr,
    required this.cefrSource,
    required this.catalogVersion,
  });

  final String id;
  final String lemma;
  final String pos;
  final String cefr;
  final String cefrSource;
  final int catalogVersion;
  int? ngslRank;
  int? spokenRank;
  int? academicRank;
  int? newsRelevance;
  int? priorityScore;
  bool academic = false;
  bool generalEnglish = false;
  bool spokenEnglish = false;
  bool ieltsRelevant = false;
  bool toeflRelevant = false;
  String definitionEn = '';
  String arabicMeaning = '';
  String exampleSentence = '';
  final List<String> forms = [];
  final Map<String, String> sources = {};

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'lemma': lemma,
      'cefr': cefr,
      'pos': pos,
      'definitionEn': definitionEn,
      'arabicMeaning': arabicMeaning,
      'example': exampleSentence,
      'phonetic': null,
      'academic': academic,
      'generalEnglish': generalEnglish,
      'spokenEnglish': spokenEnglish,
      'ngslRank': ngslRank,
      'spokenRank': spokenRank,
      'academicRank': academicRank,
      'newsRelevance': newsRelevance,
      'ielts': ieltsRelevant,
      'toefl': toeflRelevant,
      'priorityScore': priorityScore,
      'catalogVersion': catalogVersion,
      'forms': forms,
      'sources': sources,
    };
  }
}

class LevelConflict {
  const LevelConflict({
    required this.lemma,
    required this.pos,
    required this.levelsBySource,
  });

  final String lemma;
  final String pos;
  final Map<String, String> levelsBySource;

  Map<String, Object?> toJson() => {
        'lemma': lemma,
        'partOfSpeech': pos,
        'levelsBySource': levelsBySource,
      };
}

class ValidationIssue {
  const ValidationIssue(this.message);

  final String message;
}
