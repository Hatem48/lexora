import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../database/app_database.dart';
import 'vocabulary_catalog.dart';

const vocabularyCatalogAsset = 'assets/vocabulary/catalog.json';
const vocabularyCatalogVersionKey = 'vocabulary_catalog_version';

/// Replaces catalog rows and forms. User progress is never touched.
class VocabularyCatalogImporter {
  VocabularyCatalogImporter(this._db);

  final AppDatabase _db;

  Future<void> importAssetIfNeeded() async {
    final raw = await rootBundle.loadString(vocabularyCatalogAsset);
    await importJson(raw);
  }

  Future<void> importJson(String raw) async {
    final document = VocabularyCatalogDocument.parse(raw);
    final stored = await (_db.select(_db.appStatistics)
          ..where((row) => row.key.equals(vocabularyCatalogVersionKey)))
        .getSingleOrNull();
    if (stored?.value == document.identity) return;

    final forms = <VocabularyFormsCompanion>[];
    final ranks = <VocabularyEntryRanksCompanion>[];
    final seenSurfaces = <String>{};
    final lemmaCounts = <String, int>{};
    for (final entry in document.entries) {
      final lemma = entry.lemma.toLowerCase();
      lemmaCounts[lemma] = (lemmaCounts[lemma] ?? 0) + 1;
    }
    for (final entry in document.entries) {
      final lemma = entry.lemma.toLowerCase();
      final surfaces = {
        if (lemma.isNotEmpty && lemmaCounts[lemma] == 1) lemma,
        ...entry.forms.map((form) => form.toLowerCase()),
      };
      for (final surface in surfaces) {
        if (surface.isEmpty || !seenSurfaces.add(surface)) continue;
        forms.add(
          VocabularyFormsCompanion.insert(
            surface: surface,
            entryId: entry.id,
          ),
        );
      }
      if (_hasRank(entry)) {
        ranks.add(
          VocabularyEntryRanksCompanion.insert(
            entryId: entry.id,
            frequencyRank: Value(entry.ngslRank),
            generalImportance: Value(entry.priorityScore),
            spokenRelevance: Value(entry.spokenRank),
            newsRelevance: Value(entry.newsRelevance),
            academicRank: Value(entry.academicRank),
          ),
        );
      }
    }

    await _db.transaction(() async {
      await _db.delete(_db.vocabularyForms).go();
      await _db.delete(_db.vocabularyEntryRanks).go();
      await _db.batch((batch) {
        batch.insertAll(
          _db.vocabularyEntries,
          [
            for (final entry in document.entries)
              VocabularyEntriesCompanion.insert(
                id: entry.id,
                lemma: entry.lemma,
                cefrLevel: entry.cefr,
                partOfSpeech: entry.pos,
                definitionEn: entry.definitionEn,
                arabicMeaning: entry.arabicMeaning,
                exampleSentence: entry.example,
                phonetic: Value(entry.phonetic),
                academic: Value(entry.academic),
                ieltsRelevant: Value(entry.ielts),
                toeflRelevant: Value(entry.toefl),
                catalogVersion: Value(document.version),
              ),
          ],
          // INSERT OR REPLACE rewrites the catalog row in one statement.
          // user_vocabulary keeps its foreign key because SQLite checks
          // NO ACTION at the end of that statement, when the same id exists again.
          mode: InsertMode.insertOrReplace,
        );
        batch.insertAll(
          _db.vocabularyForms,
          forms,
          mode: InsertMode.insertOrReplace,
        );
        if (ranks.isNotEmpty) {
          batch.insertAll(
            _db.vocabularyEntryRanks,
            ranks,
            mode: InsertMode.insertOrReplace,
          );
        }
      });
      await _db.into(_db.appStatistics).insertOnConflictUpdate(
            AppStatisticsCompanion.insert(
              key: vocabularyCatalogVersionKey,
              value: document.identity,
              updatedAt: DateTime.now().toUtc(),
            ),
          );

      final incomingIds = document.entries.map((entry) => entry.id).toSet();
      final protected = <String>{
        for (final row in await _db.select(_db.userVocabulary).get())
          row.entryId,
        for (final row in await _db.select(_db.blogVocabulary).get())
          row.entryId,
      };
      final stale = await _db.select(_db.vocabularyEntries).get();
      for (final row in stale) {
        if (incomingIds.contains(row.id) || protected.contains(row.id)) {
          continue;
        }
        await (_db.delete(_db.vocabularyTopics)
              ..where((link) => link.entryId.equals(row.id)))
            .go();
        await (_db.delete(_db.vocabularyEntries)
              ..where((entry) => entry.id.equals(row.id)))
            .go();
      }
    });
  }
}

bool _hasRank(CatalogEntry entry) {
  return entry.ngslRank != null ||
      entry.spokenRank != null ||
      entry.academicRank != null ||
      entry.newsRelevance != null ||
      entry.priorityScore != null;
}
