import 'package:drift/drift.dart';

import '../topics/topic_catalog_importer.dart';
import '../../database/app_database.dart';
import 'lexora_backup.dart';

class BackupException implements Exception {
  BackupException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Exports and restores learning data. Settings stay on the device.
class LexoraBackupStore {
  LexoraBackupStore(this._db);

  final AppDatabase _db;

  Future<LexoraBackup> export() async {
    Future<List<Map<String, dynamic>>> dump<T extends DataClass>(
      Future<List<T>> rows,
    ) async {
      return (await rows).map((row) => row.toJson()).toList();
    }

    return LexoraBackup(
      schemaVersion: LexoraBackup.currentSchemaVersion,
      exportedAt: DateTime.now().toUtc(),
      payload: {
        'categories': await dump(_db.select(_db.categories).get()),
        'words': await dump(_db.select(_db.words).get()),
        'sentences': await dump(_db.select(_db.sentences).get()),
        'sentencePatterns': await dump(_db.select(_db.sentencePatterns).get()),
        'wordCategories': await dump(_db.select(_db.wordCategories).get()),
        'sentenceCategories':
            await dump(_db.select(_db.sentenceCategories).get()),
        'patternCategories':
            await dump(_db.select(_db.patternCategories).get()),
        'sentenceWords': await dump(_db.select(_db.sentenceWords).get()),
        'reviewItems': await dump(_db.select(_db.reviewItems).get()),
        'reviewHistory': await dump(_db.select(_db.reviewHistory).get()),
        'learningSessions': await dump(_db.select(_db.learningSessions).get()),
        'vocabularyEntries': await dump(_db.select(_db.vocabularyEntries).get()),
        'vocabularyForms': await dump(_db.select(_db.vocabularyForms).get()),
        'userVocabulary': await dump(_db.select(_db.userVocabulary).get()),
        'blogEntries': await dump(_db.select(_db.blogEntries).get()),
        'blogVocabulary': await dump(_db.select(_db.blogVocabulary).get()),
      },
    );
  }

  Future<void> importEncoded(String raw) async {
    final backup = LexoraBackup.decode(raw);
    if (backup.schemaVersion > LexoraBackup.currentSchemaVersion) {
      throw BackupException('unsupported_schema');
    }
    await _restore(backup.payload);
  }

  Future<void> _restore(Map<String, dynamic> payload) async {
    await _db.transaction(() async {
      await _db.delete(_db.vocabularyTopics).go();
      await _db.delete(_db.vocabularyEntryRanks).go();
      await _db.delete(_db.blogVocabulary).go();
      await _db.delete(_db.userVocabulary).go();
      await _db.delete(_db.vocabularyForms).go();
      await _db.delete(_db.blogEntries).go();
      await _db.delete(_db.vocabularyEntries).go();
      await _db.delete(_db.reviewHistory).go();
      await _db.delete(_db.reviewItems).go();
      await _db.delete(_db.sentenceWords).go();
      await _db.delete(_db.wordCategories).go();
      await _db.delete(_db.sentenceCategories).go();
      await _db.delete(_db.patternCategories).go();
      await _db.delete(_db.sentences).go();
      await _db.delete(_db.words).go();
      await _db.delete(_db.sentencePatterns).go();
      await _db.delete(_db.categories).go();
      await _db.delete(_db.learningSessions).go();

      await _insert(
        _db.categories,
        payload['categories'],
        CategoryRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.words,
        payload['words'],
        WordRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.sentencePatterns,
        payload['sentencePatterns'],
        SentencePatternRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.sentences,
        payload['sentences'],
        SentenceRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.wordCategories,
        payload['wordCategories'],
        WordCategoryRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.sentenceCategories,
        payload['sentenceCategories'],
        SentenceCategoryRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.patternCategories,
        payload['patternCategories'],
        PatternCategoryRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.sentenceWords,
        payload['sentenceWords'],
        SentenceWordRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.reviewItems,
        payload['reviewItems'],
        ReviewItemRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.reviewHistory,
        payload['reviewHistory'],
        ReviewHistoryRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.learningSessions,
        payload['learningSessions'],
        LearningSessionRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.vocabularyEntries,
        payload['vocabularyEntries'],
        VocabularyEntryRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.vocabularyForms,
        payload['vocabularyForms'],
        VocabularyFormRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.userVocabulary,
        payload['userVocabulary'],
        UserVocabularyRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.blogEntries,
        payload['blogEntries'],
        BlogEntryRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await _insert(
        _db.blogVocabulary,
        payload['blogVocabulary'],
        BlogVocabularyRow.fromJson,
        (row) => row.toCompanion(false),
      );
      await (_db.delete(_db.appStatistics)
            ..where((row) => row.key.equals(topicsCatalogVersionKey)))
          .go();
    });
  }

  Future<void> _insert<T extends DataClass>(
    TableInfo<Table, T> table,
    Object? raw,
    T Function(Map<String, dynamic>) fromJson,
    Insertable<T> Function(T row) toInsertable,
  ) async {
    if (raw is! List) return;
    for (final item in raw) {
      if (item is! Map) continue;
      final row = fromJson(Map<String, dynamic>.from(item));
      await _db.into(table).insert(
            toInsertable(row),
            mode: InsertMode.insertOrReplace,
          );
    }
  }
}
