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
}
