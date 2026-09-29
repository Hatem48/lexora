import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column;

import '../../../core/constants/enums.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/settings_provider.dart';
import '../domain/dashboard_stats.dart';

final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  final settings = ref.watch(settingsProvider);
  final now = DateTime.now();
  final endOfDay = DateTime(now.year, now.month, now.day).add(const Duration(days: 1));

  final wordGroups = await _grouped(db, 'words');
  final sentenceGroups = await _grouped(db, 'sentences');

  final wordsCount = _total(wordGroups);
  final sentencesCount = _total(sentenceGroups);
  final mastered = _statusCount(wordGroups, MasteryStatus.mastered.storageValue) +
      _statusCount(sentenceGroups, MasteryStatus.mastered.storageValue);

  final dueRows = await db.customSelect(
    '''
    SELECT item_type AS type, COUNT(*) AS c
    FROM review_items
    WHERE next_review_at < ?
    GROUP BY item_type
    ''',
    variables: [Variable<DateTime>(endOfDay)],
    readsFrom: {db.reviewItems},
  ).get();

  var dueWords = 0;
  var dueSentences = 0;
  var dueToday = 0;
  for (final row in dueRows) {
    final count = row.read<int>('c');
    dueToday += count;
    if (row.read<String>('type') == ReviewItemType.word.storageValue) {
      dueWords = count;
    } else if (row.read<String>('type') == ReviewItemType.sentence.storageValue) {
      dueSentences = count;
    }
  }

  final cefrProgress = <CefrLevel, double>{};
  for (final level in CefrLevel.values) {
    final total = _levelCount(wordGroups, level.code);
    if (total == 0) {
      cefrProgress[level] = 0;
      continue;
    }
    final progressed = _levelStatus(
          wordGroups,
          level.code,
          MasteryStatus.mastered.storageValue,
        ) +
        _levelStatus(
          wordGroups,
          level.code,
          MasteryStatus.reviewing.storageValue,
        );
    cefrProgress[level] = progressed / total;
  }

  final current = settings.cefrLevel;
  final currentTotal = _levelCount(wordGroups, current.code);
  final currentStarted = currentTotal -
      _levelStatus(wordGroups, current.code, MasteryStatus.newItem.storageValue);
  final levelProgress =
      currentTotal == 0 ? 0.0 : currentStarted / currentTotal;

  final patternCount = await _scalar(
    db,
    'SELECT COUNT(*) AS c FROM sentence_patterns',
    readsFrom: {db.sentencePatterns},
  );
  final withoutPractice = await _scalar(
    db,
    'SELECT COUNT(*) AS c FROM sentences WHERE has_pronunciation_practice = 0',
    readsFrom: {db.sentences},
  );

  final recommendations = <DashboardRecommendation>[
    if (_levelCount(wordGroups, current.code) < 50)
      const DashboardRecommendation(
        titleKey: 'moreB1Vocabulary',
        subtitleKey: 'needMoreWords',
        icon: 'book',
      ),
    if (patternCount < 10)
      const DashboardRecommendation(
        titleKey: 'sentencePatterns',
        subtitleKey: 'addMorePatterns',
        icon: 'pattern',
      ),
    if (withoutPractice > 0)
      DashboardRecommendation(
        titleKey: 'speakingPractice',
        subtitleKey: 'sentencesWithoutPractice',
        count: withoutPractice,
        icon: 'mic',
      ),
  ];

  return DashboardStats(
    wordsCount: wordsCount,
    sentencesCount: sentencesCount,
    masteredCount: mastered,
    dueTodayCount: dueToday,
    dueWords: dueWords,
    dueSentences: dueSentences,
    currentLevel: current,
    levelProgress: levelProgress.clamp(0.0, 1.0),
    cefrProgress: cefrProgress,
    recommendations: recommendations,
  );
});

Future<List<QueryRow>> _grouped(AppDatabase db, String table) {
  return db.customSelect(
    '''
    SELECT cefr_level AS level, mastery_status AS status, COUNT(*) AS c
    FROM $table
    GROUP BY cefr_level, mastery_status
    ''',
    readsFrom: {table == 'words' ? db.words : db.sentences},
  ).get();
}

Future<int> _scalar(
  AppDatabase db,
  String sql, {
  required Set<ResultSetImplementation> readsFrom,
}) async {
  final row = await db.customSelect(sql, readsFrom: readsFrom).getSingle();
  return row.read<int>('c');
}

int _total(List<QueryRow> rows) =>
    rows.fold<int>(0, (sum, row) => sum + row.read<int>('c'));

int _statusCount(List<QueryRow> rows, String status) => rows
    .where((row) => row.read<String>('status') == status)
    .fold<int>(0, (sum, row) => sum + row.read<int>('c'));

int _levelCount(List<QueryRow> rows, String level) => rows
    .where((row) => row.read<String>('level') == level)
    .fold<int>(0, (sum, row) => sum + row.read<int>('c'));

int _levelStatus(List<QueryRow> rows, String level, String status) => rows
    .where(
      (row) =>
          row.read<String>('level') == level &&
          row.read<String>('status') == status,
    )
    .fold<int>(0, (sum, row) => sum + row.read<int>('c'));
