import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../constants/enums.dart';
import '../database/app_database.dart';

/// Development preview seed. Bump [seedVersion] to refresh demo content.
class DemoDataSeeder {
  DemoDataSeeder(this._db);

  final AppDatabase _db;
  final _uuid = const Uuid();

  static const seedVersion = '3';
  static const _versionKey = 'demo_seed_version';

  Future<void> seedIfNeeded() async {
    final existingVersion = await (_db.select(_db.appStatistics)
          ..where((t) => t.key.equals(_versionKey)))
        .getSingleOrNull();

    if (existingVersion?.value == seedVersion) return;

    await _clearLearningData();
    final now = DateTime.now();
    final categories = await _insertCategories(now);
    final words = await _insertWords(now, categories);
    await _insertSentences(now, categories, words);
    await _insertPatterns(now, categories);

    await _db.into(_db.appStatistics).insertOnConflictUpdate(
          AppStatisticsCompanion.insert(
            key: _versionKey,
            value: seedVersion,
            updatedAt: now,
          ),
        );
  }

  Future<void> _clearLearningData() async {
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
  }

  Future<Map<String, String>> _insertCategories(DateTime now) async {
    const defs = [
      ('daily_life', 'Daily Life', 'الحياة اليومية', 'home'),
      ('work', 'Work', 'العمل', 'work'),
      ('education', 'Education', 'التعليم', 'school'),
      ('travel', 'Travel', 'السفر', 'flight'),
      ('emotions', 'Emotions', 'المشاعر', 'favorite'),
      ('food', 'Food', 'الطعام', 'restaurant'),
      ('health', 'Health', 'الصحة', 'health'),
      ('technology', 'Technology', 'التكنولوجيا', 'devices'),
    ];

    final map = <String, String>{};
    var order = 0;
    for (final d in defs) {
      final id = _uuid.v4();
      map[d.$1] = id;
      await _db.into(_db.categories).insert(
            CategoriesCompanion.insert(
              id: id,
              name: d.$2,
              nameAr: Value(d.$3),
              iconName: Value(d.$4),
              sortOrder: Value(order++),
              isSystem: const Value(true),
              createdAt: now,
              updatedAt: now,
            ),
          );
    }
    return map;
  }

