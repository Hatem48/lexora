import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import 'topic_detection_engine.dart';

class DetectedTopic {
  const DetectedTopic({
    required this.topicId,
    required this.nameEn,
    required this.nameAr,
    required this.score,
  });

  final String topicId;
  final String nameEn;
  final String nameAr;
  final int score;
}

enum TopicWordFilter {
  all,
  locked,
  discovered,
  learning,
  reviewing,
  mastered,
}

class TopicCardData {
  const TopicCardData({
    required this.id,
    required this.groupId,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.iconKey,
    required this.sortOrder,
    required this.wordCount,
    required this.sentenceCount,
    required this.unlocked,
    required this.mastered,
  });

  final String id;
  final String groupId;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String iconKey;
  final int sortOrder;
  final int wordCount;
  final int sentenceCount;
  final int unlocked;
  final int mastered;

  int get locked => wordCount - unlocked;

  double get progress => wordCount == 0 ? 0 : unlocked / wordCount;
}

class TopicGroupDataView {
  const TopicGroupDataView({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.sortOrder,
  });

  final String id;
  final String nameEn;
  final String nameAr;
  final int sortOrder;
}

class LearningPathView {
  const LearningPathView({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.topicIds,
  });

  final String id;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final List<String> topicIds;
}

class TopicWordView {
  const TopicWordView({
    required this.entryId,
    required this.lemma,
    required this.cefr,
    required this.arabicMeaning,
    required this.relevance,
    required this.weight,
    required this.status,
  });

  final String entryId;
  final String lemma;
  final String cefr;
  final String arabicMeaning;
  final String relevance;
  final int weight;
  final String? status;

  bool get locked => status == null;
}

class TopicSentenceView {
  const TopicSentenceView({
    required this.id,
    required this.sentenceEn,
    required this.sentenceAr,
    required this.cefr,
  });

  final String id;
  final String sentenceEn;
  final String sentenceAr;
  final String cefr;
}

class TopicLevelCount {
  const TopicLevelCount({
    required this.level,
    required this.total,
    required this.unlocked,
  });

  final String level;
  final int total;
  final int unlocked;
}

class TopicProgressView {
  const TopicProgressView({
    required this.total,
    required this.locked,
    required this.discovered,
    required this.learning,
    required this.reviewing,
    required this.mastered,
    required this.discoveredThisWeek,
    required this.levels,
  });

  final int total;
  final int locked;
  final int discovered;
  final int learning;
  final int reviewing;
  final int mastered;
  final int discoveredThisWeek;
  final List<TopicLevelCount> levels;

  int get unlocked => total - locked;

  double get progress => total == 0 ? 0 : unlocked / total;
}

class TopicRepository {
  TopicRepository(this._db);

  final AppDatabase _db;

