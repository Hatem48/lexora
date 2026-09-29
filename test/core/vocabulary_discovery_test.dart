import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_catalog_importer.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_discovery_repository.dart';

const _catalog = '''
{
  "version": 1,
  "entries": [
    {
      "id": "develop",
      "lemma": "develop",
      "cefr": "B2",
      "pos": "verb",
      "definitionEn": "To grow.",
      "arabicMeaning": "يطوّر",
      "example": "Students develop skills.",
      "forms": ["develop", "develops", "developed", "developing"]
    },
    {
      "id": "development",
      "lemma": "development",
      "cefr": "B2",
      "pos": "noun",
      "definitionEn": "The process of growing.",
      "arabicMeaning": "تطوّر",
      "example": "Skill development takes time.",
      "forms": ["development"]
    }
  ]
}
''';

void main() {
  test('inflections unlock once and usage increments only for a new source', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await VocabularyCatalogImporter(db).importJson(_catalog);
    final now = DateTime.utc(2026, 9, 29);
    await db.into(db.blogEntries).insert(
          BlogEntriesCompanion.insert(
            id: 'blog-1',
            title: 'Skills',
            content: 'Develop developed DEVELOPING develop.',
            createdAt: now,
            updatedAt: now,
          ),
        );
    final discovery = VocabularyDiscoveryRepository(db);

    final first = await discovery.analyzeAndRecord(
      text: 'Develop developed DEVELOPING develop.',
      discoveredIn: 'blog',
      sourceId: 'blog-1',
      trackBlogLinks: true,
    );
    expect(first.newlyDiscovered.map((word) => word.entryId), ['develop']);
    expect(first.uniqueClassified, 1);

    var progress = await db.select(db.userVocabulary).getSingle();
    expect(progress.entryId, 'develop');
    expect(progress.usageCount, 1);
    expect(progress.status, 'discovered');

    final again = await discovery.analyzeAndRecord(
      text: 'develops developing',
      discoveredIn: 'blog',
      sourceId: 'blog-1',
      trackBlogLinks: true,
    );
    expect(again.newlyDiscovered, isEmpty);
    progress = await db.select(db.userVocabulary).getSingle();
    expect(progress.usageCount, 1);

    await discovery.analyzeAndRecord(
      text: 'development',
      discoveredIn: 'sentence',
      sourceId: 'sentence-1',
    );
    final rows = await db.select(db.userVocabulary).get();
    expect(rows.map((row) => row.entryId).toSet(), {'develop', 'development'});
    final develop = rows.firstWhere((row) => row.entryId == 'develop');
    expect(develop.usageCount, 1);

    await discovery.analyzeAndRecord(
      text: '(develop)!',
      discoveredIn: 'sentence',
      sourceId: 'sentence-2',
    );
    final updated = await (db.select(db.userVocabulary)
          ..where((row) => row.entryId.equals('develop')))
        .getSingle();
    expect(updated.usageCount, 2);
  });
}