  Future<Map<String, String>> _insertWords(
    DateTime now,
    Map<String, String> categories,
  ) async {
    final items = <({
      String word,
      String ar,
      String cefr,
      String pos,
      String cat,
      String? phonetic,
      String? example,
      String? exampleAr,
    })>[
      (word: 'hello', ar: 'مرحبا', cefr: 'A1', pos: 'interjection', cat: 'daily_life', phonetic: '/həˈləʊ/', example: 'Hello, how are you?', exampleAr: 'مرحبا، كيف حالك؟'),
      (word: 'family', ar: 'عائلة', cefr: 'A1', pos: 'noun', cat: 'daily_life', phonetic: '/ˈfæm.əl.i/', example: 'My family is big.', exampleAr: 'عائلتي كبيرة.'),
      (word: 'water', ar: 'ماء', cefr: 'A1', pos: 'noun', cat: 'food', phonetic: '/ˈwɔː.tər/', example: 'I drink water every day.', exampleAr: 'أشرب الماء كل يوم.'),
      (word: 'happy', ar: 'سعيد', cefr: 'A1', pos: 'adjective', cat: 'emotions', phonetic: '/ˈhæp.i/', example: 'I am happy today.', exampleAr: 'أنا سعيد اليوم.'),
      (word: 'school', ar: 'مدرسة', cefr: 'A1', pos: 'noun', cat: 'education', phonetic: '/skuːl/', example: 'I go to school.', exampleAr: 'أذهب إلى المدرسة.'),
      (word: 'eat', ar: 'يأكل', cefr: 'A1', pos: 'verb', cat: 'food', phonetic: '/iːt/', example: 'We eat breakfast at 8.', exampleAr: 'نتناول الإفطار الساعة 8.'),
      (word: 'improve', ar: 'يُحسّن', cefr: 'A2', pos: 'verb', cat: 'education', phonetic: '/ɪmˈpruːv/', example: 'I want to improve my English.', exampleAr: 'أريد تحسين إنجليزيتي.'),
      (word: 'travel', ar: 'يسافر', cefr: 'A2', pos: 'verb', cat: 'travel', phonetic: '/ˈtræv.əl/', example: 'I love to travel.', exampleAr: 'أحب السفر.'),
      (word: 'healthy', ar: 'صحي', cefr: 'A2', pos: 'adjective', cat: 'health', phonetic: '/ˈhel.θi/', example: 'Eating vegetables is healthy.', exampleAr: 'أكل الخضروات صحي.'),
      (word: 'weather', ar: 'الطقس', cefr: 'A2', pos: 'noun', cat: 'daily_life', phonetic: '/ˈweð.ər/', example: 'The weather is nice today.', exampleAr: 'الطقس جميل اليوم.'),
      (word: 'invite', ar: 'يدعو', cefr: 'A2', pos: 'verb', cat: 'emotions', phonetic: '/ɪnˈvaɪt/', example: "I'd love to invite you.", exampleAr: 'أود أن أدعوك.'),
      (word: 'airport', ar: 'مطار', cefr: 'A2', pos: 'noun', cat: 'travel', phonetic: '/ˈeə.pɔːt/', example: 'We arrive at the airport early.', exampleAr: 'نصل إلى المطار مبكراً.'),
      (word: 'opportunity', ar: 'فرصة', cefr: 'B1', pos: 'noun', cat: 'work', phonetic: '/ˌɒp.əˈtjuː.nə.ti/', example: 'This is a great opportunity to improve.', exampleAr: 'هذه فرصة رائعة للتحسين.'),
      (word: 'achieve', ar: 'يحقق', cefr: 'B1', pos: 'verb', cat: 'education', phonetic: '/əˈtʃiːv/', example: 'She worked hard to achieve her goals.', exampleAr: 'عملت بجد لتحقيق أهدافها.'),
      (word: 'situation', ar: 'موقف / وضع', cefr: 'B1', pos: 'noun', cat: 'daily_life', phonetic: '/ˌsɪtʃ.uˈeɪ.ʃən/', example: 'It depends on the situation.', exampleAr: 'يعتمد ذلك على الموقف.'),
      (word: 'experience', ar: 'خبرة / تجربة', cefr: 'B1', pos: 'noun', cat: 'work', phonetic: '/ɪkˈspɪə.ri.əns/', example: 'I have experience in teaching.', exampleAr: 'لدي خبرة في التدريس.'),
      (word: 'decide', ar: 'يقرر', cefr: 'B1', pos: 'verb', cat: 'daily_life', phonetic: '/dɪˈsaɪd/', example: 'We need to decide soon.', exampleAr: 'نحتاج أن نقرر قريباً.'),
      (word: 'suggest', ar: 'يقترح', cefr: 'B1', pos: 'verb', cat: 'work', phonetic: '/səˈdʒest/', example: 'Can you suggest a solution?', exampleAr: 'هل يمكنك اقتراح حل؟'),
      (word: 'confidence', ar: 'ثقة', cefr: 'B2', pos: 'noun', cat: 'emotions', phonetic: '/ˈkɒn.fɪ.dəns/', example: 'Speaking daily builds confidence.', exampleAr: 'التحدث يومياً يبني الثقة.'),
      (word: 'reliable', ar: 'موثوق', cefr: 'B2', pos: 'adjective', cat: 'work', phonetic: '/rɪˈlaɪ.ə.bəl/', example: 'He is a reliable teammate.', exampleAr: 'إنه زميل موثوق.'),
      (word: 'efficient', ar: 'فعّال', cefr: 'B2', pos: 'adjective', cat: 'work', phonetic: '/ɪˈfɪʃ.ənt/', example: 'We need a more efficient process.', exampleAr: 'نحتاج عملية أكثر فعالية.'),
      (word: 'persuade', ar: 'يقنع', cefr: 'B2', pos: 'verb', cat: 'emotions', phonetic: '/pəˈsweɪd/', example: 'She persuaded me to join.', exampleAr: 'أقنعتني بالانضمام.'),
      (word: 'significant', ar: 'مهم / كبير', cefr: 'B2', pos: 'adjective', cat: 'education', phonetic: '/sɪɡˈnɪf.ɪ.kənt/', example: 'There was a significant improvement.', exampleAr: 'كان هناك تحسن كبير.'),
      (word: 'negotiate', ar: 'يتفاوض', cefr: 'B2', pos: 'verb', cat: 'work', phonetic: '/nɪˈɡəʊ.ʃi.eɪt/', example: 'We negotiate the contract tomorrow.', exampleAr: 'نتفاوض على العقد غداً.'),
      (word: 'articulate', ar: 'يُعبّر بوضوح', cefr: 'C1', pos: 'verb', cat: 'education', phonetic: '/ɑːˈtɪk.jə.leɪt/', example: 'She articulated her ideas clearly.', exampleAr: 'عبّرت عن أفكارها بوضوح.'),
      (word: 'nuance', ar: 'فارق دقيق', cefr: 'C1', pos: 'noun', cat: 'education', phonetic: '/ˈnjuː.ɑːns/', example: 'Language learning requires nuance.', exampleAr: 'تعلّم اللغة يتطلب دقة في الفروقات.'),
      (word: 'resilient', ar: 'مرن / صامد', cefr: 'C1', pos: 'adjective', cat: 'emotions', phonetic: '/rɪˈzɪl.i.ənt/', example: 'Resilient learners keep going.', exampleAr: 'المتعلمون الصامدون يستمرون.'),
      (word: 'comprehensive', ar: 'شامل', cefr: 'C1', pos: 'adjective', cat: 'education', phonetic: '/ˌkɒm.prɪˈhen.sɪv/', example: 'We need a comprehensive plan.', exampleAr: 'نحتاج خطة شاملة.'),
      (word: 'hypothesis', ar: 'فرضية', cefr: 'C1', pos: 'noun', cat: 'education', phonetic: '/haɪˈpɒθ.ə.sɪs/', example: 'Test your hypothesis carefully.', exampleAr: 'اختبر فرضيتك بعناية.'),
      (word: 'substantiate', ar: 'يُثبت / يدعم', cefr: 'C1', pos: 'verb', cat: 'work', phonetic: '/səbˈstæn.ʃi.eɪt/', example: 'Can you substantiate that claim?', exampleAr: 'هل يمكنك دعم هذا الادعاء؟'),
      (word: 'ubiquitous', ar: 'في كل مكان', cefr: 'C2', pos: 'adjective', cat: 'technology', phonetic: '/juːˈbɪk.wɪ.təs/', example: 'Smartphones are ubiquitous today.', exampleAr: 'الهواتف الذكية منتشرة في كل مكان اليوم.'),
      (word: 'ephemeral', ar: 'عابر / زائل', cefr: 'C2', pos: 'adjective', cat: 'emotions', phonetic: '/ɪˈfem.ər.əl/', example: 'Fame can be ephemeral.', exampleAr: 'الشهرة قد تكون عابرة.'),
      (word: 'juxtapose', ar: 'يضع جنباً إلى جنب', cefr: 'C2', pos: 'verb', cat: 'education', phonetic: '/ˌdʒʌk.stəˈpəʊz/', example: 'The essay juxtaposes two ideas.', exampleAr: 'المقال يضع فكرتين جنباً إلى جنب.'),
      (word: 'idiosyncrasy', ar: 'خصوصية / ميزة فردية', cefr: 'C2', pos: 'noun', cat: 'daily_life', phonetic: '/ˌɪd.i.əˈsɪŋ.kr.kr.ə.si/', example: 'Every language has idiosyncrasies.', exampleAr: 'لكل لغة خصوصياتها.'),
      (word: 'equivocal', ar: 'غامض / ملتبس', cefr: 'C2', pos: 'adjective', cat: 'work', phonetic: '/ɪˈkwɪv.ə.kəl/', example: 'His answer was equivocal.', exampleAr: 'كانت إجابته ملتبسة.'),
      (word: 'ameliorate', ar: 'يُحسّن / يخفف', cefr: 'C2', pos: 'verb', cat: 'health', phonetic: '/əˈmiː.li.ə.reɪt/', example: 'Policies can ameliorate the problem.', exampleAr: 'يمكن للسياسات أن تخفف المشكلة.'),
    ];

    final map = <String, String>{};
    for (final item in items) {
      final id = _uuid.v4();
      map[item.word] = id;
      final mastery = switch (item.cefr) {
        'A1' || 'A2' => MasteryStatus.mastered.storageValue,
        'B1' => MasteryStatus.reviewing.storageValue,
        _ => MasteryStatus.learning.storageValue,
      };
      await _db.into(_db.words).insert(
            WordsCompanion.insert(
              id: id,
              word: item.word,
              arabicMeaning: item.ar,
              cefrLevel: item.cefr,
              partOfSpeech: item.pos,
              phonetic: Value(item.phonetic),
              exampleSentence: Value(item.example),
              exampleTranslation: Value(item.exampleAr),
              masteryStatus: Value(mastery),
              reviewCount: Value(item.cefr == 'B1' ? 4 : 1),
              createdAt: now,
              updatedAt: now,
            ),
          );
      final catId = categories[item.cat];
      if (catId != null) {
        await _db.into(_db.wordCategories).insert(
              WordCategoriesCompanion.insert(
                wordId: id,
                categoryId: catId,
              ),
            );
      }
      await _db.into(_db.reviewItems).insert(
            ReviewItemsCompanion.insert(
              id: _uuid.v4(),
              itemType: ReviewItemType.word.storageValue,
              itemId: id,
              nextReviewAt: now.subtract(Duration(hours: item.cefr == 'B1' ? 2 : 8)),
              createdAt: now,
              updatedAt: now,
            ),
          );
    }
    return map;
  }

