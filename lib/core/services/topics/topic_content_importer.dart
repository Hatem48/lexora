import 'dart:convert';

import 'package:drift/drift.dart';

import '../../constants/enums.dart';
import '../../database/app_database.dart';
import 'topic_question_payload.dart';

const topicContentSchemaVersion = 1;

enum TopicContentFailure { malformed, unsupportedSchema, invalid }

class TopicContentException implements Exception {
  const TopicContentException(this.failure);

  final TopicContentFailure failure;
}

class TopicContentSummary {
  const TopicContentSummary({
    required this.categoriesAdded,
    required this.categoriesUpdated,
    required this.topicsAdded,
    required this.topicsUpdated,
    required this.vocabularyLinksAdded,
    required this.vocabularyUnresolved,
    required this.sentencesAdded,
    required this.sentencesUpdated,
    required this.questionsAdded,
    required this.questionsUpdated,
    required this.warnings,
  });

  final int categoriesAdded;
  final int categoriesUpdated;
  final int topicsAdded;
  final int topicsUpdated;
  final int vocabularyLinksAdded;
  final int vocabularyUnresolved;
  final int sentencesAdded;
  final int sentencesUpdated;
  final int questionsAdded;
  final int questionsUpdated;
  final int warnings;
}

class TopicContentImporter {
  TopicContentImporter(this._db);

  final AppDatabase _db;

