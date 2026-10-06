class AchievementDefinition {
  const AchievementDefinition({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.detailEn,
    required this.detailAr,
  });

  final String id;
  final String titleEn;
  final String titleAr;
  final String detailEn;
  final String detailAr;
}

class AchievementCatalog {
  const AchievementCatalog();

  static const definitions = <AchievementDefinition>[
    AchievementDefinition(
      id: 'first-word',
      titleEn: 'First word',
      titleAr: 'أول كلمة',
      detailEn: 'You discovered your first catalog word.',
      detailAr: 'اكتشفت أول كلمة من الكتالوج.',
    ),
    AchievementDefinition(
      id: 'words-10',
      titleEn: '10 words',
      titleAr: '10 كلمات',
      detailEn: '10 catalog words discovered.',
      detailAr: 'اكتشفت 10 كلمات من الكتالوج.',
    ),
    AchievementDefinition(
      id: 'words-50',
      titleEn: '50 words',
      titleAr: '50 كلمة',
      detailEn: '50 catalog words discovered.',
      detailAr: 'اكتشفت 50 كلمة من الكتالوج.',
    ),
    AchievementDefinition(
      id: 'words-100',
      titleEn: '100 words',
      titleAr: '100 كلمة',
      detailEn: '100 catalog words discovered.',
      detailAr: 'اكتشفت 100 كلمة من الكتالوج.',
    ),
    AchievementDefinition(
      id: 'words-250',
      titleEn: '250 words',
      titleAr: '250 كلمة',
      detailEn: '250 catalog words discovered.',
      detailAr: 'اكتشفت 250 كلمة من الكتالوج.',
    ),
    AchievementDefinition(
      id: 'words-500',
      titleEn: '500 words',
      titleAr: '500 كلمة',
      detailEn: '500 catalog words discovered.',
      detailAr: 'اكتشفت 500 كلمة من الكتالوج.',
    ),
    AchievementDefinition(
      id: 'words-1000',
      titleEn: '1000 words',
      titleAr: '1000 كلمة',
      detailEn: '1000 catalog words discovered.',
      detailAr: 'اكتشفت 1000 كلمة من الكتالوج.',
    ),
    AchievementDefinition(
      id: 'mastered-10',
      titleEn: '10 mastered',
      titleAr: '10 متقنة',
      detailEn: 'You mastered 10 words.',
      detailAr: 'أتقنت 10 كلمات.',
    ),
    AchievementDefinition(
      id: 'mastered-100',
      titleEn: '100 mastered',
      titleAr: '100 متقنة',
      detailEn: 'You mastered 100 words.',
      detailAr: 'أتقنت 100 كلمة.',
    ),
    AchievementDefinition(
      id: 'streak-7',
      titleEn: '7 day streak',
      titleAr: 'سلسلة 7 أيام',
      detailEn: 'Seven days of real study.',
      detailAr: 'سبعة أيام من التعلم الفعلي.',
    ),
    AchievementDefinition(
      id: 'streak-30',
      titleEn: '30 day streak',
      titleAr: 'سلسلة 30 يومًا',
      detailEn: 'Thirty days of real study.',
      detailAr: 'ثلاثون يومًا من التعلم الفعلي.',
    ),
    AchievementDefinition(
      id: 'grammar-1',
      titleEn: 'First grammar lesson',
      titleAr: 'أول درس قواعد',
      detailEn: 'You finished a grammar lesson.',
      detailAr: 'أنهيت درس قواعد.',
    ),
    AchievementDefinition(
      id: 'grammar-10',
      titleEn: '10 grammar lessons',
      titleAr: '10 دروس قواعد',
      detailEn: 'You finished 10 grammar lessons.',
      detailAr: 'أنهيت 10 دروس قواعد.',
    ),
    AchievementDefinition(
      id: 'time-30m',
      titleEn: '30 minutes',
      titleAr: '30 دقيقة',
      detailEn: 'You have spent 30 minutes learning with Lexora.',
      detailAr: 'قضيت 30 دقيقة في التعلم مع Lexora.',
    ),
    AchievementDefinition(
      id: 'time-1h',
      titleEn: '1 hour',
      titleAr: 'ساعة',
      detailEn: 'You have spent 1 hour learning with Lexora.',
      detailAr: 'قضيت ساعة في التعلم مع Lexora.',
    ),
    AchievementDefinition(
      id: 'time-5h',
      titleEn: '5 hours',
      titleAr: '5 ساعات',
      detailEn: 'You have spent 5 hours learning with Lexora.',
      detailAr: 'قضيت 5 ساعات في التعلم مع Lexora.',
    ),
    AchievementDefinition(
      id: 'time-10h',
      titleEn: '10 hours',
      titleAr: '10 ساعات',
      detailEn: 'You have spent 10 hours learning with Lexora.',
      detailAr: 'قضيت 10 ساعات في التعلم مع Lexora.',
    ),
    AchievementDefinition(
      id: 'time-25h',
      titleEn: '25 hours',
      titleAr: '25 ساعة',
      detailEn: 'You have spent 25 hours learning with Lexora.',
      detailAr: 'قضيت 25 ساعة في التعلم مع Lexora.',
    ),
    AchievementDefinition(
      id: 'unlock-advanced-practice',
      titleEn: 'Advanced practice unlocked',
      titleAr: 'تم فتح تدريب متقدم',
      detailEn: 'Extra grammar practice is available. Word levels are unchanged.',
      detailAr: 'تدريب القواعد الإضافي أصبح متاحًا. مستويات الكلمات لم تتغير.',
    ),
  ];

