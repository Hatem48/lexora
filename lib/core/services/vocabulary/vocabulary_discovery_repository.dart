import 'dart:convert';

import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import '../topics/topic_repository.dart';
import 'vocabulary_detection_engine.dart';

class UnlockedWord {
  const UnlockedWord({
    required this.entryId,
    required this.lemma,
    required this.cefr,
  });

  final String entryId;
  final String lemma;
  final String cefr;
}

class DiscoverySummary {
  const DiscoverySummary({
    required this.tokenCount,
    required this.uniqueClassified,
    required this.cefrDistribution,
    required this.newlyDiscovered,
    this.detectedTopics = const [],
  });

  final int tokenCount;
  final int uniqueClassified;
  final Map<String, int> cefrDistribution;
  final List<UnlockedWord> newlyDiscovered;
  final List<DetectedTopic> detectedTopics;

  int get newCount => newlyDiscovered.length;
}

/// Records lemma usage when text is saved. Unknown tokens stay ignored.
class VocabularyDiscoveryRepository {
  VocabularyDiscoveryRepository(this._db);

  final AppDatabase _db;

  Future<VocabularyIndex> loadIndex() async {
    final forms = await _db.select(_db.vocabularyForms).get();
    return VocabularyIndex({
      for (final form in forms) form.surface.toLowerCase(): form.entryId,
    });
  }

  Future<DiscoverySummary> analyzeAndRecord({
    required String text,
    required String discoveredIn,
    required String sourceId,
    bool trackBlogLinks = false,
  }) async {
    final index = await loadIndex();
    final hits = VocabularyDetectionEngine.detect(text, index);
    final now = DateTime.now();
    final newly = <UnlockedWord>[];
    final distribution = <String, int>{};

    await _db.transaction(() async {
      for (final hit in hits) {
        final entry = await (_db.select(_db.vocabularyEntries)
              ..where((row) => row.id.equals(hit.entryId)))
            .getSingleOrNull();
        if (entry == null) continue;
        distribution[entry.cefrLevel] =
            (distribution[entry.cefrLevel] ?? 0) + 1;

        if (trackBlogLinks) {
          final link = await (_db.select(_db.blogVocabulary)
                ..where(
                  (row) =>
                      row.blogId.equals(sourceId) &
                      row.entryId.equals(hit.entryId),
                ))
              .getSingleOrNull();
          if (link != null) {
            await (_db.update(_db.blogVocabulary)
                  ..where(
                    (row) =>
                        row.blogId.equals(sourceId) &
                        row.entryId.equals(hit.entryId),
                  ))
                .write(
              BlogVocabularyCompanion(occurrences: Value(hit.occurrences)),
            );
            await (_db.update(_db.userVocabulary)
                  ..where((row) => row.entryId.equals(hit.entryId)))
                .write(UserVocabularyCompanion(lastUsedAt: Value(now)));
            continue;
          }
          await _db.into(_db.blogVocabulary).insert(
                BlogVocabularyCompanion.insert(
                  blogId: sourceId,
                  entryId: hit.entryId,
                  occurrences: Value(hit.occurrences),
                ),
              );
        }

        final progress = await (_db.select(_db.userVocabulary)
              ..where((row) => row.entryId.equals(hit.entryId)))
            .getSingleOrNull();
        if (progress == null) {
          await _db.into(_db.userVocabulary).insert(
                UserVocabularyCompanion.insert(
                  entryId: hit.entryId,
                  firstDiscoveredAt: now,
                  discoveredIn: discoveredIn,
                  sourceId: Value(sourceId),
                  lastUsedAt: now,
                ),
              );
          newly.add(
            UnlockedWord(
              entryId: entry.id,
              lemma: entry.lemma,
              cefr: entry.cefrLevel,
            ),
          );
        } else {
          // A repeated blog link returned above. A new sentence, or a lemma
          // newly added to this blog, counts one more use.
          await (_db.update(_db.userVocabulary)
                ..where((row) => row.entryId.equals(hit.entryId)))
              .write(
            UserVocabularyCompanion(
              usageCount: Value(progress.usageCount + 1),
              lastUsedAt: Value(now),
            ),
          );
        }
      }
    });

    final detectedTopics = await TopicRepository(_db).detectEntryIds(
      hits.map((hit) => hit.entryId),
    );

    return DiscoverySummary(
      tokenCount: VocabularyTokenizer.tokenize(text).length,
      uniqueClassified: hits.length,
      cefrDistribution: distribution,
      newlyDiscovered: newly,
      detectedTopics: detectedTopics,
    );
  }
}

String encodeCefrDistribution(Map<String, int> distribution) =>
    jsonEncode(distribution);
