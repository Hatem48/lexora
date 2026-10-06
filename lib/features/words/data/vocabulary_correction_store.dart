import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../../core/database/app_database.dart';
import '../domain/vocabulary_correction.dart';

class VocabularyCorrectionStore {
  VocabularyCorrectionStore(this._db);

  final AppDatabase _db;

  Future<bool> ensureScanned({CorrectionManifest? manifest}) async {
    final document = manifest ?? await _loadAsset();
    final stored = int.tryParse(await _pref(vocabularyCorrectionVersionKey) ?? '') ?? 0;
    if (stored >= document.version) return false;
    final issues = findVocabularyIssues(
      words: await _userWords(),
      catalog: await _catalog(),
      manifest: document,
    );
    final open = openVocabularyIssues(
      issues: issues,
      decisions: decodeDecisions(await _pref(vocabularyCorrectionDecisionsKey)),
    );
    await _put(vocabularyCorrectionQueueKey, encodeIssues(open));
    await _put(vocabularyCorrectionVersionKey, '${document.version}');
    return true;
  }

  Future<List<VocabularyReviewIssue>> currentQueue() async {
    return decodeIssues(await _pref(vocabularyCorrectionQueueKey));
  }

  Future<int> pendingCount() async => (await currentQueue()).length;

  Future<int> storedVersion() async {
    return int.tryParse(await _pref(vocabularyCorrectionVersionKey) ?? '') ?? 1;
  }

  Future<List<VocabularyReviewIssue>> keepOriginal({
    required VocabularyReviewIssue issue,
    required int version,
  }) async {
    await _remember(issue, 'kept', version);
    return _drop(issue.subjectKey);
  }

  Future<List<VocabularyReviewIssue>> applyCandidate({
    required VocabularyReviewIssue issue,
    required ReviewCandidate candidate,
    required int version,
    void Function()? abortBeforeCommit,
  }) async {
    await _db.transaction(() async {
      if (issue.kind == VocabularyReviewKind.spelling) {
        await _applySpelling(issue, candidate);
      } else {
        await _applyContent(issue, candidate);
      }
      if (abortBeforeCommit != null) abortBeforeCommit();
    });
    await _remember(issue, 'applied', version);
    return _drop(issue.subjectKey);
  }

  Future<void> _applySpelling(
    VocabularyReviewIssue issue,
    ReviewCandidate candidate,
  ) async {
    final source = await (_db.select(_db.words)
          ..where((row) => row.id.equals(issue.wordId)))
        .getSingleOrNull();
    if (source == null) return;
    final entry = await (_db.select(_db.vocabularyEntries)
          ..where((row) => row.id.equals(candidate.entryId)))
        .getSingleOrNull();
    if (entry == null) return;
    final sibling = await (_db.select(_db.words)
          ..where(
            (row) =>
                row.word.equals(entry.lemma) & row.id.equals(source.id).not(),
          ))
        .getSingleOrNull();
    if (sibling == null) {
      await (_db.update(_db.words)..where((row) => row.id.equals(source.id))).write(
        WordsCompanion(
          word: Value(entry.lemma),
          arabicMeaning: Value(candidate.arabic),
          exampleSentence: Value(
            candidate.exampleEn.isEmpty ? null : candidate.exampleEn,
          ),
          exampleTranslation: Value(
            candidate.exampleAr.isEmpty ? null : candidate.exampleAr,
          ),
          cefrLevel: Value(entry.cefrLevel),
          partOfSpeech: Value(entry.partOfSpeech),
          updatedAt: Value(DateTime.now()),
        ),
      );
    } else {
      await (_db.update(_db.words)..where((row) => row.id.equals(sibling.id))).write(
        WordsCompanion(
          arabicMeaning: Value(candidate.arabic),
          exampleSentence: Value(
            candidate.exampleEn.isEmpty ? null : candidate.exampleEn,
          ),
          exampleTranslation: Value(
            candidate.exampleAr.isEmpty ? null : candidate.exampleAr,
          ),
          cefrLevel: Value(entry.cefrLevel),
          partOfSpeech: Value(entry.partOfSpeech),
          isFavorite: Value(sibling.isFavorite || source.isFavorite),
          reviewCount: Value(
            sibling.reviewCount > source.reviewCount
                ? sibling.reviewCount
                : source.reviewCount,
          ),
          masteryStatus: Value(
            higherMastery(sibling.masteryStatus, source.masteryStatus),
          ),
          updatedAt: Value(DateTime.now()),
        ),
      );
      await _moveLinks(fromId: source.id, toId: sibling.id);
      await (_db.delete(_db.words)..where((row) => row.id.equals(source.id))).go();
    }
    final usage = sibling == null
        ? source.reviewCount
        : (sibling.reviewCount > source.reviewCount
            ? sibling.reviewCount
            : source.reviewCount);
    final status = vocabularyStatusForPersonal(
      sibling == null
          ? source.masteryStatus
          : higherMastery(sibling.masteryStatus, source.masteryStatus),
    );
    await _mergeCatalogProgress(
      entryId: entry.id,
      status: status,
      usageCount: usage,
      discoveredAt: source.createdAt,
      usedAt: source.updatedAt,
    );
  }

