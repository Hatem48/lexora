import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_catalog_importer.dart';

void main() {
  test('catalog import stores ranks and keeps user progress', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    const raw = '''
{
  "version": 2,
  "entries": [
    {
      "id": "develop-verb",
      "lemma": "develop",
      "cefr": "B2",
      "pos": "verb",
      "definitionEn": "",
      "arabicMeaning": "",
      "example": "",
      "academic": true,
      "generalEnglish": true,
      "spokenEnglish": true,
      "ngslRank": 3,
      "spokenRank": 2,
      "academicRank": 8,
      "newsRelevance": null,
      "ielts": false,
      "toefl": false,
      "priorityScore": 640,
      "forms": ["develop", "develops"]
    }
  ]
}
''';
    final now = DateTime.utc(2026, 9, 29);
    await VocabularyCatalogImporter(db).importJson(raw);
    await db.into(db.userVocabulary).insert(
          UserVocabularyCompanion.insert(
            entryId: 'develop-verb',
            firstDiscoveredAt: now,
            discoveredIn: 'blog',
            lastUsedAt: now,
          ),
        );
    await (db.delete(db.appStatistics)
          ..where((row) => row.key.equals(vocabularyCatalogVersionKey)))
        .go();
    await VocabularyCatalogImporter(db).importJson(raw);

    final entry = await db.select(db.vocabularyEntries).getSingle();
    expect(entry.lemma, 'develop');
    expect(entry.academic, isTrue);
    expect(entry.definitionEn, isEmpty);
    final rank = await db.select(db.vocabularyEntryRanks).getSingle();
    expect(rank.frequencyRank, 3);
    expect(rank.spokenRelevance, 2);
    expect(rank.academicRank, 8);
    expect(rank.generalImportance, 640);
    expect(rank.newsRelevance, isNull);
    final progress = await db.select(db.userVocabulary).getSingle();
    expect(progress.usageCount, 1);
    expect(await db.select(db.vocabularyForms).get(), hasLength(2));
  });

  test('replacement drops unused entries and keeps unlocked ones', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final now = DateTime.utc(2026, 9, 29);
    await db.into(db.vocabularyEntries).insert(
          VocabularyEntriesCompanion.insert(
            id: 'ghost',
            lemma: 'ghost',
            cefrLevel: 'A1',
            partOfSpeech: 'noun',
            definitionEn: 'Unused.',
            arabicMeaning: 'غير مستخدم',
            exampleSentence: 'A ghost word.',
          ),
        );
    await db.into(db.vocabularyEntries).insert(
          VocabularyEntriesCompanion.insert(
            id: 'kept',
            lemma: 'kept',
            cefrLevel: 'A1',
            partOfSpeech: 'noun',
            definitionEn: 'Unlocked.',
            arabicMeaning: 'محفوظ',
            exampleSentence: 'A kept word.',
          ),
        );
    await db.into(db.userVocabulary).insert(
          UserVocabularyCompanion.insert(
            entryId: 'kept',
            firstDiscoveredAt: now,
            discoveredIn: 'blog',
            lastUsedAt: now,
          ),
        );

    const raw = '''
{
  "version": 2,
  "datasetType": "development",
  "entries": [
    {
      "id": "school-noun",
      "lemma": "school",
      "cefr": "A1",
      "pos": "noun",
      "definitionEn": "A place where students learn.",
      "arabicMeaning": "مدرسة",
      "example": "She goes to school."
    }
  ]
}
''';
    await VocabularyCatalogImporter(db).importJson(raw);
    final ids = (await db.select(db.vocabularyEntries).get())
        .map((row) => row.id)
        .toSet();
    expect(ids, {'school-noun', 'kept'});
    expect(await db.select(db.userVocabulary).get(), hasLength(1));
  });

  test('a lemma shared by two parts of speech is not assigned to either', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    const raw = '''
{
  "version": 2,
  "datasetType": "production",
  "entries": [
    {
      "id": "record-noun",
      "lemma": "record",
      "cefr": "B1",
      "pos": "noun",
      "definitionEn": "",
      "arabicMeaning": "",
      "example": "",
      "forms": ["records"]
    },
    {
      "id": "record-verb",
      "lemma": "record",
      "cefr": "A2",
      "pos": "verb",
      "definitionEn": "",
      "arabicMeaning": "",
      "example": "",
      "forms": ["recorded"]
    }
  ]
}
''';
    await VocabularyCatalogImporter(db).importJson(raw);
    final forms = await db.select(db.vocabularyForms).get();
    expect(forms.map((row) => row.surface), containsAll(['records', 'recorded']));
    expect(forms.map((row) => row.surface), isNot(contains('record')));
  });
}