  static AchievementDefinition? byId(String id) {
    for (final item in definitions) {
      if (item.id == id) return item;
    }
    if (id.startsWith('level-')) {
      final level = id.substring('level-'.length).toUpperCase();
      return AchievementDefinition(
        id: id,
        titleEn: '$level Vocabulary Masterpiece Completed',
        titleAr: 'اكتملت لوحة مفردات $level',
        detailEn:
            'You mastered every $level catalog word in Lexora. This is a collection milestone, not an official CEFR level.',
        detailAr:
            'أتقنت كل كلمات $level في كتالوج Lexora. هذا إنجاز مجموعة، وليس مستوى CEFR رسميًا.',
      );
    }
    return null;
  }

  static List<String> earnedIds({
    required int discovered,
    required int mastered,
    required int grammarCompleted,
    required int streak,
    required int activeSeconds,
    required Map<String, int> masteredByLevel,
    required Map<String, int> totalsByLevel,
  }) {
    final ids = <String>[];
    void add(String id, bool when) {
      if (when) ids.add(id);
    }

    add('first-word', discovered >= 1);
    add('words-10', discovered >= 10);
    add('words-50', discovered >= 50);
    add('words-100', discovered >= 100);
    add('words-250', discovered >= 250);
    add('words-500', discovered >= 500);
    add('words-1000', discovered >= 1000);
    add('mastered-10', mastered >= 10);
    add('mastered-100', mastered >= 100);
    add('streak-7', streak >= 7);
    add('streak-30', streak >= 30);
    add('grammar-1', grammarCompleted >= 1);
    add('grammar-10', grammarCompleted >= 10);
    add('time-30m', activeSeconds >= 30 * 60);
    add('time-1h', activeSeconds >= 60 * 60);
    add('time-5h', activeSeconds >= 5 * 60 * 60);
    add('time-10h', activeSeconds >= 10 * 60 * 60);
    add('time-25h', activeSeconds >= 25 * 60 * 60);
    add('unlock-advanced-practice', mastered >= 10);
    for (final level in totalsByLevel.keys) {
      final total = totalsByLevel[level] ?? 0;
      final done = masteredByLevel[level] ?? 0;
      add('level-${level.toLowerCase()}', total > 0 && done >= total);
    }
    return ids;
  }
}