  Future<void> _applyContent(
    VocabularyReviewIssue issue,
    ReviewCandidate candidate,
  ) async {
    if (issue.personal) {
      await (_db.update(_db.words)..where((row) => row.id.equals(issue.wordId))).write(
        WordsCompanion(
          arabicMeaning: Value(candidate.arabic),
          exampleSentence: Value(
            candidate.exampleEn.isEmpty ? null : candidate.exampleEn,
          ),
          exampleTranslation: Value(
            candidate.exampleAr.isEmpty ? null : candidate.exampleAr,
          ),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return;
    }
    await (_db.update(_db.userVocabulary)
          ..where((row) => row.entryId.equals(issue.wordId)))
        .write(
      UserVocabularyCompanion(
        userArabicMeaning: Value(candidate.arabic),
        userExample: Value(
          candidate.exampleEn.isEmpty ? null : candidate.exampleEn,
        ),
        userExampleTranslation: Value(
          candidate.exampleAr.isEmpty ? null : candidate.exampleAr,
        ),
      ),
    );
  }

  Future<void> _mergeCatalogProgress({
    required String entryId,
    required String status,
    required int usageCount,
    required DateTime discoveredAt,
    required DateTime usedAt,
  }) async {
    final current = await (_db.select(_db.userVocabulary)
          ..where((row) => row.entryId.equals(entryId)))
        .getSingleOrNull();
    if (current == null) {
      await _db.into(_db.userVocabulary).insert(
            UserVocabularyCompanion.insert(
              entryId: entryId,
              status: Value(status),
              firstDiscoveredAt: discoveredAt,
              discoveredIn: 'correction',
              usageCount: Value(usageCount),
              lastUsedAt: usedAt,
            ),
          );
      return;
    }
    final earlier = current.firstDiscoveredAt.isBefore(discoveredAt)
        ? current.firstDiscoveredAt
        : discoveredAt;
    final later = current.lastUsedAt.isAfter(usedAt) ? current.lastUsedAt : usedAt;
    await (_db.update(_db.userVocabulary)
          ..where((row) => row.entryId.equals(entryId)))
        .write(
      UserVocabularyCompanion(
        status: Value(higherMastery(current.status, status)),
        usageCount: Value(
          current.usageCount > usageCount ? current.usageCount : usageCount,
        ),
        firstDiscoveredAt: Value(earlier),
        lastUsedAt: Value(later),
      ),
    );
  }

  Future<void> _moveLinks({required String fromId, required String toId}) async {
    final categories = await (_db.select(_db.wordCategories)
          ..where((row) => row.wordId.equals(fromId)))
        .get();
    for (final row in categories) {
      await _db.into(_db.wordCategories).insert(
            WordCategoriesCompanion.insert(
              wordId: toId,
              categoryId: row.categoryId,
            ),
            mode: InsertMode.insertOrIgnore,
          );
    }
    await (_db.delete(_db.wordCategories)..where((row) => row.wordId.equals(fromId))).go();
    final sentences = await (_db.select(_db.sentenceWords)
          ..where((row) => row.wordId.equals(fromId)))
        .get();
    for (final row in sentences) {
      await _db.into(_db.sentenceWords).insert(
            SentenceWordsCompanion.insert(
              sentenceId: row.sentenceId,
              wordId: toId,
            ),
            mode: InsertMode.insertOrIgnore,
          );
    }
    await (_db.delete(_db.sentenceWords)..where((row) => row.wordId.equals(fromId))).go();
  }

  Future<void> _remember(
    VocabularyReviewIssue issue,
    String action,
    int version,
  ) async {
    final decisions = decodeDecisions(await _pref(vocabularyCorrectionDecisionsKey));
    final next = [
      for (final item in decisions)
        if (item.subjectKey != issue.subjectKey) item,
      CorrectionDecision(
        subjectKey: issue.subjectKey,
        action: action,
        signature: issue.signature,
        version: version,
      ),
    ];
    await _put(vocabularyCorrectionDecisionsKey, encodeDecisions(next));
  }

  Future<List<VocabularyReviewIssue>> _drop(String subjectKey) async {
    final next = [
      for (final issue in await currentQueue())
        if (issue.subjectKey != subjectKey) issue,
    ];
    await _put(vocabularyCorrectionQueueKey, encodeIssues(next));
    return next;
  }

  Future<List<StoredUserWord>> _userWords() async {
    final personal = await _db.select(_db.words).get();
    final overrides = await _db.customSelect(
      '''
      SELECT u.entry_id AS id, e.lemma AS word,
             COALESCE(u.user_arabic_meaning, '') AS arabic,
             COALESCE(u.user_example, '') AS example_en,
             COALESCE(u.user_example_translation, '') AS example_ar
      FROM user_vocabulary u
      JOIN vocabulary_entries e ON e.id = u.entry_id
      WHERE COALESCE(u.user_arabic_meaning, '') != ''
         OR COALESCE(u.user_example, '') != ''
      ''',
      readsFrom: {_db.userVocabulary, _db.vocabularyEntries},
    ).get();
    return [
      for (final row in personal)
        StoredUserWord(
          id: row.id,
          personal: true,
          word: row.word,
          arabic: row.arabicMeaning,
          exampleEn: row.exampleSentence ?? '',
          exampleAr: row.exampleTranslation ?? '',
        ),
      for (final row in overrides)
        StoredUserWord(
          id: row.read<String>('id'),
          personal: false,
          word: row.read<String>('word'),
          arabic: row.read<String>('arabic'),
          exampleEn: row.read<String>('example_en'),
          exampleAr: row.read<String>('example_ar'),
        ),
    ];
  }

  Future<CatalogLookup> _catalog() async {
    final entries = await _db.select(_db.vocabularyEntries).get();
    final forms = await _db.select(_db.vocabularyForms).get();
    return CatalogLookup(
      [
        for (final row in entries)
          CatalogLexeme(
            id: row.id,
            lemma: row.lemma,
            pos: row.partOfSpeech,
            cefr: row.cefrLevel,
            arabic: row.arabicMeaning,
            exampleEn: row.exampleSentence,
          ),
      ],
      forms: {for (final row in forms) row.surface: row.entryId},
    );
  }

  Future<CorrectionManifest> _loadAsset() async {
    final raw = await rootBundle.loadString('assets/vocabulary/corrections.json');
    return CorrectionManifest.parse(raw);
  }

  Future<String?> _pref(String key) async {
    final row = await (_db.select(_db.userPreferences)
          ..where((item) => item.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> _put(String key, String value) {
    return _db.into(_db.userPreferences).insertOnConflictUpdate(
          UserPreferencesCompanion.insert(
            key: key,
            value: value,
            updatedAt: DateTime.now(),
          ),
        );
  }
}
