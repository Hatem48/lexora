import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/services/backup/lexora_backup.dart';
import 'package:lexora/core/services/backup/lexora_backup_store.dart';
import 'package:lexora/core/services/grammar/grammar_scoring.dart';
import 'package:lexora/core/services/progress/achievement_catalog.dart';
import 'package:lexora/core/services/progress/activity_policy.dart';
import 'package:lexora/core/services/progress/learning_activity_store.dart';
import 'package:lexora/core/services/review/review_engine.dart';
import 'package:lexora/core/constants/enums.dart';
import 'package:lexora/core/services/account/profile_image_store.dart';
import 'package:lexora/core/services/vocabulary/mastery_policy.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_discovery_repository.dart';
import 'package:lexora/features/words/data/learning_words.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('discovery puts a catalog word on the Words list as needs completion', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await db.into(db.vocabularyEntries).insert(
          VocabularyEntriesCompanion.insert(
            id: 'scholarship-noun',
            lemma: 'scholarship',
            cefrLevel: 'B2',
            partOfSpeech: 'noun',
            definitionEn: '',
            arabicMeaning: '',
            exampleSentence: '',
          ),
        );
    await db.into(db.vocabularyForms).insert(
          VocabularyFormsCompanion.insert(
            surface: 'scholarship',
            entryId: 'scholarship-noun',
          ),
        );
    final summary = await VocabularyDiscoveryRepository(db).analyzeAndRecord(
      text: 'I received a scholarship.',
      discoveredIn: 'blog',
      sourceId: 'blog-1',
    );
    expect(summary.newlyDiscovered.single.lemma, 'scholarship');
    final words = await watchLearningWords(
      db,
      const LearningWordQuery(),
    ).first;
    expect(words.single.word, 'scholarship');
    expect(words.single.status, 'discovered');
    expect(words.single.needsCompletion, isTrue);
    expect(words.single.fromCatalog, isTrue);
  });

  test('mastery follows reviews and is not granted on discovery', () {
    const policy = MasteryPolicy();
    expect(
      policy.statusAfterCompletion(hasMeaning: false),
      VocabularyStatus.discovered.storageValue,
    );
    final engine = const ReviewEngine();
    var ease = 2.5;
    var interval = 0;
    var reps = 0;
    MasteryStatus mastery = MasteryStatus.newItem;
    final start = DateTime.utc(2026, 1, 1);
    for (var i = 0; i < 6; i++) {
      final result = engine.schedule(
        rating: ReviewRating.good,
        easeFactor: ease,
        intervalDays: interval,
        repetitions: reps,
        now: start.add(Duration(days: i * 10)),
      );
      ease = result.easeFactor;
      interval = result.intervalDays;
      reps = result.repetitions;
      mastery = result.masteryStatus;
    }
    expect(mastery, MasteryStatus.mastered);
    expect(reps, greaterThanOrEqualTo(MasteryPolicy.successfulReviewsForMastery));
    expect(interval, greaterThanOrEqualTo(MasteryPolicy.minimumMasteryIntervalDays));
    expect(
      policy.statusAfterReview(mastery),
      VocabularyStatus.mastered.storageValue,
    );
  });

  test('opening the app does not continue a streak or count idle time', () {
    const streak = ActivityStreakPolicy();
    expect(
      streak.dayCounts(reviews: 0, exercises: 0, activeSeconds: 10),
      isFalse,
    );
    expect(
      streak.dayCounts(reviews: 1, exercises: 0, activeSeconds: 0),
      isTrue,
    );
    final stats = streak.fromDays(
      [
        (
          day: DateTime(2026, 10, 1),
          reviews: 0,
          exercises: 0,
          activeSeconds: 5,
        ),
      ],
      today: DateTime(2026, 10, 1),
    );
    expect(stats.current, 0);

    const time = LearningTimePolicy();
    final start = DateTime(2026, 10, 1, 10);
    final elapsed = time.elapsed(
      foreground: false,
      segmentStart: start,
      lastPulse: start,
      now: start.add(const Duration(minutes: 30)),
    );
    expect(elapsed, Duration.zero);
    final idle = time.elapsed(
      foreground: true,
      segmentStart: start,
      lastPulse: start,
      now: start.add(const Duration(minutes: 10)),
    );
    expect(idle, Duration.zero);
  });

  test('grammar scoring and achievements unlock once', () async {
    final score = scoreGrammar(const [
      GrammarAnswer(prompt: 'She ___', given: 'goes', expected: 'goes'),
      GrammarAnswer(prompt: 'She ___', given: 'go', expected: 'goes'),
    ]);
    expect(score.correct, 1);
    expect(score.passed, isFalse);

    final ids = AchievementCatalog.earnedIds(
      discovered: 100,
      mastered: 10,
      grammarCompleted: 1,
      streak: 7,
      activeSeconds: 3600,
      masteredByLevel: const {'A1': 2},
      totalsByLevel: const {'A1': 2},
    );
    expect(ids, contains('words-100'));
    expect(ids, contains('level-a1'));
    expect(
      AchievementCatalog.byId('level-a1')!.detailEn,
      contains('not an official CEFR'),
    );

    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await db.into(db.vocabularyEntries).insert(
          VocabularyEntriesCompanion.insert(
            id: 'one-noun',
            lemma: 'one',
            cefrLevel: 'A1',
            partOfSpeech: 'noun',
            definitionEn: '',
            arabicMeaning: '',
            exampleSentence: '',
          ),
        );
    await db.into(db.userVocabulary).insert(
          UserVocabularyCompanion.insert(
            entryId: 'one-noun',
            firstDiscoveredAt: DateTime.utc(2026, 10, 1),
            discoveredIn: 'blog',
            lastUsedAt: DateTime.utc(2026, 10, 1),
          ),
        );
    final service = AchievementService(db);
    await service.sync(now: DateTime.utc(2026, 10, 1));
    await service.sync(now: DateTime.utc(2026, 10, 2));
    final rows = await db.select(db.userAchievements).get();
    expect(rows.where((row) => row.id == 'first-word'), hasLength(1));
    expect(rows.singleWhere((row) => row.id == 'first-word').celebrated, isFalse);
    await service.markCelebrated('first-word');
    expect(await service.uncelebrated(), isNot(contains(predicate<UserAchievementRow>((row) => row.id == 'first-word'))));
  });

  test('an older backup and an older vocabulary row still load', () async {
    final legacy = LexoraBackup(
      schemaVersion: 2,
      exportedAt: DateTime.utc(2026, 9, 1),
      payload: {
        'words': [
          {
            'id': 'w1',
            'word': 'kept',
            'arabicMeaning': 'محفوظ',
            'cefrLevel': 'A2',
            'partOfSpeech': 'noun',
            'phonetic': null,
            'notes': null,
            'exampleSentence': null,
            'exampleTranslation': null,
            'isFavorite': false,
            'inReviewSystem': true,
            'masteryStatus': 'learning',
            'reviewCount': 2,
            'lastReviewedAt': null,
            'createdAt': 1700000000000,
            'updatedAt': 1700000000000,
          },
        ],
        'vocabularyEntries': [
          {
            'id': 'kept-noun',
            'lemma': 'kept',
            'cefrLevel': 'A2',
            'partOfSpeech': 'noun',
            'definitionEn': '',
            'arabicMeaning': '',
            'exampleSentence': '',
            'phonetic': null,
            'academic': false,
            'ieltsRelevant': false,
            'toeflRelevant': false,
            'catalogVersion': 2,
          },
        ],
        'userVocabulary': [
          {
            'entryId': 'kept-noun',
            'status': 'learning',
            'firstDiscoveredAt': 1700000000000,
            'discoveredIn': 'blog',
            'sourceId': 'blog-1',
            'usageCount': 4,
            'lastUsedAt': 1700000000000,
          },
        ],
      },
    );
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await LexoraBackupStore(db).importEncoded(legacy.encode());
    final word = await db.select(db.words).getSingle();
    expect(word.word, 'kept');
    expect(word.reviewCount, 2);
    final progress = await db.select(db.userVocabulary).getSingle();
    expect(progress.usageCount, 4);
    expect(progress.status, 'learning');
    expect(progress.userArabicMeaning, isNull);
  });

  test('schema upgrade keeps an existing vocabulary row', () async {
    final raw = sqlite3.openInMemory();
    raw.execute('''
      CREATE TABLE user_vocabulary (
        entry_id TEXT NOT NULL PRIMARY KEY,
        status TEXT NOT NULL DEFAULT 'discovered',
        first_discovered_at INTEGER NOT NULL,
        discovered_in TEXT NOT NULL,
        source_id TEXT,
        usage_count INTEGER NOT NULL DEFAULT 1,
        last_used_at INTEGER NOT NULL
      )
    ''');
    raw.execute(
      "INSERT INTO user_vocabulary VALUES ('school-noun', 'mastered', 1700000000, 'blog', 'blog-1', 9, 1700000000)",
    );
    raw.execute('PRAGMA user_version = 4');
    final db = AppDatabase(NativeDatabase.opened(raw));
    addTearDown(db.close);
    final row = await db.select(db.userVocabulary).getSingle();
    expect(row.entryId, 'school-noun');
    expect(row.usageCount, 9);
    expect(row.status, 'mastered');
    expect(row.userArabicMeaning, isNull);
    expect(await db.select(db.grammarTopics).get(), isEmpty);
  });

  test('a missing old photo path does not throw and a real file is copied', () async {
    final root = Directory.systemTemp.createTempSync('lexora-photos');
    ProfileImageStore.documentsDirectoryOverride = root;
    addTearDown(() {
      ProfileImageStore.documentsDirectoryOverride = null;
      if (root.existsSync()) root.deleteSync(recursive: true);
    });
    final missing = File(
      '${Directory.systemTemp.path}${Platform.pathSeparator}lexora-missing-photo.jpg',
    );
    if (missing.existsSync()) await missing.delete();
    expect(await ProfileImageStore.migrate(missing.path), isEmpty);

    final source = File(
      '${Directory.systemTemp.path}${Platform.pathSeparator}lexora-profile-source.jpg',
    );
    await source.writeAsBytes([1, 2, 3, 4]);
    final relative = await ProfileImageStore.migrate(source.path);
    expect(relative, startsWith('user_images/profile_'));
    final resolved = await ProfileImageStore.resolve(relative);
    expect(resolved, isNotNull);
    expect(await resolved!.readAsBytes(), [1, 2, 3, 4]);
    await ProfileImageStore.deleteStored(relative);
  });
}
