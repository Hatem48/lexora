import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/features/notifications/domain/in_app_notice.dart';
import 'package:lexora/features/words/data/vocabulary_correction_store.dart';
import 'package:lexora/features/words/domain/vocabulary_correction.dart';

void main() {
  const manifest = CorrectionManifest(
    version: 1,
    hints: [
      SpellingHint(written: 'bick', lemmas: ['bike']),
      SpellingHint(written: 'gard', lemmas: ['grade', 'guard']),
    ],
    content: [
      ContentCorrection(
        lemma: 'problem',
        meaningAr: 'مشكلة',
        exampleEn: 'The problem is that the door will not open.',
        exampleAr: 'المشكلة أن الباب لا يفتح.',
      ),
    ],
  );

  final catalog = CatalogLookup(const [
    CatalogLexeme(
      id: 'bike-noun',
      lemma: 'bike',
      pos: 'noun',
      cefr: 'A1',
      arabic: 'دراجة هوائية أو نارية',
      exampleEn: 'He got on his bike and rode home.',
    ),
    CatalogLexeme(
      id: 'back-noun',
      lemma: 'back',
      pos: 'noun',
      cefr: 'A1',
      arabic: 'ظهر',
      exampleEn: 'My back hurts.',
    ),
    CatalogLexeme(
      id: 'grade-noun',
      lemma: 'grade',
      pos: 'noun',
      cefr: 'A1',
      arabic: 'علامة أو تقدير دراسي',
      exampleEn: 'She got a good grade in maths.',
    ),
    CatalogLexeme(
      id: 'grade-verb',
      lemma: 'grade',
      pos: 'verb',
      cefr: 'B2',
      arabic: 'يقيّم عملاً ويعطيه علامة',
      exampleEn: 'The essays will be graded next week.',
    ),
    CatalogLexeme(
      id: 'guard-noun',
      lemma: 'guard',
      pos: 'noun',
      cefr: 'A2',
      arabic: 'حارس مهمته حماية مكان أو أناس',
      exampleEn: 'A guard stood at the door.',
    ),
    CatalogLexeme(
      id: 'problem-noun',
      lemma: 'problem',
      pos: 'noun',
      cefr: 'A1',
      arabic: 'مشكلة؛ مسألة تحتاج إلى حل',
      exampleEn: 'The problem is that the door will not open.',
    ),
    CatalogLexeme(
      id: 'escape-verb',
      lemma: 'escape',
      pos: 'verb',
      cefr: 'B1',
      arabic: 'يهرب',
      exampleEn: 'They managed to escape.',
    ),
  ]);

  StoredUserWord personal(
    String id,
    String word,
    String arabic, {
    String exampleEn = '',
    String exampleAr = '',
  }) {
    return StoredUserWord(
      id: id,
      personal: true,
      word: word,
      arabic: arabic,
      exampleEn: exampleEn,
      exampleAr: exampleAr,
    );
  }

  List<VocabularyReviewIssue> issuesFor(List<StoredUserWord> words) {
    return findVocabularyIssues(
      words: words,
      catalog: catalog,
      manifest: manifest,
    );
  }

  test('an exact catalog word is not flagged and spelling is never rewritten', () {
    final issues = issuesFor([
      personal('1', 'escape', 'يهرب'),
      personal('2', 'bick', 'دراجة هوائية'),
    ]);
    expect(issues.map((issue) => issue.written), isNot(contains('escape')));
    expect(issues.singleWhere((issue) => issue.written == 'bick').written, 'bick');
  });

  test('bick ranks bike first and gard uses the Arabic meaning', () {
    final bick = issuesFor([personal('b', 'bick', 'دراجة هوائية')]).single;
    expect(bick.kind, VocabularyReviewKind.spelling);
    expect(bick.candidates.first.lemma, 'bike');
    expect(bick.candidates.length, lessThanOrEqualTo(2));
    expect(bick.candidates.map((item) => item.lemma), isNot(contains('back')));

    final gard = issuesFor([personal('g', 'gard', 'درجة')]).single;
    expect(gard.candidates.map((item) => item.lemma).take(2), ['grade', 'guard']);
    expect(gard.candidates.first.entryId, 'grade-noun');

    final guardMeaning = findVocabularyIssues(
      words: [personal('g2', 'gard', 'حارس')],
      catalog: catalog,
      manifest: const CorrectionManifest(version: 1, hints: [], content: []),
    ).single;
    expect(guardMeaning.candidates.first.lemma, 'guard');
  });

  test('a correct spelling with a bad translation is a content fix, not a new spelling', () {
    final issue = issuesFor([
      personal(
        'p',
        'problem',
        'ترجمة غريبة',
        exampleEn: 'This example is wrong.',
        exampleAr: 'مثال خاطئ',
      ),
    ]).single;
    expect(issue.kind, VocabularyReviewKind.content);
    expect(issue.candidates.single.lemma, 'problem');
    expect(issue.candidates.single.arabic, 'مشكلة');
    expect(issue.candidates.single.exampleEn, contains('door'));
    expect(issue.candidates.single.exampleAr, contains('الباب'));
  });

  test('an unknown technical term is not queued and a rejected suggestion stays closed', () {
    final issues = issuesFor([
      personal('k', 'Kubernetes', 'منصة'),
      personal('g', 'gard', 'درجة'),
    ]);
    expect(issues.map((issue) => issue.written), isNot(contains('Kubernetes')));
    final gard = issues.single;
    final closed = openVocabularyIssues(
      issues: issues,
      decisions: [
        CorrectionDecision(
          subjectKey: gard.subjectKey,
          action: 'kept',
          signature: gard.signature,
          version: 1,
        ),
      ],
    );
    expect(closed, isEmpty);
  });

  test('notification count matches the open review queue', () {
    final issues = issuesFor([
      personal('b', 'bick', 'دراجة هوائية'),
      personal('g', 'gard', 'درجة'),
      personal('p', 'problem', 'ترجمة غريبة'),
      personal('k', 'Kubernetes', 'منصة'),
    ]);
    expect(issues, hasLength(3));
    final now = DateTime.utc(2026, 10, 6);
    final notices = buildInAppNotices(
      dueWords: 0,
      dueSentences: 0,
      studiedToday: true,
      currentStreak: 0,
      uncelebrated: const [],
      now: now,
      reviewCount: issues.length,
    );
    final notice = notices.single;
    expect(notice.kind, NoticeKind.vocabularyReview);
    expect(notice.count, 3);
    expect(notice.route, '/words/review');
    expect(notificationRoute('/words/review'), '/words/review');
    final quiet = buildInAppNotices(
      dueWords: 0,
      dueSentences: 0,
      studiedToday: true,
      currentStreak: 0,
      uncelebrated: const [],
      now: now,
    );
    expect(quiet.where((item) => item.kind == NoticeKind.vocabularyReview), isEmpty);
  });

  test('applying, keeping, merging, and rolling back preserve user progress', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final now = DateTime.utc(2026, 10, 1);
    Future<void> entry(String id, String lemma, String arabic, String example) {
      return db.into(db.vocabularyEntries).insert(
            VocabularyEntriesCompanion.insert(
              id: id,
              lemma: lemma,
              cefrLevel: 'A1',
              partOfSpeech: 'noun',
              definitionEn: 'A catalog word.',
              arabicMeaning: arabic,
              exampleSentence: example,
            ),
          );
    }

    await entry('bike-noun', 'bike', 'دراجة هوائية أو نارية', 'He got on his bike and rode home.');
    await entry('grade-noun', 'grade', 'علامة أو تقدير دراسي', 'She got a good grade in maths.');
    await entry('guard-noun', 'guard', 'حارس', 'A guard stood at the door.');
    await entry('problem-noun', 'problem', 'مشكلة؛ مسألة تحتاج إلى حل', 'The problem is that the door will not open.');
    await db.into(db.userVocabulary).insert(
          UserVocabularyCompanion.insert(
            entryId: 'grade-noun',
            status: const Value('mastered'),
            firstDiscoveredAt: now,
            discoveredIn: 'test',
            usageCount: const Value(3),
            lastUsedAt: now,
          ),
        );
    Future<void> word({
      required String id,
      required String text,
      required String arabic,
      String mastery = 'learning',
      int reviews = 4,
      bool favorite = true,
      String example = 'Old example.',
    }) {
      return db.into(db.words).insert(
            WordsCompanion.insert(
              id: id,
              word: text,
              arabicMeaning: arabic,
              cefrLevel: 'B2',
              partOfSpeech: 'verb',
              exampleSentence: Value(example),
              isFavorite: Value(favorite),
              masteryStatus: Value(mastery),
              reviewCount: Value(reviews),
              createdAt: now,
              updatedAt: now,
            ),
          );
    }

    await word(id: 'bick', text: 'bick', arabic: 'دراجة هوائية', reviews: 4);
    await word(
      id: 'gard',
      text: 'gard',
      arabic: 'درجة',
      mastery: 'learning',
      reviews: 5,
    );
    await word(id: 'problem', text: 'problem', arabic: 'ترجمة غريبة', reviews: 2);
    await word(id: 'k8s', text: 'Kubernetes', arabic: 'منصة', reviews: 1, favorite: false);

    final store = VocabularyCorrectionStore(db);
    expect(await store.ensureScanned(manifest: manifest), isTrue);
    expect(await store.ensureScanned(manifest: manifest), isFalse);
    final queued = await store.currentQueue();
    expect(queued.map((issue) => issue.written), containsAll(['bick', 'gard', 'problem']));
    expect(queued.map((issue) => issue.written), isNot(contains('Kubernetes')));
    expect(
      (await (db.select(db.words)..where((row) => row.id.equals('bick'))).getSingle()).word,
      'bick',
    );

    final bick = queued.singleWhere((issue) => issue.written == 'bick');
    await store.applyCandidate(
      issue: bick,
      candidate: bick.candidates.first,
      version: 1,
    );
    await store.applyCandidate(
      issue: bick,
      candidate: bick.candidates.first,
      version: 1,
    );
    final bikeProgress = await (db.select(db.userVocabulary)
          ..where((row) => row.entryId.equals('bike-noun')))
        .getSingle();
    expect(bikeProgress.status, 'learning');
    expect(bikeProgress.usageCount, 4);
    expect(bikeProgress.firstDiscoveredAt.isAtSameMomentAs(now), isTrue);
    final bikeWord = await (db.select(db.words)..where((row) => row.id.equals('bick'))).getSingle();
    expect(bikeWord.word, 'bike');
    expect(bikeWord.isFavorite, isTrue);
    expect(bikeWord.reviewCount, 4);
    expect(bikeWord.arabicMeaning, 'دراجة هوائية أو نارية');
    expect(bikeWord.exampleSentence, contains('rode home'));

    final gard = queued.singleWhere((issue) => issue.written == 'gard');
    final failed = gard;
    await expectLater(
      store.applyCandidate(
        issue: failed,
        candidate: failed.candidates.first,
        version: 1,
        abortBeforeCommit: () => throw StateError('stop'),
      ),
      throwsA(isA<StateError>()),
    );
    expect(
      (await (db.select(db.words)..where((row) => row.id.equals('gard'))).getSingle()).word,
      'gard',
    );

    await store.applyCandidate(
      issue: gard,
      candidate: gard.candidates.firstWhere((item) => item.lemma == 'grade'),
      version: 1,
    );
    final mastered = await db.customSelect(
      "SELECT entry_id AS id FROM user_vocabulary WHERE status = 'mastered'",
    ).get();
    expect(mastered.map((row) => row.read<String>('id')), ['grade-noun']);
    final grade = await (db.select(db.userVocabulary)
          ..where((row) => row.entryId.equals('grade-noun')))
        .getSingle();
    expect(grade.usageCount, 5);
    expect(grade.status, 'mastered');
    final gardRows = await (db.select(db.words)..where((row) => row.word.equals('gard'))).get();
    expect(gardRows, isEmpty);
    final gradeWord = await (db.select(db.words)..where((row) => row.id.equals('gard'))).getSingle();
    expect(gradeWord.word, 'grade');
    expect(gradeWord.isFavorite, isTrue);
    expect(gradeWord.reviewCount, 5);

    final problem = queued.singleWhere((issue) => issue.written == 'problem');
    await store.keepOriginal(issue: problem, version: 1);
    final kept = await (db.select(db.words)..where((row) => row.id.equals('problem'))).getSingle();
    expect(kept.word, 'problem');
    expect(kept.arabicMeaning, 'ترجمة غريبة');
    final reopened = openVocabularyIssues(
      issues: issuesFor([
        personal('problem', 'problem', 'ترجمة غريبة'),
      ]),
      decisions: decodeDecisions(
        (await (db.select(db.userPreferences)
                  ..where((row) => row.key.equals(vocabularyCorrectionDecisionsKey)))
                .getSingle())
            .value,
      ),
    );
    expect(reopened, isEmpty);

    final again = await store.currentQueue();
    expect(again.map((issue) => issue.written), isNot(contains('problem')));
    expect(again.map((issue) => issue.written), isNot(contains('bick')));
    final kubernetes = await (db.select(db.words)..where((row) => row.id.equals('k8s'))).getSingle();
    expect(kubernetes.word, 'Kubernetes');
  });
}
