import 'dart:convert';

class TopicCatalogDocument {
  const TopicCatalogDocument({
    required this.version,
    required this.datasetType,
    required this.groups,
    required this.topics,
    required this.links,
    required this.sentences,
    required this.paths,
    required this.ranks,
  });

  static const productionDatasetType = 'production';

  final int version;
  final String datasetType;
  final List<TopicGroupData> groups;
  final List<TopicData> topics;
  final List<TopicLinkData> links;
  final List<TopicSentenceData> sentences;
  final List<LearningPathData> paths;
  final List<EntryRankData> ranks;

  String get identity => '$version:$datasetType';

  factory TopicCatalogDocument.parse(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('topics catalog must be an object');
    }
    final version = decoded['version'];
    if (version is! int) {
      throw const FormatException('topics catalog is missing version');
    }
    return TopicCatalogDocument(
      version: version,
      datasetType: _datasetType(decoded['datasetType']),
      groups: _maps(decoded['groups']).map(TopicGroupData.fromJson).toList(),
      topics: _maps(decoded['topics']).map(TopicData.fromJson).toList(),
      links: _maps(decoded['links']).map(TopicLinkData.fromJson).toList(),
      sentences:
          _maps(decoded['sentences']).map(TopicSentenceData.fromJson).toList(),
      paths: _maps(decoded['paths']).map(LearningPathData.fromJson).toList(),
      ranks: _maps(decoded['ranks']).map(EntryRankData.fromJson).toList(),
    );
  }

  static String _datasetType(Object? value) {
    if (value is String && value.trim().isNotEmpty) return value.trim();
    return productionDatasetType;
  }

  static List<Map<String, dynamic>> _maps(Object? raw) {
    if (raw is! List) return const [];
    return [
      for (final item in raw)
        if (item is Map<String, dynamic>) item,
    ];
  }
}

class TopicGroupData {
  const TopicGroupData({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.sortOrder,
  });

  final String id;
  final String nameEn;
  final String nameAr;
  final int sortOrder;

  factory TopicGroupData.fromJson(Map<String, dynamic> json) {
    return TopicGroupData(
      id: json['id'] as String,
      nameEn: json['nameEn'] as String,
      nameAr: json['nameAr'] as String,
      sortOrder: json['sortOrder'] as int? ?? 0,
    );
  }
}

class TopicData {
  const TopicData({
    required this.id,
    required this.slug,
    required this.groupId,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.iconKey,
    required this.sortOrder,
    required this.enabled,
  });

  final String id;
  final String slug;
  final String groupId;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String iconKey;
  final int sortOrder;
  final bool enabled;

  factory TopicData.fromJson(Map<String, dynamic> json) {
    return TopicData(
      id: json['id'] as String,
      slug: json['slug'] as String? ?? json['id'] as String,
      groupId: json['groupId'] as String,
      nameEn: json['nameEn'] as String,
      nameAr: json['nameAr'] as String,
      descriptionEn: json['descriptionEn'] as String? ?? '',
      descriptionAr: json['descriptionAr'] as String? ?? '',
      iconKey: json['iconKey'] as String? ?? 'folder',
      sortOrder: json['sortOrder'] as int? ?? 0,
      enabled: json['enabled'] != false,
    );
  }
}

class TopicLinkData {
  const TopicLinkData({
    required this.entryId,
    required this.topicId,
    required this.relevance,
  });

  final String entryId;
  final String topicId;
  final String relevance;

  factory TopicLinkData.fromJson(Map<String, dynamic> json) {
    return TopicLinkData(
      entryId: json['entryId'] as String,
      topicId: json['topicId'] as String,
      relevance: json['relevance'] as String? ?? 'medium',
    );
  }
}

class TopicSentenceData {
  const TopicSentenceData({
    required this.id,
    required this.sentenceEn,
    required this.sentenceAr,
    required this.cefr,
    required this.sortOrder,
    required this.enabled,
    required this.topicIds,
  });

  final String id;
  final String sentenceEn;
  final String sentenceAr;
  final String cefr;
  final int sortOrder;
  final bool enabled;
  final List<String> topicIds;

  factory TopicSentenceData.fromJson(Map<String, dynamic> json) {
    final topics = json['topics'];
    return TopicSentenceData(
      id: json['id'] as String,
      sentenceEn: json['en'] as String,
      sentenceAr: json['ar'] as String,
      cefr: json['cefr'] as String,
      sortOrder: json['sortOrder'] as int? ?? 0,
      enabled: json['enabled'] != false,
      topicIds: [
        if (topics is List)
          for (final id in topics)
            if (id is String) id,
      ],
    );
  }
}

class LearningPathData {
  const LearningPathData({
    required this.id,
    required this.slug,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.sortOrder,
    required this.enabled,
    required this.topicIds,
  });

  final String id;
  final String slug;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final int sortOrder;
  final bool enabled;
  final List<String> topicIds;

  factory LearningPathData.fromJson(Map<String, dynamic> json) {
    final topics = json['topics'];
    return LearningPathData(
      id: json['id'] as String,
      slug: json['slug'] as String? ?? json['id'] as String,
      nameEn: json['nameEn'] as String,
      nameAr: json['nameAr'] as String,
      descriptionEn: json['descriptionEn'] as String? ?? '',
      descriptionAr: json['descriptionAr'] as String? ?? '',
      sortOrder: json['sortOrder'] as int? ?? 0,
      enabled: json['enabled'] != false,
      topicIds: [
        if (topics is List)
          for (final id in topics)
            if (id is String) id,
      ],
    );
  }
}

class EntryRankData {
  const EntryRankData({
    required this.entryId,
    this.frequencyRank,
    this.generalImportance,
    this.spokenRelevance,
    this.newsRelevance,
  });

  final String entryId;
  final int? frequencyRank;
  final int? generalImportance;
  final int? spokenRelevance;
  final int? newsRelevance;

  factory EntryRankData.fromJson(Map<String, dynamic> json) {
    return EntryRankData(
      entryId: json['entryId'] as String,
      frequencyRank: json['frequencyRank'] as int?,
      generalImportance: json['generalImportance'] as int?,
      spokenRelevance: json['spokenRelevance'] as int?,
      newsRelevance: json['newsRelevance'] as int?,
    );
  }
}
