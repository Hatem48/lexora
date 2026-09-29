import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/services/backup/lexora_backup.dart';

void main() {
  test('backup round-trips with schemaVersion', () {
    final backup = LexoraBackup(
      schemaVersion: LexoraBackup.currentSchemaVersion,
      exportedAt: DateTime.utc(2026, 9, 24),
      payload: {
        'words': [
          {'word': 'opportunity', 'arabicMeaning': 'فرصة'},
        ],
      },
    );

    final restored = LexoraBackup.decode(backup.encode());
    expect(restored.schemaVersion, LexoraBackup.currentSchemaVersion);
    expect(restored.payload['words'], isA<List>());
    expect((restored.payload['words'] as List).first['word'], 'opportunity');
  });
}