  Future<void> _insertSentences(
    DateTime now,
    Map<String, String> categories,
    Map<String, String> words,
  ) async {
    final items = <({
      String en,
      String ar,
      String cefr,
      String cat,
      List<String> related,
    })>[
      (en: 'Hello, how are you?', ar: 'مرحبا، كيف حالك؟', cefr: 'A1', cat: 'daily_life', related: const ['hello']),
      (en: 'My family is big.', ar: 'عائلتي كبيرة.', cefr: 'A1', cat: 'daily_life', related: const ['family']),
      (en: 'I drink water every day.', ar: 'أشرب الماء كل يوم.', cefr: 'A1', cat: 'food', related: const ['water']),
      (en: "I'd love to get to know you better.", ar: 'أود أن أتعرف عليك بشكل أفضل.', cefr: 'A2', cat: 'emotions', related: const []),
      (en: 'I want to improve my English.', ar: 'أريد تحسين إنجليزيتي.', cefr: 'A2', cat: 'education', related: const ['improve']),
      (en: 'The weather is nice today.', ar: 'الطقس جميل اليوم.', cefr: 'A2', cat: 'daily_life', related: const ['weather']),
      (en: 'It depends on the situation.', ar: 'يعتمد ذلك على الموقف.', cefr: 'B1', cat: 'daily_life', related: const ['situation']),
      (en: 'This is a great opportunity to improve.', ar: 'هذه فرصة رائعة للتحسين.', cefr: 'B1', cat: 'work', related: const ['opportunity', 'improve']),
      (en: "I'm looking forward to our meeting.", ar: 'أتطلع إلى اجتماعنا.', cefr: 'B1', cat: 'work', related: const []),
      (en: 'Speaking daily builds confidence.', ar: 'التحدث يومياً يبني الثقة.', cefr: 'B2', cat: 'emotions', related: const ['confidence']),
      (en: 'He is a reliable teammate.', ar: 'إنه زميل موثوق.', cefr: 'B2', cat: 'work', related: const ['reliable']),
      (en: 'We need a more efficient process.', ar: 'نحتاج عملية أكثر فعالية.', cefr: 'B2', cat: 'work', related: const ['efficient']),
      (en: 'She articulated her ideas clearly.', ar: 'عبّرت عن أفكارها بوضوح.', cefr: 'C1', cat: 'education', related: const ['articulate']),
      (en: 'We need a comprehensive plan.', ar: 'نحتاج خطة شاملة.', cefr: 'C1', cat: 'education', related: const ['comprehensive']),
      (en: 'Resilient learners keep going.', ar: 'المتعلمون الصامدون يستمرون.', cefr: 'C1', cat: 'emotions', related: const ['resilient']),
      (en: 'Smartphones are ubiquitous today.', ar: 'الهواتف الذكية منتشرة في كل مكان اليوم.', cefr: 'C2', cat: 'technology', related: const ['ubiquitous']),
      (en: 'His answer was equivocal.', ar: 'كانت إجابته ملتبسة.', cefr: 'C2', cat: 'work', related: const ['equivocal']),
      (en: 'Every language has idiosyncrasies.', ar: 'لكل لغة خصوصياتها.', cefr: 'C2', cat: 'daily_life', related: const ['idiosyncrasy']),
    ];

    for (final item in items) {
      final id = _uuid.v4();
      await _db.into(_db.sentences).insert(
            SentencesCompanion.insert(
              id: id,
              sentence: item.en,
              arabicTranslation: item.ar,
              cefrLevel: item.cefr,
              masteryStatus: Value(
                item.cefr == 'A1' || item.cefr == 'A2'
                    ? MasteryStatus.mastered.storageValue
                    : MasteryStatus.learning.storageValue,
              ),
              createdAt: now,
              updatedAt: now,
            ),
          );
      final catId = categories[item.cat];
      if (catId != null) {
        await _db.into(_db.sentenceCategories).insert(
              SentenceCategoriesCompanion.insert(
                sentenceId: id,
                categoryId: catId,
              ),
            );
      }
      for (final w in item.related) {
        final wordId = words[w];
        if (wordId != null) {
          await _db.into(_db.sentenceWords).insert(
                SentenceWordsCompanion.insert(
                  sentenceId: id,
                  wordId: wordId,
                ),
              );
        }
      }
      await _db.into(_db.reviewItems).insert(
            ReviewItemsCompanion.insert(
              id: _uuid.v4(),
              itemType: ReviewItemType.sentence.storageValue,
              itemId: id,
              nextReviewAt: now.subtract(const Duration(hours: 1)),
              createdAt: now,
              updatedAt: now,
            ),
          );
    }
  }

