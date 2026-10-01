import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/services/backup/lexora_backup_store.dart';

void main() {
  test('export and import round-trip a word', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final now = DateTime.utc(2026, 9, 29);

    await db.into(db.words).insert(
          WordsCompanion.insert(
            id: 'w1',
            word: 'opportunity',
            arabicMeaning: 'فرصة',
            cefrLevel: 'B1',
            partOfSpeech: 'noun',
            createdAt: now,
            updatedAt: now,
          ),
        );

    final encoded = (await LexoraBackupStore(db).export()).encode();
    await db.delete(db.words).go();
    expect(await db.select(db.words).get(), isEmpty);

    await LexoraBackupStore(db).importEncoded(encoded);
    final words = await db.select(db.words).get();
    expect(words, hasLength(1));
    expect(words.single.word, 'opportunity');
    expect(words.single.arabicMeaning, 'فرصة');
  });

  test('new backups omit the production catalog and still restore user progress',
      () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final now = DateTime.utc(2026, 10, 1);
    await db.into(db.vocabularyEntries).insert(
          VocabularyEntriesCompanion.insert(
            id: 'keep-verb',
            lemma: 'keep',
            cefrLevel: 'A2',
            partOfSpeech: 'verb',
            definitionEn: 'To continue to have.',
            arabicMeaning: 'يبقي',
            exampleSentence: 'Keep the receipt.',
          ),
        );
    await db.into(db.userVocabulary).insert(
          UserVocabularyCompanion.insert(
            entryId: 'keep-verb',
            status: const Value('mastered'),
            firstDiscoveredAt: now,
            discoveredIn: 'blog',
            usageCount: const Value(6),
            lastUsedAt: now,
          ),
        );

    final backup = await LexoraBackupStore(db).export();
    expect(backup.payload.containsKey('vocabularyEntries'), isFalse);
    expect(backup.payload.containsKey('vocabularyForms'), isFalse);

    await db.delete(db.userVocabulary).go();
    expect(await db.select(db.userVocabulary).get(), isEmpty);
    expect(await db.select(db.vocabularyEntries).get(), hasLength(1));

    await LexoraBackupStore(db).importEncoded(backup.encode());
    final progress = await db.select(db.userVocabulary).getSingle();
    expect(progress.status, 'mastered');
    expect(progress.usageCount, 6);
    final catalog = await db.select(db.vocabularyEntries).getSingle();
    expect(catalog.definitionEn, 'To continue to have.');
  });
}
