import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/services/topics/imported_content_marks.dart';
import 'package:lexora/core/services/topics/topic_content_importer.dart';
import 'package:lexora/features/topics/presentation/imported_content_providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a newly imported topic and category are marked new', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await TopicContentImporter(db).importJson(_file(
      categories: [
        _category('fresh-lab', 'Fresh Lab', 'مختبر جديد'),
      ],
      topics: [
        _topic(
          id: 'cybersecurity',
          categoryId: 'fresh-lab',
          nameEn: 'Cybersecurity',
          nameAr: 'الأمن السيبراني',
        ),
      ],
    ));

    final marks = await ImportedContentStore(db).read();
    expect(marks.topicIds, {'cybersecurity'});
    expect(marks.categoryIds, {'fresh-lab'});
  });

  test('updating an existing topic does not mark it new', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await _seedTopic(
      db,
      groupId: 'study-career',
      groupEn: 'Study & Career',
      groupAr: 'الدراسة والعمل',
      topicId: 'job-interviews',
      topicEn: 'Job Interviews',
      topicAr: 'مقابلات العمل',
    );

    await TopicContentImporter(db).importJson(_file(
      topics: [
        _topic(
          id: 'job-interviews',
          categoryId: 'study-career',
          nameEn: 'Job Interviews',
          nameAr: 'مقابلات العمل',
          questions: [_question('job-interviews_question_001')],
        ),
      ],
    ));

    final marks = await ImportedContentStore(db).read();
    expect(marks.topicIds, isEmpty);
    expect(marks.categoryIds, isEmpty);
    final questions = await db.select(db.topicQuestions).get();
    expect(questions.single.id, 'job-interviews_question_001');
  });

  test('opening a topic marks only that topic seen', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final store = ImportedContentStore(db);
    await store.rememberCreated(
      topicIds: ['cybersecurity'],
      categoryIds: ['fresh-lab'],
    );

    final next = await store.markTopicSeen('cybersecurity');
    expect(next.topicIds, isEmpty);
    expect(next.categoryIds, {'fresh-lab'});
    expect((await store.read()).topicIds, isEmpty);
  });

  test('opening a category marks only that category seen', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final store = ImportedContentStore(db);
    await store.rememberCreated(
      topicIds: ['cybersecurity'],
      categoryIds: ['fresh-lab'],
    );

    final next = await store.markCategorySeen('fresh-lab');
    expect(next.categoryIds, isEmpty);
    expect(next.topicIds, {'cybersecurity'});
  });

  test('reloading state keeps unseen imported content new', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await ImportedContentStore(db).rememberCreated(
      topicIds: ['cybersecurity'],
      categoryIds: ['fresh-lab'],
    );

    final reloaded = await ImportedContentStore(db).read();
    expect(reloaded.topicIds, {'cybersecurity'});
    expect(reloaded.categoryIds, {'fresh-lab'});

    final first = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(first.dispose);
    expect(
      (await first.read(importedContentMarksProvider.future)).topicIds,
      {'cybersecurity'},
    );
    first.invalidate(importedContentMarksProvider);
    expect(
      (await first.read(importedContentMarksProvider.future)).categoryIds,
      {'fresh-lab'},
    );

    final second = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(second.dispose);
    final marks = await second.read(importedContentMarksProvider.future);
    expect(marks.topicIds, {'cybersecurity'});
    expect(marks.categoryIds, {'fresh-lab'});
  });

  test('re-import does not restore new after the topic was seen', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final raw = _file(
      categories: [
        _category('fresh-lab', 'Fresh Lab', 'مختبر جديد'),
      ],
      topics: [
        _topic(
          id: 'cybersecurity',
          categoryId: 'fresh-lab',
          nameEn: 'Cybersecurity',
          nameAr: 'الأمن السيبراني',
          questions: [_question('cybersecurity_question_001')],
        ),
      ],
    );
    final importer = TopicContentImporter(db);
    final first = await importer.importJson(raw);
    expect(first.topicsAdded, 1);
    expect(first.categoriesAdded, 1);

    final store = ImportedContentStore(db);
    await store.markTopicSeen('cybersecurity');
    await store.markCategorySeen('fresh-lab');

    final second = await importer.importJson(raw);
    expect(second.topicsAdded, 0);
    expect(second.topicsUpdated, 1);
    expect(second.categoriesAdded, 0);
    expect(second.categoriesUpdated, 1);
    expect(await db.select(db.topics).get(), hasLength(1));
    expect(await db.select(db.topicGroups).get(), hasLength(1));

    final marks = await store.read();
    expect(marks.topicIds, isEmpty);
    expect(marks.categoryIds, isEmpty);
  });

  test('a rolled-back import does not leave a new mark', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await expectLater(
      TopicContentImporter(db).importJson(
        _file(
          categories: [
            _category('fresh-lab', 'Fresh Lab', 'مختبر جديد'),
          ],
          topics: [
            _topic(
              id: 'cybersecurity',
              categoryId: 'fresh-lab',
              nameEn: 'Cybersecurity',
              nameAr: 'الأمن السيبراني',
            ),
          ],
        ),
        abortBeforeCommit: true,
      ),
      throwsA(isA<TopicContentException>()),
    );
    expect(await db.select(db.topics).get(), isEmpty);
    expect((await ImportedContentStore(db).read()).topicIds, isEmpty);
    expect((await ImportedContentStore(db).read()).categoryIds, isEmpty);
  });
}

Future<void> _seedTopic(
  AppDatabase db, {
  required String groupId,
  required String groupEn,
  required String groupAr,
  required String topicId,
  required String topicEn,
  required String topicAr,
}) async {
  await db.into(db.topicGroups).insert(
        TopicGroupsCompanion.insert(
          id: groupId,
          nameEn: groupEn,
          nameAr: groupAr,
        ),
      );
  await db.into(db.topics).insert(
        TopicsCompanion.insert(
          id: topicId,
          slug: topicId,
          groupId: groupId,
          nameEn: topicEn,
          nameAr: topicAr,
          descriptionEn: 'Applications and interviews.',
          descriptionAr: 'طلبات التوظيف والمقابلات.',
          iconKey: 'work',
        ),
      );
}

String _file({
  List<Map<String, Object>> categories = const [],
  required List<Map<String, Object>> topics,
}) {
  return jsonEncode({
    'schemaVersion': 1,
    'categories': categories,
    'topics': topics,
  });
}

Map<String, Object> _category(String id, String en, String ar) {
  return {
    'id': id,
    'name': {'en': en, 'ar': ar},
  };
}

Map<String, Object> _topic({
  required String id,
  required String categoryId,
  required String nameEn,
  required String nameAr,
  List<Map<String, Object>> questions = const [],
}) {
  return {
    'id': id,
    'categoryId': categoryId,
    'name': {'en': nameEn, 'ar': nameAr},
    'questions': questions,
  };
}

Map<String, Object> _question(String id) {
  return {
    'id': id,
    'type': 'conversation',
    'question': {'en': 'Why this role?', 'ar': 'لماذا هذه الوظيفة؟'},
    'answer': {'en': 'I like the work.', 'ar': 'أحب هذا العمل.'},
    'cefr': 'B1',
  };
}