  Future<void> _insertPatterns(
    DateTime now,
    Map<String, String> categories,
  ) async {
    final items = <({String pattern, String ar, String cefr, String cat})>[
      (pattern: "I'd love to + verb", ar: 'أود أن + فعل', cefr: 'A2', cat: 'emotions'),
      (pattern: "I'm looking forward to + noun / verb-ing", ar: 'أتطلع إلى + اسم / فعل-ing', cefr: 'B1', cat: 'work'),
      (pattern: 'It depends on + noun', ar: 'يعتمد على + اسم', cefr: 'B1', cat: 'daily_life'),
      (pattern: 'Not only … but also …', ar: 'ليس فقط … بل أيضاً …', cefr: 'B2', cat: 'education'),
      (pattern: 'Were it not for + noun', ar: 'لولا + اسم', cefr: 'C1', cat: 'education'),
      (pattern: 'Suffice it to say that …', ar: 'يكفي القول إن …', cefr: 'C2', cat: 'work'),
    ];

    for (final item in items) {
      final id = _uuid.v4();
      await _db.into(_db.sentencePatterns).insert(
            SentencePatternsCompanion.insert(
              id: id,
              pattern: item.pattern,
              arabicExplanation: item.ar,
              cefrLevel: item.cefr,
              createdAt: now,
              updatedAt: now,
            ),
          );
      final catId = categories[item.cat];
      if (catId != null) {
        await _db.into(_db.patternCategories).insert(
              PatternCategoriesCompanion.insert(
                patternId: id,
                categoryId: catId,
              ),
            );
      }
    }
  }
}