  Future<List<TopicGroupDataView>> groups() async {
    final rows = await (_db.select(_db.topicGroups)
          ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]))
        .get();
    return [
      for (final row in rows)
        TopicGroupDataView(
          id: row.id,
          nameEn: row.nameEn,
          nameAr: row.nameAr,
          sortOrder: row.sortOrder,
        ),
    ];
  }

  Future<List<TopicCardData>> cards() async {
    final wordRows = await _db.customSelect(
      '''
      SELECT
        t.id AS id,
        t.group_id AS group_id,
        t.name_en AS name_en,
        t.name_ar AS name_ar,
        t.description_en AS description_en,
        t.description_ar AS description_ar,
        t.icon_key AS icon_key,
        t.sort_order AS sort_order,
        COUNT(DISTINCT vt.entry_id) AS word_count,
        COUNT(DISTINCT CASE WHEN u.entry_id IS NOT NULL THEN vt.entry_id END) AS unlocked,
        COUNT(DISTINCT CASE WHEN u.status = 'mastered' THEN vt.entry_id END) AS mastered
      FROM topics t
      LEFT JOIN vocabulary_topics vt ON vt.topic_id = t.id
      LEFT JOIN user_vocabulary u ON u.entry_id = vt.entry_id
      WHERE t.enabled = 1
      GROUP BY t.id
      ORDER BY t.sort_order
      ''',
      readsFrom: {_db.topics, _db.vocabularyTopics, _db.userVocabulary},
    ).get();
    final sentenceRows = await _db.customSelect(
      '''
      SELECT lst.topic_id AS id, COUNT(DISTINCT s.id) AS c
      FROM topic_sentence_topics lst
      JOIN topic_sentences s ON s.id = lst.sentence_id AND s.enabled = 1
      GROUP BY lst.topic_id
      ''',
      readsFrom: {_db.topicSentenceTopics, _db.topicSentences},
    ).get();
    final sentences = {
      for (final row in sentenceRows) row.read<String>('id'): row.read<int>('c'),
    };
    return [
      for (final row in wordRows)
        TopicCardData(
          id: row.read<String>('id'),
          groupId: row.read<String>('group_id'),
          nameEn: row.read<String>('name_en'),
          nameAr: row.read<String>('name_ar'),
          descriptionEn: row.read<String>('description_en'),
          descriptionAr: row.read<String>('description_ar'),
          iconKey: row.read<String>('icon_key'),
          sortOrder: row.read<int>('sort_order'),
          wordCount: row.read<int>('word_count'),
          sentenceCount: sentences[row.read<String>('id')] ?? 0,
          unlocked: row.read<int>('unlocked'),
          mastered: row.read<int>('mastered'),
        ),
    ];
  }

  Future<List<LearningPathView>> paths() async {
    final pathRows = await (_db.select(_db.learningPaths)
          ..where((row) => row.enabled.equals(true))
          ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]))
        .get();
    final links = await (_db.select(_db.learningPathTopics)
          ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]))
        .get();
    return [
      for (final path in pathRows)
        LearningPathView(
          id: path.id,
          nameEn: path.nameEn,
          nameAr: path.nameAr,
          descriptionEn: path.descriptionEn,
          descriptionAr: path.descriptionAr,
          topicIds: [
            for (final link in links)
              if (link.pathId == path.id) link.topicId,
          ],
        ),
    ];
  }

  Future<TopicRow?> topic(String id) {
    return (_db.select(_db.topics)..where((row) => row.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<TopicWordView>> words({
    required String topicId,
    String? cefr,
    TopicWordFilter filter = TopicWordFilter.all,
  }) async {
    final cefrSql = cefr == null ? '' : ' AND e.cefr_level = ?';
    final filterSql = switch (filter) {
      TopicWordFilter.all => '',
      TopicWordFilter.locked => ' AND u.entry_id IS NULL',
      TopicWordFilter.discovered => " AND u.status = 'discovered'",
      TopicWordFilter.learning => " AND u.status = 'learning'",
      TopicWordFilter.reviewing => " AND u.status = 'reviewing'",
      TopicWordFilter.mastered => " AND u.status = 'mastered'",
    };
    final variables = <Variable>[
      Variable<String>(topicId),
      if (cefr != null) Variable<String>(cefr),
    ];
    final rows = await _db.customSelect(
      '''
      SELECT
        e.id AS id,
        e.lemma AS lemma,
        e.cefr_level AS cefr,
        e.arabic_meaning AS arabic,
        vt.relevance AS relevance,
        vt.weight AS weight,
        u.status AS status
      FROM vocabulary_topics vt
      JOIN vocabulary_entries e ON e.id = vt.entry_id
      LEFT JOIN vocabulary_entry_ranks r ON r.entry_id = e.id
      LEFT JOIN user_vocabulary u ON u.entry_id = e.id
      WHERE vt.topic_id = ?$cefrSql$filterSql
      ORDER BY vt.weight DESC,
        CASE WHEN r.frequency_rank IS NULL THEN 1 ELSE 0 END,
        r.frequency_rank,
        e.cefr_level,
        e.lemma
      ''',
      variables: variables,
      readsFrom: {
        _db.vocabularyTopics,
        _db.vocabularyEntries,
        _db.vocabularyEntryRanks,
        _db.userVocabulary,
      },
    ).get();
    return [
      for (final row in rows)
        TopicWordView(
          entryId: row.read<String>('id'),
          lemma: row.read<String>('lemma'),
          cefr: row.read<String>('cefr'),
          arabicMeaning: row.read<String>('arabic'),
          relevance: row.read<String>('relevance'),
          weight: row.read<int>('weight'),
          status: row.readNullable<String>('status'),
        ),
    ];
  }

  Future<List<TopicSentenceView>> sentences({
    required String topicId,
    String? cefr,
  }) async {
    final cefrSql = cefr == null ? '' : ' AND s.cefr_level = ?';
    final rows = await _db.customSelect(
      '''
      SELECT s.id AS id, s.sentence_en AS en, s.sentence_ar AS ar, s.cefr_level AS cefr
      FROM topic_sentence_topics lst
      JOIN topic_sentences s ON s.id = lst.sentence_id
      WHERE lst.topic_id = ? AND s.enabled = 1$cefrSql
      ORDER BY s.sort_order, s.cefr_level
      ''',
      variables: [
        Variable<String>(topicId),
        if (cefr != null) Variable<String>(cefr),
      ],
      readsFrom: {_db.topicSentenceTopics, _db.topicSentences},
    ).get();
    return [
      for (final row in rows)
        TopicSentenceView(
          id: row.read<String>('id'),
          sentenceEn: row.read<String>('en'),
          sentenceAr: row.read<String>('ar'),
          cefr: row.read<String>('cefr'),
        ),
    ];
  }

  Future<TopicProgressView> progress(String topicId) async {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final rows = await _db.customSelect(
      '''
      SELECT
        e.cefr_level AS level,
        COUNT(*) AS total,
        SUM(CASE WHEN u.entry_id IS NOT NULL THEN 1 ELSE 0 END) AS unlocked,
        SUM(CASE WHEN u.status = 'discovered' THEN 1 ELSE 0 END) AS discovered,
        SUM(CASE WHEN u.status = 'learning' THEN 1 ELSE 0 END) AS learning,
        SUM(CASE WHEN u.status = 'reviewing' THEN 1 ELSE 0 END) AS reviewing,
        SUM(CASE WHEN u.status = 'mastered' THEN 1 ELSE 0 END) AS mastered,
        SUM(CASE WHEN u.first_discovered_at >= ? THEN 1 ELSE 0 END) AS week
      FROM vocabulary_topics vt
      JOIN vocabulary_entries e ON e.id = vt.entry_id
      LEFT JOIN user_vocabulary u ON u.entry_id = vt.entry_id
      WHERE vt.topic_id = ?
      GROUP BY e.cefr_level
      ''',
      variables: [Variable<DateTime>(weekAgo), Variable<String>(topicId)],
      readsFrom: {
        _db.vocabularyTopics,
        _db.vocabularyEntries,
        _db.userVocabulary,
      },
    ).get();

    var total = 0;
    var unlocked = 0;
    var discovered = 0;
    var learning = 0;
    var reviewing = 0;
    var mastered = 0;
    var week = 0;
    final levels = <TopicLevelCount>[];
    for (final row in rows) {
      final levelTotal = row.read<int>('total');
      final levelUnlocked = row.read<int>('unlocked');
      total += levelTotal;
      unlocked += levelUnlocked;
      discovered += row.read<int>('discovered');
      learning += row.read<int>('learning');
      reviewing += row.read<int>('reviewing');
      mastered += row.read<int>('mastered');
      week += row.read<int>('week');
      levels.add(
        TopicLevelCount(
          level: row.read<String>('level'),
          total: levelTotal,
          unlocked: levelUnlocked,
        ),
      );
    }
    const order = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
    levels.sort(
      (a, b) => order.indexOf(a.level).compareTo(order.indexOf(b.level)),
    );
    return TopicProgressView(
      total: total,
      locked: total - unlocked,
      discovered: discovered,
      learning: learning,
      reviewing: reviewing,
      mastered: mastered,
      discoveredThisWeek: week,
      levels: levels,
    );
  }

  Future<List<DetectedTopic>> topicsForEntry(String entryId) async {
    final rows = await _db.customSelect(
      '''
      SELECT t.id AS id, t.name_en AS name_en, t.name_ar AS name_ar, vt.weight AS weight
      FROM vocabulary_topics vt
      JOIN topics t ON t.id = vt.topic_id
      WHERE vt.entry_id = ?
      ORDER BY vt.weight DESC, t.sort_order
      ''',
      variables: [Variable<String>(entryId)],
      readsFrom: {_db.vocabularyTopics, _db.topics},
    ).get();
    return [
      for (final row in rows)
        DetectedTopic(
          topicId: row.read<String>('id'),
          nameEn: row.read<String>('name_en'),
          nameAr: row.read<String>('name_ar'),
          score: row.read<int>('weight'),
        ),
    ];
  }

  Future<List<DetectedTopic>> detectEntryIds(Iterable<String> entryIds) async {
    final ids = entryIds.toSet().toList();
    if (ids.isEmpty) return const [];
    final rows = await (_db.select(_db.vocabularyTopics)
          ..where((row) => row.entryId.isIn(ids)))
        .get();
    final signals = TopicDetectionEngine.detect([
      for (final row in rows)
        TopicTermLink(
          topicId: row.topicId,
          entryId: row.entryId,
          weight: row.weight,
        ),
    ]);
    if (signals.isEmpty) return const [];
    final topics = await (_db.select(_db.topics)
          ..where((row) => row.id.isIn(signals.map((signal) => signal.topicId))))
        .get();
    final byId = {for (final topic in topics) topic.id: topic};
    return [
      for (final signal in signals)
        if (byId[signal.topicId] != null)
          DetectedTopic(
            topicId: signal.topicId,
            nameEn: byId[signal.topicId]!.nameEn,
            nameAr: byId[signal.topicId]!.nameAr,
            score: signal.score,
          ),
    ];
  }

  Future<Map<String, List<DetectedTopic>>> labelsByBlog() async {
    final rows = await _db.customSelect(
      '''
      SELECT
        bv.blog_id AS blog_id,
        vt.topic_id AS topic_id,
        vt.entry_id AS entry_id,
        vt.weight AS weight,
        t.name_en AS name_en,
        t.name_ar AS name_ar
      FROM blog_vocabulary bv
      JOIN vocabulary_topics vt ON vt.entry_id = bv.entry_id
      JOIN topics t ON t.id = vt.topic_id
      ''',
      readsFrom: {_db.blogVocabulary, _db.vocabularyTopics, _db.topics},
    ).get();
    final grouped = <String, List<TopicTermLink>>{};
    final names = <String, ({String en, String ar})>{};
    for (final row in rows) {
      final topicId = row.read<String>('topic_id');
      names[topicId] = (
        en: row.read<String>('name_en'),
        ar: row.read<String>('name_ar'),
      );
      grouped.putIfAbsent(row.read<String>('blog_id'), () => []).add(
            TopicTermLink(
              topicId: topicId,
              entryId: row.read<String>('entry_id'),
              weight: row.read<int>('weight'),
            ),
          );
    }
    return {
      for (final entry in grouped.entries)
        entry.key: [
          for (final signal in TopicDetectionEngine.detect(entry.value))
            if (names[signal.topicId] != null)
              DetectedTopic(
                topicId: signal.topicId,
                nameEn: names[signal.topicId]!.en,
                nameAr: names[signal.topicId]!.ar,
                score: signal.score,
              ),
        ],
    };
  }
}
