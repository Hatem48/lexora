import 'app_database.dart';

/// Removes the one-time preview words, sentences, and categories.
class DemoDataCleanup {
  DemoDataCleanup(this._db);

  final AppDatabase _db;

  static const versionKey = 'demo_seed_version';

  Future<void> clearIfPresent() async {
    final existing = await (_db.select(_db.appStatistics)
          ..where((t) => t.key.equals(versionKey)))
        .getSingleOrNull();
    if (existing == null) return;

    await _db.transaction(() async {
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
      await (_db.delete(_db.appStatistics)
            ..where((t) => t.key.equals(versionKey)))
          .go();
    });
  }
}
