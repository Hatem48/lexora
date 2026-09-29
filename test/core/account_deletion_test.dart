import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/services/account/account_deletion.dart';

void main() {
  test('delete account clears personal rows and keeps the catalog', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final now = DateTime.utc(2026, 9, 29);
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
    await db.into(db.userVocabulary).insert(
          UserVocabularyCompanion.insert(
            entryId: 'school-noun',
            firstDiscoveredAt: now,
            discoveredIn: 'blog',
            lastUsedAt: now,
          ),
        );
    await db.into(db.words).insert(
          WordsCompanion.insert(
            id: 'word-1',
            word: 'school',
            arabicMeaning: 'مدرسة',
            cefrLevel: 'A1',
            partOfSpeech: 'noun',
            createdAt: now,
            updatedAt: now,
          ),
        );

    await AccountDeletion(db).deletePersonalData();

    expect(await db.select(db.userVocabulary).get(), isEmpty);
    expect(await db.select(db.words).get(), isEmpty);
    expect((await db.select(db.vocabularyEntries).getSingle()).lemma, 'school');
  });
}
