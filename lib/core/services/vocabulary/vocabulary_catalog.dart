import 'dart:convert';

class CatalogEntry {
  const CatalogEntry({
    required this.id,
    required this.lemma,
    required this.cefr,
    required this.pos,
    required this.definitionEn,
    required this.arabicMeaning,
    required this.example,
    this.phonetic,
    this.academic = false,
    this.ielts = false,
    this.toefl = false,
    this.generalEnglish = false,
    this.spokenEnglish = false,
    this.ngslRank,
    this.spokenRank,
    this.academicRank,
    this.newsRelevance,
    this.priorityScore,
    required this.forms,
  });

  final String id;
  final String lemma;
  final String cefr;
  final String pos;
  final String definitionEn;
  final String arabicMeaning;
  final String example;
  final String? phonetic;
  final bool academic;
  final bool ielts;
  final bool toefl;
  final bool generalEnglish;
  final bool spokenEnglish;
  final int? ngslRank;
  final int? spokenRank;
  final int? academicRank;
  final int? newsRelevance;
  final int? priorityScore;
  final List<String> forms;
}

class VocabularyCatalogDocument {
  const VocabularyCatalogDocument({
    required this.version,
    required this.datasetType,
    required this.entries,
  });

  static const productionDatasetType = 'production';

  final int version;
  final String datasetType;
  final List<CatalogEntry> entries;

  /// Stored import key. A development file and a later production file
  /// with the same version number stay distinct, so one cannot block the other.
  String get identity => '$version:$datasetType';

  factory VocabularyCatalogDocument.parse(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('vocabulary catalog must be an object');
    }
    final version = decoded['version'];
    final entries = decoded['entries'];
    if (version is! int || entries is! List) {
      throw const FormatException('vocabulary catalog is missing version or entries');
    }
    return VocabularyCatalogDocument(
      version: version,
      datasetType: _datasetType(decoded['datasetType']),
      entries: [
        for (final item in entries)
          if (item is Map<String, dynamic>) _entry(item),
      ],
    );
  }

  static String _datasetType(Object? value) {
    if (value is String && value.trim().isNotEmpty) return value.trim();
    return productionDatasetType;
  }

  static CatalogEntry _entry(Map<String, dynamic> json) {
    final forms = json['forms'];
    return CatalogEntry(
      id: json['id'] as String,
      lemma: json['lemma'] as String,
      cefr: json['cefr'] as String,
      pos: json['pos'] as String,
      definitionEn: json['definitionEn'] as String,
      arabicMeaning: json['arabicMeaning'] as String,
      example: json['example'] as String,
      phonetic: json['phonetic'] as String?,
      academic: json['academic'] == true,
      ielts: json['ielts'] == true,
      toefl: json['toefl'] == true,
      generalEnglish: json['generalEnglish'] == true,
      spokenEnglish: json['spokenEnglish'] == true,
      ngslRank: _optionalInt(json['ngslRank']),
      spokenRank: _optionalInt(json['spokenRank']),
      academicRank: _optionalInt(json['academicRank']),
      newsRelevance: _optionalInt(json['newsRelevance']),
      priorityScore: _optionalInt(json['priorityScore']),
      forms: [
        if (forms is List)
          for (final form in forms)
            if (form is String) form.toLowerCase(),
      ],
    );
  }

  static int? _optionalInt(Object? value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return null;
  }
}
