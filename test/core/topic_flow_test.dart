import 'dart:io';

import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/services/topics/topic_catalog.dart';
import 'package:lexora/core/services/topics/topic_catalog_importer.dart';
import 'package:lexora/core/services/topics/topic_repository.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_catalog.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_catalog_importer.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_discovery_repository.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final catalogRaw =
      File('data/vocabulary/catalog.development.json').readAsStringSync();
  final topicsRaw = File('assets/vocabulary/topics.json').readAsStringSync();

  test('topics catalog has 50 topics and grouped paths', () {
    final catalog = VocabularyCatalogDocument.parse(catalogRaw);
    expect(catalog.datasetType, 'development');
    expect(catalog.identity, '2:development');
    expect(catalog.entries, hasLength(inInclusiveRange(120, 200)));
    final document = TopicCatalogDocument.parse(topicsRaw);
    expect(document.datasetType, 'development');
    expect(document.identity, '3:development');
    expect(document.topics.map((topic) => topic.id).toSet(), hasLength(50));
    expect(document.groups, hasLength(9));
    expect(document.paths, hasLength(3));
    expect(document.ranks, isEmpty);
    expect(document.sentences, hasLength(greaterThanOrEqualTo(150)));
    final links = <String, int>{};
    for (final link in document.links) {
      links[link.topicId] = (links[link.topicId] ?? 0) + 1;
    }
    expect(links.keys, document.topics.map((topic) => topic.id).toSet());
    expect(links.values.every((count) => count >= 3), isTrue);
  });

  test('import keeps user progress and does not duplicate links', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await VocabularyCatalogImporter(db).importJson(catalogRaw);
    final now = DateTime.utc(2026, 9, 29);
    await db.into(db.userVocabulary).insert(
          UserVocabularyCompanion.insert(
            entryId: 'school-noun',
            firstDiscoveredAt: now,
            discoveredIn: 'blog',
            sourceId: const Value('blog-1'),
            lastUsedAt: now,
          ),
        );

    final importer = TopicCatalogImporter(db);
    await importer.importJson(topicsRaw);
    final first = await db.select(db.vocabularyTopics).get();
    expect(first, isNotEmpty);

    await (db.delete(db.appStatistics)
          ..where((row) => row.key.equals(topicsCatalogVersionKey)))
        .go();
    await importer.importJson(topicsRaw);
    final second = await db.select(db.vocabularyTopics).get();
    expect(second, hasLength(first.length));
    final progress = await db.select(db.userVocabulary).getSingle();
    expect(progress.entryId, 'school-noun');
    expect(progress.usageCount, 1);
  });

  test('one unlock is shared by every topic of that word', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await VocabularyCatalogImporter(db).importJson(catalogRaw);
    await TopicCatalogImporter(db).importJson(topicsRaw);
    final now = DateTime.utc(2026, 9, 29);
    await db.into(db.blogEntries).insert(
          BlogEntriesCompanion.insert(
            id: 'blog-1',
            title: 'School',
            content: 'school',
            createdAt: now,
            updatedAt: now,
          ),
        );

    final summary = await VocabularyDiscoveryRepository(db).analyzeAndRecord(
      text: 'school',
      discoveredIn: 'blog',
      sourceId: 'blog-1',
      trackBlogLinks: true,
    );
    expect(summary.newlyDiscovered.single.entryId, 'school-noun');
    expect(summary.detectedTopics, isEmpty);

    await VocabularyDiscoveryRepository(db).analyzeAndRecord(
      text: 'school writing academic vocabulary',
      discoveredIn: 'blog',
      sourceId: 'blog-1',
      trackBlogLinks: true,
    );
    final progress = await db.select(db.userVocabulary).get();
    expect(progress.map((row) => row.entryId).toSet(), {
      'school-noun',
      'writing-noun',
      'academic-adjective',
      'vocabulary-noun',
    });
    final school = progress.firstWhere((row) => row.entryId == 'school-noun');
    expect(school.usageCount, 1);

    final repo = TopicRepository(db);
    final education = await repo.words(topicId: 'education');
    final university = await repo.words(topicId: 'university');
    expect(
      education.firstWhere((word) => word.entryId == 'school-noun').status,
      'discovered',
    );
    expect(
      university.firstWhere((word) => word.entryId == 'school-noun').status,
      'discovered',
    );
    expect(await db.select(db.userVocabulary).get(), hasLength(4));

    final a1 = await repo.words(topicId: 'education', cefr: 'A1');
    expect(a1.map((word) => word.entryId), ['school-noun']);
    final locked = await repo.words(
      topicId: 'education',
      filter: TopicWordFilter.locked,
    );
    expect(locked.map((word) => word.entryId), isNot(contains('school-noun')));
    final discovered = await repo.words(
      topicId: 'education',
      filter: TopicWordFilter.discovered,
    );
    expect(discovered.map((word) => word.entryId), contains('school-noun'));

    final stats = await repo.progress('education');
    expect(stats.mastered, 0);
    expect(stats.discovered, greaterThan(0));
    expect(stats.locked, stats.total - stats.unlocked);
    expect(stats.progress, isNot(stats.mastered / stats.total));
  });

  test('schema 3 migration keeps an existing vocabulary row', () async {
    final raw = sqlite3.openInMemory();
    raw.execute('PRAGMA user_version = 2');
    raw.execute('''
      CREATE TABLE vocabulary_entries (
        id TEXT NOT NULL PRIMARY KEY,
        lemma TEXT NOT NULL,
        cefr_level TEXT NOT NULL,
        part_of_speech TEXT NOT NULL,
        definition_en TEXT NOT NULL,
        arabic_meaning TEXT NOT NULL,
        example_sentence TEXT NOT NULL,
        phonetic TEXT,
        academic INTEGER NOT NULL DEFAULT 0 CHECK (academic IN (0, 1)),
        ielts_relevant INTEGER NOT NULL DEFAULT 0 CHECK (ielts_relevant IN (0, 1)),
        toefl_relevant INTEGER NOT NULL DEFAULT 0 CHECK (toefl_relevant IN (0, 1)),
        catalog_version INTEGER NOT NULL DEFAULT 1
      )
    ''');
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
      "INSERT INTO vocabulary_entries (id, lemma, cefr_level, part_of_speech, definition_en, arabic_meaning, example_sentence) VALUES ('school', 'school', 'A1', 'noun', 'A place to learn.', 'مدرسة', 'She goes to school.')",
    );
    raw.execute(
      "INSERT INTO user_vocabulary (entry_id, status, first_discovered_at, discovered_in, source_id, usage_count, last_used_at) VALUES ('school', 'learning', 1700000000, 'blog', 'blog-1', 4, 1700000000)",
    );

    final db = AppDatabase(NativeDatabase.opened(raw));
    addTearDown(db.close);
    final row = await db.select(db.userVocabulary).getSingle();
    expect(row.entryId, 'school');
    expect(row.usageCount, 4);
    expect(row.status, 'learning');
    expect(await db.select(db.topics).get(), isEmpty);
    final entry = await db.select(db.vocabularyEntries).getSingle();
    expect(entry.lemma, 'school');
  });

  test('a practice blog unlocks technology, war, university, and travel', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await VocabularyCatalogImporter(db).importJson(catalogRaw);
    await TopicCatalogImporter(db).importJson(topicsRaw);
    final now = DateTime.utc(2026, 9, 29);
    await db.into(db.blogEntries).insert(
          BlogEntriesCompanion.insert(
            id: 'blog-demo',
            title: 'A mixed day',
            content: 'demo',
            createdAt: now,
            updatedAt: now,
          ),
        );

    const text =
        'I study academic research at the university and develop software technology on the internet. I travel to the airport with a hotel reservation. The ceasefire and the negotiation reduced the conflict.';
    final repo = VocabularyDiscoveryRepository(db);
    final summary = await repo.analyzeAndRecord(
      text: text,
      discoveredIn: 'blog',
      sourceId: 'blog-demo',
      trackBlogLinks: true,
    );
    final again = await repo.analyzeAndRecord(
      text: text,
      discoveredIn: 'blog',
      sourceId: 'blog-demo',
      trackBlogLinks: true,
    );

    expect(summary.newlyDiscovered.map((word) => word.lemma), containsAll([
      'software',
      'technology',
      'university',
      'ceasefire',
      'travel',
      'reservation',
    ]));
    expect(again.newlyDiscovered, isEmpty);
    final topics = summary.detectedTopics.map((topic) => topic.topicId).toSet();
    expect(topics, containsAll(['technology', 'war', 'university', 'travel']));

    final technology = await TopicRepository(db).words(topicId: 'technology');
    expect(
      technology.firstWhere((word) => word.lemma == 'software').status,
      'discovered',
    );
    final war = await TopicRepository(db).words(topicId: 'war');
    expect(
      war.firstWhere((word) => word.lemma == 'ceasefire').status,
      'discovered',
    );
    final software = await (db.select(db.userVocabulary)
          ..where((row) => row.entryId.equals('software-noun')))
        .getSingle();
    expect(software.usageCount, 1);
    expect(software.status, 'discovered');
  });
}
