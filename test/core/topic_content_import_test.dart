import 'dart:io';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/services/topics/topic_content_importer.dart';
import 'package:lexora/core/services/topics/topic_question_payload.dart';
import 'package:lexora/core/services/topics/topic_repository.dart';

void main() {
  test('settings imports topic content and the detail tabs only display it', () {
    final settings = File(
      'lib/features/settings/presentation/settings_screen.dart',
    ).readAsStringSync();
    final details = File(
      'lib/features/topics/presentation/topic_detail_screen.dart',
    ).readAsStringSync();
    final router = File('lib/app/router/app_router.dart').readAsStringSync();
    expect(settings.contains('_importTopicContent'), isTrue);
    expect(settings.contains('importTopicContent'), isTrue);
    expect(details.contains('FilePicker'), isFalse);
    expect(details.contains('importTopicContent'), isFalse);
    expect(details.contains('_import'), isFalse);
    expect(router.contains('TopicDetailScreen'), isTrue);
    expect(router.contains('DailyLifeScreen'), isFalse);
    expect(router.contains('JobInterviewScreen'), isFalse);
  });

  test('topic content import merges categories, topics, and user progress', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final importer = TopicContentImporter(db);
    await _entry(db, 'breakfast');
    await _entry(db, 'routine');
    await db.into(db.userVocabulary).insert(
          UserVocabularyCompanion.insert(
            entryId: 'breakfast',
            status: const Value('mastered'),
            firstDiscoveredAt: DateTime.utc(2026, 10, 1),
            discoveredIn: 'test',
            lastUsedAt: DateTime.utc(2026, 10, 1),
          ),
        );

    final raw = await File('samples/topic_content_import.json').readAsString();
    final withProgress = raw.replaceFirst(
      '"vocabulary": [',
      '"progress": 50, "vocabulary": [',
    );
    final first = await importer.importJson(withProgress);
    expect(first.categoriesAdded, 2);
    expect(first.topicsAdded, 2);
    expect(first.vocabularyLinksAdded, 2);
    expect(first.sentencesAdded, 1);
    expect(first.questionsAdded, 2);
    expect(first.vocabularyUnresolved, 0);

    final repo = TopicRepository(db);
    final dailyWords = await repo.words(topicId: 'daily_life');
    expect(dailyWords.map((word) => word.entryId), containsAll(['breakfast', 'routine']));
    final interviewWords = await repo.words(topicId: 'job_interview');
    expect(interviewWords, isEmpty);
    final sentences = await repo.sentences(topicId: 'daily_life');
    expect(sentences.single.sentenceEn, 'Breakfast is part of my daily routine.');
    expect(sentences.single.sentenceAr, 'الإفطار جزء من روتيني اليومي.');
    final questions = await (db.select(db.topicQuestions)
          ..where((row) => row.topicId.equals('daily_life')))
        .get();
    expect(questions.single.promptAr, 'ماذا تفعل عادةً في الصباح؟');
    final payload = TopicQuestionPayload.parse(questions.single.suggestedAnswer);
    expect(payload.answerFor(arabic: true), 'عادةً أتناول الإفطار وأبدأ يومي.');
    expect(payload.answerFor(arabic: false), contains('breakfast'));

    final progress = await repo.progress('daily_life');
    expect(progress.mastered, 1);
    expect(progress.total, 2);
    expect(progress.progress, closeTo(0.5, 0.001));

    final second = await importer.importJson(raw);
    expect(second.categoriesAdded, 0);
    expect(second.categoriesUpdated, 2);
    expect(second.topicsAdded, 0);
    expect(second.topicsUpdated, 2);
    expect(second.vocabularyLinksAdded, 0);
    expect(second.sentencesAdded, 0);
    expect(second.sentencesUpdated, 1);
    expect(second.questionsAdded, 0);
    expect(await db.select(db.topics).get(), hasLength(2));
    expect(await db.select(db.topicSentences).get(), hasLength(1));
    expect(await db.select(db.topicQuestions).get(), hasLength(2));
    final still = await (db.select(db.userVocabulary)
          ..where((row) => row.entryId.equals('breakfast')))
        .getSingle();
    expect(still.status, 'mastered');

    final renamed = raw.replaceFirst('Daily Life', 'Everyday Life');
    await importer.importJson(renamed);
    final topic = await repo.topic('daily_life');
    expect(topic!.nameEn, 'Everyday Life');
    expect(await db.select(db.topics).get(), hasLength(2));
  });

  test('new question types and empty topics import without a new screen', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    const raw = '''
{
  "schemaVersion": 1,
  "categories": [
    {"id": "travel", "name": {"en": "Travel", "ar": "السفر"}}
  ],
  "topics": [
    {
      "id": "airport",
      "categoryId": "travel",
      "name": {"en": "Airport", "ar": "المطار"},
      "description": {"en": "At the airport.", "ar": "في المطار."},
      "vocabulary": [],
      "sentences": [],
      "questions": [
        {
          "id": "airport_choice",
          "type": "multiple_choice",
          "question": {"en": "Where is the gate?", "ar": "أين البوابة؟"},
          "options": [
            {"id": "a", "en": "Left", "ar": "يسار"},
            {"id": "b", "en": "Right", "ar": "يمين"}
          ],
          "correctOptionId": "a",
          "cefr": "A1",
          "wordIds": []
        },
        {
          "id": "airport_blank",
          "type": "fill_blank",
          "question": {"en": "The ___ is open.", "ar": "الـ ___ مفتوحة."},
          "answer": {"en": "gate", "ar": "البوابة"},
          "cefr": "A1",
          "wordIds": []
        }
      ]
    }
  ]
}
''';
    final summary = await TopicContentImporter(db).importJson(raw);
    expect(summary.categoriesAdded, 1);
    expect(summary.topicsAdded, 1);
    expect(summary.questionsAdded, 2);
    expect(await TopicRepository(db).words(topicId: 'airport'), isEmpty);
    expect(await TopicRepository(db).sentences(topicId: 'airport'), isEmpty);
    final choice = await (db.select(db.topicQuestions)
          ..where((row) => row.id.equals('airport_choice')))
        .getSingle();
    final payload = TopicQuestionPayload.parse(choice.suggestedAnswer);
    expect(payload.type, 'multiple_choice');
    expect(payload.answerFor(arabic: false), 'Left');
    expect(payload.options, hasLength(2));
    final groups = await db.select(db.topicGroups).get();
    expect(groups.single.id, 'travel');
  });

  test('bad files are rejected and a failed write rolls back', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final importer = TopicContentImporter(db);
    expect(
      () => importer.importJson('{'),
      throwsA(
        isA<TopicContentException>().having(
          (error) => error.failure,
          'failure',
          TopicContentFailure.malformed,
        ),
      ),
    );
    expect(
      () => importer.importJson('{"schemaVersion": 2}'),
      throwsA(
        isA<TopicContentException>().having(
          (error) => error.failure,
          'failure',
          TopicContentFailure.unsupportedSchema,
        ),
      ),
    );
    expect(
      () => importer.importJson('''
{
  "schemaVersion": 1,
  "categories": [],
  "topics": [
    {
      "id": "orphan",
      "categoryId": "missing",
      "name": {"en": "Orphan", "ar": "يتيم"},
      "vocabulary": [],
      "sentences": [],
      "questions": []
    }
  ]
}
'''),
      throwsA(
        isA<TopicContentException>().having(
          (error) => error.failure,
          'failure',
          TopicContentFailure.invalid,
        ),
      ),
    );
    expect(await db.select(db.topics).get(), isEmpty);

    const valid = '''
{
  "schemaVersion": 1,
  "categories": [
    {"id": "everyday_english", "name": {"en": "Everyday", "ar": "يومي"}}
  ],
  "topics": []
}
''';
    await expectLater(
      importer.importJson(valid, abortBeforeCommit: true),
      throwsA(isA<TopicContentException>()),
    );
    expect(await db.select(db.topicGroups).get(), isEmpty);

    final unresolved = await importer.importJson('''
{
  "schemaVersion": 1,
  "categories": [
    {"id": "everyday_english", "name": {"en": "Everyday", "ar": "يومي"}}
  ],
  "topics": [
    {
      "id": "daily_life",
      "categoryId": "everyday_english",
      "name": {"en": "Daily Life", "ar": "الحياة اليومية"},
      "vocabulary": ["missing_word"],
      "sentences": [],
      "questions": []
    }
  ]
}
''');
    expect(unresolved.vocabularyLinksAdded, 0);
    expect(unresolved.vocabularyUnresolved, 1);
    expect(unresolved.warnings, 1);
    expect(await TopicRepository(db).words(topicId: 'daily_life'), isEmpty);
  });
}

Future<void> _entry(AppDatabase db, String id) {
  return db.into(db.vocabularyEntries).insert(
        VocabularyEntriesCompanion.insert(
          id: id,
          lemma: id,
          cefrLevel: 'A2',
          partOfSpeech: 'noun',
          definitionEn: 'A catalog word.',
          arabicMeaning: 'كلمة',
          exampleSentence: 'Example.',
        ),
      );
}

