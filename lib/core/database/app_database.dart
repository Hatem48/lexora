import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tables/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Categories,
    Words,
    Sentences,
    SentencePatterns,
    WordCategories,
    SentenceCategories,
    PatternCategories,
    SentenceWords,
    ReviewItems,
    ReviewHistory,
    PronunciationCache,
    LearningSessions,
    UserPreferences,
    AppStatistics,
    VocabularyEntries,
    VocabularyForms,
    UserVocabulary,
    BlogEntries,
    BlogVocabulary,
    VocabularyEntryRanks,
    TopicGroups,
    Topics,
    VocabularyTopics,
    TopicSentences,
    TopicSentenceTopics,
    LearningPaths,
    LearningPathTopics,
    GrammarTopics,
    GrammarLessons,
    GrammarExercises,
    UserGrammarProgress,
    TopicQuestions,
    UserTopicAnswers,
    UserAchievements,
    LearningDays,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'lexora'));

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_words_cefr ON words(cefr_level)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_words_mastery ON words(mastery_status)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_words_word ON words(word COLLATE NOCASE)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_sentences_cefr ON sentences(cefr_level)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_sentences_sentence ON sentences(sentence COLLATE NOCASE)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_review_next ON review_items(next_review_at)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_review_type_item ON review_items(item_type, item_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_vocab_cefr ON vocabulary_entries(cefr_level)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_vocab_lemma ON vocabulary_entries(lemma)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_user_vocab_discovered ON user_vocabulary(first_discovered_at)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_vocab_topics_topic ON vocabulary_topics(topic_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_sentence_topics_topic ON topic_sentence_topics(topic_id)',
          );
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.createTable(vocabularyEntries);
            await m.createTable(vocabularyForms);
            await m.createTable(userVocabulary);
            await m.createTable(blogEntries);
            await m.createTable(blogVocabulary);
            await customStatement(
              'CREATE INDEX IF NOT EXISTS idx_vocab_cefr ON vocabulary_entries(cefr_level)',
            );
            await customStatement(
              'CREATE INDEX IF NOT EXISTS idx_user_vocab_discovered ON user_vocabulary(first_discovered_at)',
            );
          }
          if (from < 3) {
            await m.createTable(vocabularyEntryRanks);
            await m.createTable(topicGroups);
            await m.createTable(topics);
            await m.createTable(vocabularyTopics);
            await m.createTable(topicSentences);
            await m.createTable(topicSentenceTopics);
            await m.createTable(learningPaths);
            await m.createTable(learningPathTopics);
            await customStatement(
              'CREATE INDEX IF NOT EXISTS idx_vocab_topics_topic ON vocabulary_topics(topic_id)',
            );
            await customStatement(
              'CREATE INDEX IF NOT EXISTS idx_sentence_topics_topic ON topic_sentence_topics(topic_id)',
            );
          }
          if (from >= 3 && from < 4) {
            await m.addColumn(
              vocabularyEntryRanks,
              vocabularyEntryRanks.academicRank,
            );
          }
          if (from >= 2 && from < 5) {
            await m.addColumn(userVocabulary, userVocabulary.userArabicMeaning);
            await m.addColumn(userVocabulary, userVocabulary.userExample);
            await m.addColumn(
              userVocabulary,
              userVocabulary.userExampleTranslation,
            );
            await m.addColumn(userVocabulary, userVocabulary.userNotes);
          }
          if (from < 5) {
            await m.createTable(grammarTopics);
            await m.createTable(grammarLessons);
            await m.createTable(grammarExercises);
            await m.createTable(userGrammarProgress);
            await m.createTable(topicQuestions);
            await m.createTable(userTopicAnswers);
            await m.createTable(userAchievements);
            await m.createTable(learningDays);
            final lemmaTable = await customSelect(
              "SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'vocabulary_entries'",
            ).get();
            if (lemmaTable.isNotEmpty) {
              await customStatement(
                'CREATE INDEX IF NOT EXISTS idx_vocab_lemma ON vocabulary_entries(lemma)',
              );
            }
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
