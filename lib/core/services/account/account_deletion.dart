import '../../database/app_database.dart';

/// Removes personal learning data. The shared vocabulary catalog stays installed.
class AccountDeletion {
  AccountDeletion(this._db);

  final AppDatabase _db;

  Future<void> deletePersonalData() async {
    await _db.transaction(() async {
      await _db.delete(_db.blogVocabulary).go();
      await _db.delete(_db.userVocabulary).go();
      await _db.delete(_db.blogEntries).go();
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
      await _db.delete(_db.userPreferences).go();
    });
  }
}
