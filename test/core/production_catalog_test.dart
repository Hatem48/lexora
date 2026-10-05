import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/constants/enums.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/services/topics/topic_catalog.dart';
import 'package:lexora/core/services/topics/topic_catalog_importer.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_catalog.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_catalog_importer.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_discovery_repository.dart';

void main() {
  final productionRaw =
      File('assets/vocabulary/catalog.json').readAsStringSync();
  final developmentRaw =
      File('data/vocabulary/catalog.development.json').readAsStringSync();
  final topicsRaw = File('assets/vocabulary/topics.json').readAsStringSync();
  final production = VocabularyCatalogDocument.parse(productionRaw);

  CatalogEntry byId(String id) =>
      production.entries.singleWhere((entry) => entry.id == id);

  test('production catalog is an enriched licensed A1-C2 list', () {
    expect(production.datasetType, 'production');
    expect(production.identity, '4:production');
    expect(production.version, 4);
    expect(production.entries.length, 9660);
    const levels = {'A1', 'A2', 'B1', 'B2', 'C1', 'C2'};
    final ids = <String>{};
    for (final entry in production.entries) {
      expect(levels, contains(entry.cefr));
      expect(entry.lemma.trim(), isNotEmpty);
      expect(entry.pos.trim(), isNotEmpty);
      expect(entry.definitionEn.trim(), isNotEmpty);
      expect(entry.arabicMeaning.trim(), isNotEmpty);
      expect(entry.example.trim(), isNotEmpty);
      expect(entry.ielts, isFalse);
      expect(entry.toefl, isFalse);
      expect(ids.add(entry.id), isTrue);
      for (final rank in [entry.ngslRank, entry.spokenRank, entry.academicRank]) {
        if (rank != null) expect(rank, greaterThan(0));
      }
    }
    expect(ids, hasLength(9660));
    expect(production.entries.map((entry) => entry.cefr).toSet(), levels);
  });

  test('latter stays distinct from later and the bad time-adverb sentence is gone', () {
    expect(byId('latter-adjective').lemma, 'latter');
    expect(byId('latter-adverb').lemma, 'latter');
    expect(byId('latter-pronoun').lemma, 'latter');
    expect(byId('later-adjective').lemma, 'later');
    expect(byId('later-adverb').lemma, 'later');
    expect(byId('latter-adverb').example.toLowerCase(), contains('later'));
    expect(
      byId('latter-adverb').example,
      isNot(contains('The rain grew heavier latter in the afternoon.')),
    );
    expect(
      production.entries.any(
        (entry) =>
            entry.example.contains('The rain grew heavier latter in the afternoon.'),
      ),
      isFalse,
    );
  });

  test('forms regressions from the enrichment cleanup remain fixed', () {
    const banned = {
      'colorred',
      'harbourred',
      'takeofves',
      'sportses',
      'cybercaves',
    };
    for (final entry in production.entries) {
      for (final form in entry.forms) {
        expect(banned.contains(form), isFalse, reason: '${entry.id} $form');
      }
    }
    expect(
      byId('color-colour-noun').forms,
      containsAll(['color', 'colour', 'colors', 'colours']),
    );
    expect(byId('color-colour-verb').forms, isNot(contains('colorred')));
    expect(
      byId('harbor-harbour-noun').forms,
      containsAll(['harbor', 'harbour', 'harbors', 'harbours']),
    );
    expect(
      byId('cafe-caf-noun').forms,
      containsAll(['cafe', 'café', 'cafes', 'cafés']),
    );
    expect(byId('cafe-caf-noun').forms, isNot(contains('caves')));
    expect(
      byId('cybercafe-cybercaf-noun').forms,
      containsAll(['cybercafe', 'cybercafé', 'cybercafes', 'cybercafés']),
    );
    expect(
      byId('takeoff-take-off-noun').forms,
      containsAll(['takeoff', 'take-off', 'takeoffs', 'take-offs']),
    );
    expect(
      byId('sports-center-sports-centre-noun').forms,
      containsAll([
        'sports center',
        'sports centre',
        'sports centers',
        'sports centres',
      ]),
    );
    expect(
      byId('hip-hop-hip-hop-hiphop-noun').forms,
      containsAll(['hip hop', 'hip-hop', 'hiphop']),
    );
  });

  test('irregular verb forms keep the expected past and participle shapes', () {
    expect(byId('be-auxiliary').forms, containsAll(['am', 'is', 'are', 'was', 'were', 'been']));
    expect(byId('have-auxiliary').forms, containsAll(['have', 'has', 'had']));
    expect(byId('do-auxiliary').forms, containsAll(['do', 'does', 'did', 'done']));
    expect(byId('go-verb').forms, containsAll(['go', 'goes', 'went', 'gone']));
    expect(byId('take-verb').forms, containsAll(['take', 'took', 'taken']));
    expect(byId('write-verb').forms, containsAll(['write', 'wrote', 'written']));
    expect(byId('speak-verb').forms, containsAll(['speak', 'spoke', 'spoken']));
    expect(byId('buy-verb').forms, containsAll(['buy', 'bought']));
    expect(byId('teach-verb').forms, containsAll(['teach', 'taught']));
    expect(byId('choose-verb').forms, containsAll(['choose', 'chose', 'chosen']));
    expect(byId('eat-verb').forms, containsAll(['eat', 'ate', 'eaten']));
    expect(byId('run-verb').forms, containsAll(['run', 'ran']));
    expect(byId('swim-verb').forms, containsAll(['swim', 'swam', 'swum']));
    expect(byId('wear-verb').forms, containsAll(['wear', 'wore', 'worn']));
    expect(byId('win-verb').forms, containsAll(['win', 'won']));
  });

  test('develop and development stay independent catalog entries', () {
    final problem = byId('problem-noun');
    expect(problem.pos, 'noun');
    expect(problem.cefr, 'A1');
    expect(problem.arabicMeaning, 'مشكلة؛ مسألة تحتاج إلى حل');
    expect(
      problem.definitionEn,
      'A difficult situation or question that needs to be solved.',
    );
    expect(problem.example, 'The problem is that the door will not open.');
    expect(problem.example.toLowerCase(), contains('problem'));
    expect(problem.forms, ['problem', 'problems']);
    expect(production.entries.where((entry) => entry.lemma == 'gard'), isEmpty);
    expect(byId('pro-noun').arabicMeaning, isNot(problem.arabicMeaning));

    expect(byId('develop-verb').forms, containsAll(['develop', 'develops', 'developing']));
    expect(byId('develop-verb').forms, isNot(contains('development')));
    expect(byId('development-noun').forms, containsAll(['development', 'developments']));
    expect(byId('development-noun').lemma, 'development');
  });

  test('topic links are unique, topic ids are valid, and new links are present', () {
    final topics = TopicCatalogDocument.parse(topicsRaw);
    expect(topics.datasetType, 'development');
    expect(topics.identity, '3:development');
    expect(topics.groups, hasLength(9));
    expect(topics.topics, hasLength(50));
    expect(topics.paths, hasLength(3));
    expect(topics.links, hasLength(522));
    final topicIds = topics.topics.map((topic) => topic.id).toSet();
    final vocabIds = production.entries.map((entry) => entry.id).toSet();
    final pairs = <String>{};
    var missingVocab = 0;
    for (final link in topics.links) {
      expect(topicIds, contains(link.topicId));
      expect(pairs.add('${link.entryId}|${link.topicId}'), isTrue);
      if (!vocabIds.contains(link.entryId)) missingVocab += 1;
    }
    expect(missingVocab, 50);
    expect(pairs, contains('account-noun|money'));
    expect(
      topics.links.any((link) => link.entryId == 'airport-noun' && link.topicId == 'airport'),
      isTrue,
    );
  });

  test(
    'fresh import, catalog update, and an older install keep user progress',
    () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final importer = VocabularyCatalogImporter(db);

      await importer.importJson(developmentRaw);
      final development = VocabularyCatalogDocument.parse(developmentRaw);
      final kept = development.entries.first;
      final now = DateTime.utc(2026, 9, 29);
      await db.into(db.userVocabulary).insert(
            UserVocabularyCompanion.insert(
              entryId: kept.id,
              status: const Value('mastered'),
              firstDiscoveredAt: now,
              discoveredIn: 'blog',
              sourceId: const Value('blog-kept'),
              usageCount: const Value(7),
              lastUsedAt: now,
            ),
          );
      await db.into(db.reviewItems).insert(
            ReviewItemsCompanion.insert(
              id: 'review-kept',
              itemType: ReviewItemType.vocabulary.storageValue,
              itemId: kept.id,
              nextReviewAt: now,
              createdAt: now,
              updatedAt: now,
            ),
          );
      await db.into(db.words).insert(
            WordsCompanion.insert(
              id: 'custom-word',
              word: 'myword',
              arabicMeaning: 'كلمتي',
              cefrLevel: 'A2',
              partOfSpeech: 'noun',
              createdAt: now,
              updatedAt: now,
            ),
          );
      await db.into(db.sentences).insert(
            SentencesCompanion.insert(
              id: 'custom-sentence',
              sentence: 'I wrote this sentence.',
              arabicTranslation: 'كتبت هذه الجملة.',
              cefrLevel: 'A2',
              createdAt: now,
              updatedAt: now,
            ),
          );
      await db.into(db.vocabularyEntries).insert(
            VocabularyEntriesCompanion.insert(
              id: 'demo-only-noun',
              lemma: 'demo-only',
              cefrLevel: 'A1',
              partOfSpeech: 'noun',
              definitionEn: '',
              arabicMeaning: '',
              exampleSentence: '',
            ),
          );
      await db.into(db.userVocabulary).insert(
            UserVocabularyCompanion.insert(
              entryId: 'demo-only-noun',
              status: const Value('learning'),
              firstDiscoveredAt: now,
              discoveredIn: 'sentence',
              sourceId: const Value('sentence-kept'),
              usageCount: const Value(3),
              lastUsedAt: now,
            ),
          );

      final started = DateTime.now();
      await importer.importJson(productionRaw);
      final elapsed = DateTime.now().difference(started);
      expect(elapsed.inSeconds, lessThan(20));

      final progress = await (db.select(db.userVocabulary)
            ..where((row) => row.entryId.equals(kept.id)))
          .getSingle();
      expect(progress.status, 'mastered');
      expect(progress.usageCount, 7);
      expect(progress.discoveredIn, 'blog');
      expect(progress.sourceId, 'blog-kept');

      final preserved = await (db.select(db.userVocabulary)
            ..where((row) => row.entryId.equals('demo-only-noun')))
          .getSingle();
      expect(preserved.status, 'learning');
      expect(preserved.usageCount, 3);
      expect(preserved.discoveredIn, 'sentence');
      expect(await db.select(db.reviewItems).get(), hasLength(1));
      expect((await db.select(db.words).get()).single.word, 'myword');
      expect((await db.select(db.sentences).get()).single.id, 'custom-sentence');

      final stored = await (db.select(db.appStatistics)
            ..where((row) => row.key.equals(vocabularyCatalogVersionKey)))
          .getSingle();
      expect(stored.value, '4:production');
      final keptInProduction =
          production.entries.any((entry) => entry.id == kept.id);
      final count = await db.select(db.vocabularyEntries).get();
      expect(
        count.length,
        production.entries.length + (keptInProduction ? 1 : 2),
      );

      final abandon = await (db.select(db.vocabularyEntries)
            ..where((row) => row.id.equals('abandon-verb')))
          .getSingle();
      expect(abandon.definitionEn, isNotEmpty);
      expect(abandon.arabicMeaning, isNotEmpty);
      expect(abandon.exampleSentence, isNotEmpty);
      expect(abandon.catalogVersion, 4);

      await importer.importJson(productionRaw);
      final afterUpdate = await (db.select(db.userVocabulary)
            ..where((row) => row.entryId.equals(kept.id)))
          .getSingle();
      expect(afterUpdate.usageCount, 7);
      expect((await db.select(db.vocabularyEntries).get()).length, count.length);

      final a1 = await (db.select(db.vocabularyEntries)
            ..where((row) => row.cefrLevel.equals('A1'))
            ..limit(1))
          .getSingle();
      final found = await (db.select(db.vocabularyEntries)
            ..where((row) => row.lemma.equals(a1.lemma)))
          .get();
      expect(found.map((row) => row.id), contains(a1.id));
      final outside = await (db.select(db.vocabularyEntries)
            ..where((row) => row.cefrLevel.isNotIn(const [
                  'A1',
                  'A2',
                  'B1',
                  'B2',
                  'C1',
                  'C2',
                ])))
          .get();
      expect(outside, isEmpty);

      final recordSenses = await (db.select(db.vocabularyEntries)
            ..where((row) => row.lemma.equals('record')))
          .get();
      expect(recordSenses.length, greaterThan(1));
      expect(
        recordSenses.map((row) => row.partOfSpeech).toSet().length,
        greaterThan(1),
      );

      final developmentForm = await (db.select(db.vocabularyForms)
            ..where((row) => row.surface.equals('development')))
          .getSingle();
      expect(developmentForm.entryId, 'development-noun');

      await TopicCatalogImporter(db).importJson(topicsRaw);
      final topicLinks = await db.select(db.vocabularyTopics).get();
      expect(topicLinks, isNotEmpty);
      final known = {
        for (final row in await db.select(db.vocabularyEntries).get()) row.id,
      };
      expect(
        topicLinks.every((link) => known.contains(link.entryId)),
        isTrue,
      );
      final topicPairs = topicLinks.map((link) => '${link.entryId}|${link.topicId}');
      expect(topicPairs.toSet(), hasLength(topicLinks.length));

      final surface = await (db.select(db.vocabularyForms)
            ..where((row) => row.entryId.equals(kept.id).not())
            ..limit(1))
          .getSingle();
      await db.into(db.blogEntries).insert(
            BlogEntriesCompanion.insert(
              id: 'blog-prod',
              title: 'Lookup',
              content: surface.surface,
              createdAt: now,
              updatedAt: now,
            ),
          );
      final summary = await VocabularyDiscoveryRepository(db).analyzeAndRecord(
        text: surface.surface,
        discoveredIn: 'blog',
        sourceId: 'blog-prod',
        trackBlogLinks: true,
      );
      expect(summary.newlyDiscovered.single.entryId, surface.entryId);
      expect(summary.cefrDistribution.values.single, 1);
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );

  test('catalog version 2 to 3 keeps user data and fills enriched fields', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final importer = VocabularyCatalogImporter(db);
    const v2 = '''
{
  "version": 2,
  "datasetType": "production",
  "entries": [
    {
      "id": "keep-verb",
      "lemma": "keep",
      "cefr": "A2",
      "pos": "verb",
      "definitionEn": "",
      "arabicMeaning": "",
      "example": "",
      "forms": ["keep", "kept"]
    }
  ]
}
''';
    const v3 = '''
{
  "version": 3,
  "datasetType": "production",
  "entries": [
    {
      "id": "keep-verb",
      "lemma": "keep",
      "cefr": "A2",
      "pos": "verb",
      "definitionEn": "To continue to have something.",
      "arabicMeaning": "يبقي شيئاً عنده",
      "example": "Keep the receipt.",
      "forms": ["keep", "kept", "keeping"]
    }
  ]
}
''';
    await importer.importJson(v2);
    final now = DateTime.utc(2026, 10, 1);
    await db.into(db.userVocabulary).insert(
          UserVocabularyCompanion.insert(
            entryId: 'keep-verb',
            status: const Value('mastered'),
            firstDiscoveredAt: now,
            discoveredIn: 'blog',
            sourceId: const Value('blog-keep'),
            usageCount: const Value(5),
            lastUsedAt: now,
            userNotes: const Value('my note'),
          ),
        );
    await db.into(db.reviewItems).insert(
          ReviewItemsCompanion.insert(
            id: 'review-keep',
            itemType: ReviewItemType.vocabulary.storageValue,
            itemId: 'keep-verb',
            nextReviewAt: now,
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.reviewHistory).insert(
          ReviewHistoryCompanion.insert(
            id: 'history-keep',
            reviewItemId: 'review-keep',
            itemType: ReviewItemType.vocabulary.storageValue,
            itemId: 'keep-verb',
            rating: 4,
            previousInterval: 0,
            newInterval: 1,
            reviewedAt: now,
          ),
        );
    await db.into(db.words).insert(
          WordsCompanion.insert(
            id: 'user-word',
            word: 'notebook',
            arabicMeaning: 'دفتر',
            cefrLevel: 'A1',
            partOfSpeech: 'noun',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await db.into(db.sentences).insert(
          SentencesCompanion.insert(
            id: 'user-sentence',
            sentence: 'This is mine.',
            arabicTranslation: 'هذه جملتي.',
            cefrLevel: 'A1',
            createdAt: now,
            updatedAt: now,
          ),
        );

    await importer.importJson(v3);
    final entry = await db.select(db.vocabularyEntries).getSingle();
    expect(entry.definitionEn, 'To continue to have something.');
    expect(entry.arabicMeaning, 'يبقي شيئاً عنده');
    expect(entry.exampleSentence, 'Keep the receipt.');
    expect(entry.catalogVersion, 3);
    final progress = await db.select(db.userVocabulary).getSingle();
    expect(progress.status, 'mastered');
    expect(progress.usageCount, 5);
    expect(progress.userNotes, 'my note');
    expect(await db.select(db.reviewItems).get(), hasLength(1));
    expect(await db.select(db.reviewHistory).get(), hasLength(1));
    expect((await db.select(db.words).get()).single.word, 'notebook');
    expect((await db.select(db.sentences).get()).single.id, 'user-sentence');
    expect(
      (await db.select(db.vocabularyForms).get()).map((row) => row.surface),
      containsAll(['keep', 'kept', 'keeping']),
    );
    expect(
      (await (db.select(db.appStatistics)
            ..where((row) => row.key.equals(vocabularyCatalogVersionKey)))
          .getSingle())
          .value,
      '3:production',
    );
  });
}