  Future<TopicContentSummary> importJson(
    String raw, {
    bool abortBeforeCommit = false,
  }) async {
    final document = TopicContentDocument.parse(raw);
    final groups = await _db.select(_db.topicGroups).get();
    final topics = await _db.select(_db.topics).get();
    final knownGroups = {for (final row in groups) row.id};
    final knownTopics = {for (final row in topics) row.id: row};
    document.validate(existingCategoryIds: knownGroups);

    final entries = await _db.select(_db.vocabularyEntries).get();
    final entryIds = {for (final row in entries) row.id};
    final knownSentences = {
      for (final row in await _db.select(_db.topicSentences).get()) row.id,
    };
    final knownQuestions = {
      for (final row in await _db.select(_db.topicQuestions).get()) row.id,
    };
    final knownLinks = {
      for (final row in await _db.select(_db.vocabularyTopics).get())
        '${row.topicId}|${row.entryId}',
    };

    var unresolved = 0;
    final links = <({String topicId, String entryId})>[];
    for (final topic in document.topics) {
      for (final wordId in topic.vocabulary) {
        if (entryIds.contains(wordId)) {
          links.add((topicId: topic.id, entryId: wordId));
        } else {
          unresolved++;
        }
      }
      for (final sentence in topic.sentences) {
        for (final wordId in sentence.wordIds) {
          if (!entryIds.contains(wordId)) unresolved++;
        }
      }
      for (final question in topic.questions) {
        for (final wordId in question.wordIds) {
          if (!entryIds.contains(wordId)) unresolved++;
        }
      }
    }

    var categoriesAdded = 0;
    var categoriesUpdated = 0;
    var topicsAdded = 0;
    var topicsUpdated = 0;
    var linksAdded = 0;
    var sentencesAdded = 0;
    var sentencesUpdated = 0;
    var questionsAdded = 0;
    var questionsUpdated = 0;
    final nextGroupOrder = groups.fold<int>(
      0,
      (max, row) => row.sortOrder > max ? row.sortOrder : max,
    );
    final nextTopicOrder = topics.fold<int>(
      0,
      (max, row) => row.sortOrder > max ? row.sortOrder : max,
    );

    await _db.transaction(() async {
      var groupOrder = nextGroupOrder;
      for (final category in document.categories) {
        final exists = knownGroups.contains(category.id);
        if (exists) {
          categoriesUpdated++;
        } else {
          categoriesAdded++;
          groupOrder++;
        }
        final current = exists
            ? groups.firstWhere((row) => row.id == category.id).sortOrder
            : groupOrder;
        await _db.into(_db.topicGroups).insert(
              TopicGroupsCompanion.insert(
                id: category.id,
                nameEn: category.nameEn,
                nameAr: category.nameAr,
                sortOrder: Value(current),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }

      var topicOrder = nextTopicOrder;
      for (final topic in document.topics) {
        final current = knownTopics[topic.id];
        if (current == null) {
          topicsAdded++;
          topicOrder++;
        } else {
          topicsUpdated++;
        }
        await _db.into(_db.topics).insert(
              TopicsCompanion.insert(
                id: topic.id,
                slug: topic.id,
                groupId: topic.categoryId,
                nameEn: topic.nameEn,
                nameAr: topic.nameAr,
                descriptionEn: topic.descriptionEn,
                descriptionAr: topic.descriptionAr,
                iconKey: current?.iconKey ?? 'folder',
                sortOrder: Value(current?.sortOrder ?? topicOrder),
                enabled: Value(current?.enabled ?? true),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }

      for (final link in links) {
        final key = '${link.topicId}|${link.entryId}';
        if (!knownLinks.contains(key)) {
          linksAdded++;
          knownLinks.add(key);
        }
        await _db.into(_db.vocabularyTopics).insert(
              VocabularyTopicsCompanion.insert(
                entryId: link.entryId,
                topicId: link.topicId,
                relevance: TopicRelevance.medium.storageValue,
                weight: TopicRelevance.medium.weight,
              ),
              mode: InsertMode.insertOrReplace,
            );
      }

      for (final topic in document.topics) {
        for (var index = 0; index < topic.sentences.length; index++) {
          final sentence = topic.sentences[index];
          if (knownSentences.contains(sentence.id)) {
            sentencesUpdated++;
          } else {
            sentencesAdded++;
            knownSentences.add(sentence.id);
          }
          await _db.into(_db.topicSentences).insert(
                TopicSentencesCompanion.insert(
                  id: sentence.id,
                  sentenceEn: sentence.en,
                  sentenceAr: sentence.ar,
                  cefrLevel: sentence.cefr,
                  sortOrder: Value(index),
                ),
                mode: InsertMode.insertOrReplace,
              );
          await _db.into(_db.topicSentenceTopics).insert(
                TopicSentenceTopicsCompanion.insert(
                  sentenceId: sentence.id,
                  topicId: topic.id,
                ),
                mode: InsertMode.insertOrReplace,
              );
        }
        for (var index = 0; index < topic.questions.length; index++) {
          final question = topic.questions[index];
          if (knownQuestions.contains(question.id)) {
            questionsUpdated++;
          } else {
            questionsAdded++;
            knownQuestions.add(question.id);
          }
          await _db.into(_db.topicQuestions).insert(
                TopicQuestionsCompanion.insert(
                  id: question.id,
                  topicId: topic.id,
                  cefrLevel: question.cefr,
                  promptEn: question.promptEn,
                  promptAr: question.promptAr,
                  suggestedAnswer: question.payload.encode(),
                  sortOrder: Value(index),
                  isDevelopmentSample: const Value(false),
                ),
                mode: InsertMode.insertOrReplace,
              );
        }
      }

      if (abortBeforeCommit) {
        throw const TopicContentException(TopicContentFailure.invalid);
      }
    });

    return TopicContentSummary(
      categoriesAdded: categoriesAdded,
      categoriesUpdated: categoriesUpdated,
      topicsAdded: topicsAdded,
      topicsUpdated: topicsUpdated,
      vocabularyLinksAdded: linksAdded,
      vocabularyUnresolved: unresolved,
      sentencesAdded: sentencesAdded,
      sentencesUpdated: sentencesUpdated,
      questionsAdded: questionsAdded,
      questionsUpdated: questionsUpdated,
      warnings: unresolved,
    );
  }
}

class TopicContentDocument {
  const TopicContentDocument({
    required this.categories,
    required this.topics,
  });

  final List<TopicContentCategory> categories;
  final List<TopicContentTopic> topics;

  factory TopicContentDocument.parse(String raw) {
    final Object? decoded;
    try {
      decoded = jsonDecode(raw);
    } on FormatException {
      throw const TopicContentException(TopicContentFailure.malformed);
    }
    if (decoded is! Map<String, dynamic>) {
      throw const TopicContentException(TopicContentFailure.malformed);
    }
    final version = decoded['schemaVersion'];
    if (version is! int || version != topicContentSchemaVersion) {
      throw const TopicContentException(TopicContentFailure.unsupportedSchema);
    }
    try {
      return TopicContentDocument(
        categories: _list(decoded['categories']).map(TopicContentCategory.fromJson).toList(),
        topics: _list(decoded['topics']).map(TopicContentTopic.fromJson).toList(),
      );
    } on TopicContentException {
      rethrow;
    } catch (_) {
      throw const TopicContentException(TopicContentFailure.invalid);
    }
  }

  void validate({required Set<String> existingCategoryIds}) {
    final categoryIds = <String>{};
    for (final category in categories) {
      if (!_id(category.id) || !categoryIds.add(category.id)) {
        throw const TopicContentException(TopicContentFailure.invalid);
      }
    }
    final topicIds = <String>{};
    final sentenceIds = <String>{};
    final questionIds = <String>{};
    final availableCategories = {...existingCategoryIds, ...categoryIds};
    for (final topic in topics) {
      if (!_id(topic.id) || !topicIds.add(topic.id)) {
        throw const TopicContentException(TopicContentFailure.invalid);
      }
      if (!availableCategories.contains(topic.categoryId)) {
        throw const TopicContentException(TopicContentFailure.invalid);
      }
      for (final sentence in topic.sentences) {
        if (!_id(sentence.id) || !sentenceIds.add(sentence.id)) {
          throw const TopicContentException(TopicContentFailure.invalid);
        }
      }
      for (final question in topic.questions) {
        if (!_id(question.id) || !questionIds.add(question.id)) {
          throw const TopicContentException(TopicContentFailure.invalid);
        }
      }
    }
  }
}

class TopicContentCategory {
  const TopicContentCategory({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  final String id;
  final String nameEn;
  final String nameAr;

  factory TopicContentCategory.fromJson(Map<String, dynamic> json) {
    final name = _pair(json['name']);
    return TopicContentCategory(
      id: _requiredId(json['id']),
      nameEn: name.$1,
      nameAr: name.$2,
    );
  }
}

class TopicContentTopic {
  const TopicContentTopic({
    required this.id,
    required this.categoryId,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.vocabulary,
    required this.sentences,
    required this.questions,
  });

  final String id;
  final String categoryId;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final List<String> vocabulary;
  final List<TopicContentSentence> sentences;
  final List<TopicContentQuestion> questions;

  factory TopicContentTopic.fromJson(Map<String, dynamic> json) {
    final name = _pair(json['name']);
    final description = json['description'] == null
        ? ('', '')
        : _pair(json['description'], allowEmpty: true);
    return TopicContentTopic(
      id: _requiredId(json['id']),
      categoryId: _requiredId(json['categoryId']),
      nameEn: name.$1,
      nameAr: name.$2,
      descriptionEn: description.$1,
      descriptionAr: description.$2,
      vocabulary: _strings(json['vocabulary']),
      sentences: _list(json['sentences']).map(TopicContentSentence.fromJson).toList(),
      questions: _list(json['questions']).map(TopicContentQuestion.fromJson).toList(),
    );
  }
}

class TopicContentSentence {
  const TopicContentSentence({
    required this.id,
    required this.en,
    required this.ar,
    required this.cefr,
    required this.wordIds,
  });

  final String id;
  final String en;
  final String ar;
  final String cefr;
  final List<String> wordIds;

  factory TopicContentSentence.fromJson(Map<String, dynamic> json) {
    return TopicContentSentence(
      id: _requiredId(json['id']),
      en: _text(json['en']),
      ar: _text(json['ar']),
      cefr: _cefr(json['cefr']),
      wordIds: _strings(json['wordIds']),
    );
  }
}

class TopicContentQuestion {
  const TopicContentQuestion({
    required this.id,
    required this.type,
    required this.promptEn,
    required this.promptAr,
    required this.cefr,
    required this.wordIds,
    required this.payload,
  });

  final String id;
  final String type;
  final String promptEn;
  final String promptAr;
  final String cefr;
  final List<String> wordIds;
  final TopicQuestionPayload payload;

  factory TopicContentQuestion.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    if (type is! String ||
        !const {'conversation', 'multiple_choice', 'fill_blank'}.contains(type)) {
      throw const TopicContentException(TopicContentFailure.invalid);
    }
    final question = _pair(json['question']);
    final answer = json['answer'] == null
        ? ('', '')
        : _pair(json['answer'], allowEmpty: true);
    final options = <TopicQuestionOption>[];
    if (type == 'multiple_choice') {
      final rawOptions = json['options'];
      if (rawOptions is! List || rawOptions.isEmpty) {
        throw const TopicContentException(TopicContentFailure.invalid);
      }
      for (final item in rawOptions) {
        if (item is! Map) {
          throw const TopicContentException(TopicContentFailure.invalid);
        }
        final text = _pair(item);
        options.add(
          TopicQuestionOption(
            id: _requiredId(item['id']),
            en: text.$1,
            ar: text.$2,
          ),
        );
      }
      final correct = json['correctOptionId'];
      if (correct is! String || !options.any((option) => option.id == correct)) {
        throw const TopicContentException(TopicContentFailure.invalid);
      }
      return TopicContentQuestion(
        id: _requiredId(json['id']),
        type: type,
        promptEn: question.$1,
        promptAr: question.$2,
        cefr: _cefr(json['cefr']),
        wordIds: _strings(json['wordIds']),
        payload: TopicQuestionPayload(
          type: type,
          answerEn: answer.$1,
          answerAr: answer.$2,
          options: options,
          correctOptionId: correct,
        ),
      );
    }
    if (answer.$1.isEmpty) {
      throw const TopicContentException(TopicContentFailure.invalid);
    }
    return TopicContentQuestion(
      id: _requiredId(json['id']),
      type: type,
      promptEn: question.$1,
      promptAr: question.$2,
      cefr: _cefr(json['cefr']),
      wordIds: _strings(json['wordIds']),
      payload: TopicQuestionPayload(
        type: type,
        answerEn: answer.$1,
        answerAr: answer.$2,
        options: const [],
        correctOptionId: null,
      ),
    );
  }
}

const _cefrLevels = {'A1', 'A2', 'B1', 'B2', 'C1', 'C2'};

bool _id(String value) => value.trim().isNotEmpty;

String _requiredId(Object? value) {
  if (value is! String || value.trim().isEmpty) {
    throw const TopicContentException(TopicContentFailure.invalid);
  }
  return value.trim();
}

String _text(Object? value) {
  if (value is! String || value.trim().isEmpty) {
    throw const TopicContentException(TopicContentFailure.invalid);
  }
  return value.trim();
}

String _cefr(Object? value) {
  if (value is! String || !_cefrLevels.contains(value)) {
    throw const TopicContentException(TopicContentFailure.invalid);
  }
  return value;
}

(String, String) _pair(Object? value, {bool allowEmpty = false}) {
  if (value is! Map) {
    throw const TopicContentException(TopicContentFailure.invalid);
  }
  final en = value['en'];
  final ar = value['ar'];
  if (en is! String || ar is! String) {
    throw const TopicContentException(TopicContentFailure.invalid);
  }
  if (!allowEmpty && (en.trim().isEmpty || ar.trim().isEmpty)) {
    throw const TopicContentException(TopicContentFailure.invalid);
  }
  return (en.trim(), ar.trim());
}

List<Map<String, dynamic>> _list(Object? value) {
  if (value == null) return const [];
  if (value is! List) {
    throw const TopicContentException(TopicContentFailure.invalid);
  }
  return [
    for (final item in value)
      if (item is Map<String, dynamic>)
        item
      else if (item is Map)
        Map<String, dynamic>.from(item)
      else
        throw const TopicContentException(TopicContentFailure.invalid),
  ];
}

List<String> _strings(Object? value) {
  if (value == null) return const [];
  if (value is! List) {
    throw const TopicContentException(TopicContentFailure.invalid);
  }
  return [
    for (final item in value)
      if (item is String && item.trim().isNotEmpty)
        item.trim()
      else
        throw const TopicContentException(TopicContentFailure.invalid),
  ];
}
