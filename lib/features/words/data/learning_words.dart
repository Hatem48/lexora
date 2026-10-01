import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';

class LearningWordItem {
  const LearningWordItem({
    required this.id,
    required this.fromCatalog,
    required this.word,
    required this.arabicMeaning,
    required this.cefr,
    required this.pos,
    required this.status,
    required this.needsCompletion,
    required this.isFavorite,
  });

  final String id;
  final bool fromCatalog;
  final String word;
  final String arabicMeaning;
  final String cefr;
  final String pos;
  final String status;
  final bool needsCompletion;
  final bool isFavorite;
}

class LearningWordQuery {
  const LearningWordQuery({
    this.search = '',
    this.cefr,
    this.categoryId,
    this.needsCompletionOnly = false,
    this.favoritesOnly = false,
  });

  final String search;
  final String? cefr;
  final String? categoryId;
  final bool needsCompletionOnly;
  final bool favoritesOnly;

  @override
  bool operator ==(Object other) =>
      other is LearningWordQuery &&
      other.search == search &&
      other.cefr == cefr &&
      other.categoryId == categoryId &&
      other.needsCompletionOnly == needsCompletionOnly &&
      other.favoritesOnly == favoritesOnly;

  @override
  int get hashCode => Object.hash(
        search,
        cefr,
        categoryId,
        needsCompletionOnly,
        favoritesOnly,
      );
}

final learningWordsProvider = StreamProvider.autoDispose
    .family<List<LearningWordItem>, LearningWordQuery>((ref, query) {
  final db = ref.watch(appDatabaseProvider);
  return watchLearningWords(db, query);
});

final needsCompletionCountProvider = StreamProvider.autoDispose<int>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db
      .customSelect(
        '''
        SELECT COUNT(*) AS c
        FROM user_vocabulary u
        JOIN vocabulary_entries e ON e.id = u.entry_id
        WHERE COALESCE(u.user_arabic_meaning, '') = ''
          AND COALESCE(e.arabic_meaning, '') = ''
        ''',
        readsFrom: {db.userVocabulary, db.vocabularyEntries},
      )
      .watch()
      .map((rows) => rows.single.read<int>('c'));
});

Stream<List<LearningWordItem>> watchLearningWords(
  AppDatabase db,
  LearningWordQuery query,
) {
  final whereCatalog = <String>[];
  final wherePersonal = <String>["lower(w.word) NOT IN (SELECT lower(e2.lemma) FROM user_vocabulary u2 JOIN vocabulary_entries e2 ON e2.id = u2.entry_id)"];
  final variables = <Variable>[];
  final personalVariables = <Variable>[];

  if (query.cefr != null) {
    whereCatalog.add('e.cefr_level = ?');
    wherePersonal.add('w.cefr_level = ?');
    variables.add(Variable<String>(query.cefr!));
  }
  if (query.search.trim().isNotEmpty) {
    final term = '%${query.search.trim()}%';
    whereCatalog.add('(e.lemma LIKE ? OR COALESCE(u.user_arabic_meaning, e.arabic_meaning) LIKE ?)');
    wherePersonal.add('(w.word LIKE ? OR w.arabic_meaning LIKE ?)');
    variables.add(Variable<String>(term));
    variables.add(Variable<String>(term));
  }
  if (query.needsCompletionOnly) {
    whereCatalog.add(
      "COALESCE(u.user_arabic_meaning, '') = '' AND COALESCE(e.arabic_meaning, '') = ''",
    );
    wherePersonal.add('0 = 1');
  }
  if (query.favoritesOnly) {
    whereCatalog.add('0 = 1');
    wherePersonal.add('w.is_favorite = 1');
  }
  if (query.categoryId != null) {
    whereCatalog.add('0 = 1');
    wherePersonal.add(
      'w.id IN (SELECT word_id FROM word_categories WHERE category_id = ?)',
    );
  }

  final catalogWhere = whereCatalog.isEmpty ? '' : 'WHERE ${whereCatalog.join(' AND ')}';
  final personalWhere = 'WHERE ${wherePersonal.join(' AND ')}';
  if (query.cefr != null) {
    personalVariables.add(Variable<String>(query.cefr!));
  }
  if (query.search.trim().isNotEmpty) {
    final term = '%${query.search.trim()}%';
    personalVariables.add(Variable<String>(term));
    personalVariables.add(Variable<String>(term));
  }
  if (query.categoryId != null) {
    personalVariables.add(Variable<String>(query.categoryId!));
  }

  return db
      .customSelect(
        '''
        SELECT * FROM (
          SELECT e.id AS id, 1 AS from_catalog, e.lemma AS word,
            COALESCE(NULLIF(u.user_arabic_meaning, ''), e.arabic_meaning) AS arabic,
            e.cefr_level AS cefr, e.part_of_speech AS pos, u.status AS status,
            CASE
              WHEN COALESCE(u.user_arabic_meaning, '') = '' AND COALESCE(e.arabic_meaning, '') = '' THEN 1
              ELSE 0
            END AS needs,
            0 AS favorite,
            u.first_discovered_at AS sort_at
          FROM user_vocabulary u
          JOIN vocabulary_entries e ON e.id = u.entry_id
          $catalogWhere
          UNION ALL
          SELECT w.id, 0, w.word, w.arabic_meaning, w.cefr_level, w.part_of_speech,
            w.mastery_status, 0, CASE WHEN w.is_favorite THEN 1 ELSE 0 END, w.created_at
          FROM words w
          $personalWhere
        )
        ORDER BY sort_at DESC
        ''',
        variables: [...variables, ...personalVariables],
        readsFrom: {db.userVocabulary, db.vocabularyEntries, db.words},
      )
      .watch()
      .map(
        (rows) => [
          for (final row in rows)
            LearningWordItem(
              id: row.read<String>('id'),
              fromCatalog: row.read<int>('from_catalog') == 1,
              word: row.read<String>('word'),
              arabicMeaning: row.read<String>('arabic'),
              cefr: row.read<String>('cefr'),
              pos: row.read<String>('pos'),
              status: row.read<String>('status'),
              needsCompletion: row.read<int>('needs') == 1,
              isFavorite: row.read<int>('favorite') == 1,
            ),
        ],
      );
}
