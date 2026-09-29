import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../constants/enums.dart';
import '../../database/app_database.dart';
import 'topic_catalog.dart';

const topicsCatalogAsset = 'assets/vocabulary/topics.json';
const topicsCatalogVersionKey = 'topics_catalog_version';

/// Upserts static topic data. User vocabulary progress is never changed.
class TopicCatalogImporter {
  TopicCatalogImporter(this._db);

  final AppDatabase _db;

  Future<void> importAssetIfNeeded() async {
    final raw = await rootBundle.loadString(topicsCatalogAsset);
    await importJson(raw);
  }

  Future<void> importJson(String raw) async {
    final document = TopicCatalogDocument.parse(raw);
    final stored = await (_db.select(_db.appStatistics)
          ..where((row) => row.key.equals(topicsCatalogVersionKey)))
        .getSingleOrNull();
    if (stored?.value == document.identity) return;

    final knownEntries = {
      for (final row in await _db.select(_db.vocabularyEntries).get()) row.id,
    };

    await _db.transaction(() async {
      await _db.delete(_db.vocabularyTopics).go();
      await _db.delete(_db.topicSentenceTopics).go();
      await _db.delete(_db.learningPathTopics).go();

      for (final group in document.groups) {
        await _db.into(_db.topicGroups).insert(
              TopicGroupsCompanion.insert(
                id: group.id,
                nameEn: group.nameEn,
                nameAr: group.nameAr,
                sortOrder: Value(group.sortOrder),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
      for (final topic in document.topics) {
        await _db.into(_db.topics).insert(
              TopicsCompanion.insert(
                id: topic.id,
                slug: topic.slug,
                groupId: topic.groupId,
                nameEn: topic.nameEn,
                nameAr: topic.nameAr,
                descriptionEn: topic.descriptionEn,
                descriptionAr: topic.descriptionAr,
                iconKey: topic.iconKey,
                sortOrder: Value(topic.sortOrder),
                enabled: Value(topic.enabled),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
      for (final link in document.links) {
        if (!knownEntries.contains(link.entryId)) continue;
        final relevance = TopicRelevance.fromStorage(link.relevance);
        await _db.into(_db.vocabularyTopics).insert(
              VocabularyTopicsCompanion.insert(
                entryId: link.entryId,
                topicId: link.topicId,
                relevance: relevance.storageValue,
                weight: relevance.weight,
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
      for (final sentence in document.sentences) {
        await _db.into(_db.topicSentences).insert(
              TopicSentencesCompanion.insert(
                id: sentence.id,
                sentenceEn: sentence.sentenceEn,
                sentenceAr: sentence.sentenceAr,
                cefrLevel: sentence.cefr,
                sortOrder: Value(sentence.sortOrder),
                enabled: Value(sentence.enabled),
              ),
              mode: InsertMode.insertOrReplace,
            );
        for (final topicId in sentence.topicIds) {
          await _db.into(_db.topicSentenceTopics).insert(
                TopicSentenceTopicsCompanion.insert(
                  sentenceId: sentence.id,
                  topicId: topicId,
                ),
                mode: InsertMode.insertOrReplace,
              );
        }
      }
      for (final path in document.paths) {
        await _db.into(_db.learningPaths).insert(
              LearningPathsCompanion.insert(
                id: path.id,
                slug: path.slug,
                nameEn: path.nameEn,
                nameAr: path.nameAr,
                descriptionEn: path.descriptionEn,
                descriptionAr: path.descriptionAr,
                sortOrder: Value(path.sortOrder),
                enabled: Value(path.enabled),
              ),
              mode: InsertMode.insertOrReplace,
            );
        for (var i = 0; i < path.topicIds.length; i++) {
          await _db.into(_db.learningPathTopics).insert(
                LearningPathTopicsCompanion.insert(
                  pathId: path.id,
                  topicId: path.topicIds[i],
                  sortOrder: Value(i),
                ),
                mode: InsertMode.insertOrReplace,
              );
        }
      }
      for (final rank in document.ranks) {
        if (!knownEntries.contains(rank.entryId)) continue;
        await _db.into(_db.vocabularyEntryRanks).insert(
              VocabularyEntryRanksCompanion.insert(
                entryId: rank.entryId,
                frequencyRank: Value(rank.frequencyRank),
                generalImportance: Value(rank.generalImportance),
                spokenRelevance: Value(rank.spokenRelevance),
                newsRelevance: Value(rank.newsRelevance),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
      await _db.into(_db.appStatistics).insertOnConflictUpdate(
            AppStatisticsCompanion.insert(
              key: topicsCatalogVersionKey,
              value: document.identity,
              updatedAt: DateTime.now().toUtc(),
            ),
          );
    });
  }
}
