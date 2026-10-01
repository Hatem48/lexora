import 'dart:convert';

import 'package:drift/drift.dart';

import '../../database/app_database.dart';

/// A few original practice rows so the new flows can be tested.
/// They are marked as development samples and are not a production course.
class DevelopmentSampleSeeder {
  DevelopmentSampleSeeder(this._db);

  final AppDatabase _db;

  static const presentPerfectId = 'dev-present-perfect';

  Future<void> seedIfMissing() async {
    await _seedGrammar();
    await _seedRestaurantQuestions();
  }

  Future<void> _seedGrammar() async {
    final existing = await (_db.select(_db.grammarTopics)
          ..where((row) => row.id.equals(presentPerfectId)))
        .getSingleOrNull();
    if (existing != null) return;

    await _db.into(_db.grammarTopics).insert(
          GrammarTopicsCompanion.insert(
            id: presentPerfectId,
            category: 'tense',
            titleEn: 'Present Perfect',
            titleAr: 'المضارع التام',
            cefrLevel: const Value('B1'),
            classificationNote:
                'Development sample. This CEFR label is for practice inside Lexora and is not an official grammar profile.',
            isDevelopmentSample: const Value(true),
          ),
        );
    await _db.into(_db.grammarLessons).insert(
          GrammarLessonsCompanion.insert(
            id: '$presentPerfectId-lesson',
            topicId: presentPerfectId,
            useEn:
                'Use it for a past action that still matters now.',
            useAr: 'نستخدمه لحدث وقع في الماضي وما زال له أثر الآن.',
            structure: 'Subject + have/has + past participle',
            positiveExample: 'I have finished my work.',
            negativeExample: "I haven't finished my work.",
            questionExample: 'Have you finished your work?',
            mistakeWrong: 'I have went there.',
            mistakeRight: 'I have gone there.',
          ),
        );
    await _db.into(_db.grammarExercises).insert(
          GrammarExercisesCompanion.insert(
            id: '$presentPerfectId-choice',
            lessonId: '$presentPerfectId-lesson',
            kind: 'multiple_choice',
            prompt: 'She ___ to university every day.',
            choicesJson: Value(jsonEncode(['go', 'goes', 'went'])),
            answer: 'goes',
            explanationEn: 'Every day needs the present simple, not the present perfect.',
            explanationAr: 'كل يوم يحتاج المضارع البسيط، لا المضارع التام.',
          ),
        );
    await _db.into(_db.grammarExercises).insert(
          GrammarExercisesCompanion.insert(
            id: '$presentPerfectId-blank',
            lessonId: '$presentPerfectId-lesson',
            kind: 'fill_blank',
            prompt: 'I have ___ my work.',
            answer: 'finished',
            explanationEn: 'The present perfect uses the past participle.',
            explanationAr: 'المضارع التام يستخدم التصريف الثالث.',
            sortOrder: const Value(1),
          ),
        );
    await _db.into(_db.grammarExercises).insert(
          GrammarExercisesCompanion.insert(
            id: '$presentPerfectId-advanced',
            lessonId: '$presentPerfectId-lesson',
            kind: 'correct_mistake',
            prompt: 'I have went there.',
            answer: 'I have gone there.',
            explanationEn: 'Go is irregular: gone, not went, after have.',
            explanationAr: 'الفعل go شاذ: بعد have نستخدم gone وليس went.',
            sortOrder: const Value(2),
            isAdvanced: const Value(true),
          ),
        );
  }

  Future<void> _seedRestaurantQuestions() async {
    final topic = await (_db.select(_db.topics)
          ..where((row) => row.id.equals('restaurant')))
        .getSingleOrNull();
    if (topic == null) return;
    final existing = await (_db.select(_db.topicQuestions)
          ..where((row) => row.topicId.equals('restaurant')))
        .get();
    if (existing.isNotEmpty) return;

    const questions = <({String id, String level, String en, String ar, String sample, int order})>[
      (
        id: 'dev-restaurant-a1',
        level: 'A1',
        en: 'What food do you like?',
        ar: 'ما الطعام الذي تحبه؟',
        sample: 'I like rice and salad.',
        order: 1,
      ),
      (
        id: 'dev-restaurant-a2',
        level: 'A2',
        en: 'How often do you eat at restaurants?',
        ar: 'كم مرة تأكل في المطاعم؟',
        sample: 'I eat at a restaurant once a week.',
        order: 2,
      ),
      (
        id: 'dev-restaurant-b1',
        level: 'B1',
        en: 'Describe a restaurant you like.',
        ar: 'صف مطعمًا تحبه.',
        sample: 'I like a small restaurant near my house because the food is fresh.',
        order: 3,
      ),
      (
        id: 'dev-restaurant-b2',
        level: 'B2',
        en: 'What makes a restaurant successful?',
        ar: 'ما الذي يجعل المطعم ناجحًا؟',
        sample: 'Good service, fair prices, and consistent food make a restaurant successful.',
        order: 4,
      ),
      (
        id: 'dev-restaurant-c1',
        level: 'C1',
        en: 'How has technology changed the restaurant industry?',
        ar: 'كيف غيّرت التقنية قطاع المطاعم؟',
        sample: 'Online orders and delivery apps have changed how restaurants reach customers.',
        order: 5,
      ),
      (
        id: 'dev-restaurant-c2',
        level: 'C2',
        en: 'Discuss how globalization can influence traditional cuisine.',
        ar: 'ناقش كيف يمكن للعولمة أن تؤثر في المطبخ التقليدي.',
        sample: 'Globalization can spread recipes, but it can also pressure traditional kitchens to change.',
        order: 6,
      ),
    ];

    for (final question in questions) {
      await _db.into(_db.topicQuestions).insert(
            TopicQuestionsCompanion.insert(
              id: question.id,
              topicId: 'restaurant',
              cefrLevel: question.level,
              promptEn: question.en,
              promptAr: question.ar,
              suggestedAnswer: question.sample,
              sortOrder: Value(question.order),
              isDevelopmentSample: const Value(true),
            ),
          );
    }
  }
}
