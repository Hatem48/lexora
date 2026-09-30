import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/database/demo_data_cleanup.dart';

void main() {
  test('demo cleanup removes seeded learning rows and keeps the catalog', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final now = DateTime.utc(2026, 9, 30);

    await db.into(db.vocabularyEntries).insert(
          VocabularyEntriesCompanion.insert(
            id: 'school-noun',
            lemma: 'school',
            cefrLevel: 'A1',
            partOfSpeech: 'noun',
            definitionEn: 'A place to learn.',
            arabicMeaning: 'مدرسة',
            exampleSentence: 'She goes to school.',
          ),
        );
    await db.into(db.words).insert(
          WordsCompanion.insert(
            id: 'word-1',
            word: 'hello',
            arabicMeaning: 'مرحبا',
            cefrLevel: 'A1',
            partOfSpeech: 'interjection',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.appStatistics).insert(
          AppStatisticsCompanion.insert(
            key: DemoDataCleanup.versionKey,
            value: '3',
            updatedAt: now,
          ),
        );

    await DemoDataCleanup(db).clearIfPresent();

    expect(await db.select(db.words).get(), isEmpty);
    expect(
      await (db.select(db.appStatistics)
            ..where((t) => t.key.equals(DemoDataCleanup.versionKey)))
          .getSingleOrNull(),
      isNull,
    );
    expect((await db.select(db.vocabularyEntries).getSingle()).lemma, 'school');

    await db.into(db.words).insert(
          WordsCompanion.insert(
            id: 'word-2',
            word: 'kept',
            arabicMeaning: 'محفوظ',
            cefrLevel: 'A1',
            partOfSpeech: 'adjective',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await DemoDataCleanup(db).clearIfPresent();
    expect((await db.select(db.words).getSingle()).word, 'kept');
  });
}
