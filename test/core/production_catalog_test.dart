import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_catalog.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_catalog_importer.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_discovery_repository.dart';

void main() {
  final productionRaw = File('assets/vocabulary/catalog.json').readAsStringSync();
  final developmentRaw =
      File('data/vocabulary/catalog.development.json').readAsStringSync();

  test('production catalog is a licensed A1-C2 list with empty glosses', () {
    final document = VocabularyCatalogDocument.parse(productionRaw);
    expect(document.datasetType, 'production');
    expect(document.identity, '2:production');
    expect(document.entries.length, greaterThan(5000));
    const levels = {'A1', 'A2', 'B1', 'B2', 'C1', 'C2'};
    final ids = <String>{};
    for (final entry in document.entries) {
      expect(levels, contains(entry.cefr));
      expect(entry.lemma.trim(), isNotEmpty);
      expect(entry.pos.trim(), isNotEmpty);
      expect(entry.definitionEn, isEmpty);
      expect(entry.arabicMeaning, isEmpty);
      expect(entry.example, isEmpty);
      expect(entry.ielts, isFalse);
      expect(entry.toefl, isFalse);
      expect(ids.add(entry.id), isTrue);
      for (final rank in [entry.ngslRank, entry.spokenRank, entry.academicRank]) {
        if (rank != null) expect(rank, greaterThan(0));
      }
    }
    expect(document.entries.map((entry) => entry.cefr).toSet(), levels);
  });

  test(
    'fresh import, catalog update, and an older install keep user progress',
    () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final importer = VocabularyCatalogImporter(db);

      await importer.importJson(developmentRaw);
      final development = VocabularyCatalogDocument.parse(developmentRaw);
      final kept = development.entries.first;
      final now = DateTime.utc(2026, 9, 29);
      await db.into(db.userVocabulary).insert(
            UserVocabularyCompanion.insert(
              entryId: kept.id,
              status: const Value('mastered'),
              firstDiscoveredAt: now,
              discoveredIn: 'blog',
              sourceId: const Value('blog-kept'),
              usageCount: const Value(7),
              lastUsedAt: now,
            ),
          );
      await db.into(db.vocabularyEntries).insert(
            VocabularyEntriesCompanion.insert(
              id: 'demo-only-noun',
              lemma: 'demo-only',
              cefrLevel: 'A1',
              partOfSpeech: 'noun',
              definitionEn: '',
              arabicMeaning: '',
              exampleSentence: '',
            ),
          );
      await db.into(db.userVocabulary).insert(
            UserVocabularyCompanion.insert(
              entryId: 'demo-only-noun',
              status: const Value('learning'),
              firstDiscoveredAt: now,
              discoveredIn: 'sentence',
              sourceId: const Value('sentence-kept'),
              usageCount: const Value(3),
              lastUsedAt: now,
            ),
          );

      final started = DateTime.now();
      await importer.importJson(productionRaw);
      final elapsed = DateTime.now().difference(started);
      expect(elapsed.inSeconds, lessThan(20));

      final progress = await (db.select(db.userVocabulary)
            ..where((row) => row.entryId.equals(kept.id)))
          .getSingle();
      expect(progress.status, 'mastered');
      expect(progress.usageCount, 7);
      expect(progress.discoveredIn, 'blog');
      expect(progress.sourceId, 'blog-kept');

      final preserved = await (db.select(db.userVocabulary)
            ..where((row) => row.entryId.equals('demo-only-noun')))
          .getSingle();
      expect(preserved.status, 'learning');
      expect(preserved.usageCount, 3);
      expect(preserved.discoveredIn, 'sentence');

      final stored = await (db.select(db.appStatistics)
            ..where((row) => row.key.equals(vocabularyCatalogVersionKey)))
          .getSingle();
      expect(stored.value, '2:production');
      final production = VocabularyCatalogDocument.parse(productionRaw);
      final keptInProduction =
          production.entries.any((entry) => entry.id == kept.id);
      final count = await db.select(db.vocabularyEntries).get();
      expect(
        count.length,
        production.entries.length + (keptInProduction ? 1 : 2),
      );

      await importer.importJson(productionRaw);
      final afterUpdate = await (db.select(db.userVocabulary)
            ..where((row) => row.entryId.equals(kept.id)))
          .getSingle();
      expect(afterUpdate.usageCount, 7);
      expect((await db.select(db.vocabularyEntries).get()).length, count.length);

      final a1 = await (db.select(db.vocabularyEntries)
            ..where((row) => row.cefrLevel.equals('A1'))
            ..limit(1))
          .getSingle();
      final found = await (db.select(db.vocabularyEntries)
            ..where((row) => row.lemma.equals(a1.lemma)))
          .get();
      expect(found.map((row) => row.id), contains(a1.id));
      final outside = await (db.select(db.vocabularyEntries)
            ..where((row) => row.cefrLevel.isNotIn(const [
                  'A1',
                  'A2',
                  'B1',
                  'B2',
                  'C1',
                  'C2',
                ])))
          .get();
      expect(outside, isEmpty);

      final surface = await (db.select(db.vocabularyForms)
            ..where((row) => row.entryId.equals(kept.id).not())
            ..limit(1))
          .getSingle();
      await db.into(db.blogEntries).insert(
            BlogEntriesCompanion.insert(
              id: 'blog-prod',
              title: 'Lookup',
              content: surface.surface,
              createdAt: now,
              updatedAt: now,
            ),
          );
      final summary = await VocabularyDiscoveryRepository(db).analyzeAndRecord(
        text: surface.surface,
        discoveredIn: 'blog',
        sourceId: 'blog-prod',
        trackBlogLinks: true,
      );
      expect(summary.newlyDiscovered.single.entryId, surface.entryId);
      expect(summary.cefrDistribution.values.single, 1);
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
