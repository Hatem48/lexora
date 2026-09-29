import 'package:drift/drift.dart';

@DataClassName('CategoryRow')
class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get nameAr => text().nullable()();
  TextColumn get iconName => text().withDefault(const Constant('folder'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WordRow')
class Words extends Table {
  TextColumn get id => text()();
  TextColumn get word => text()();
  TextColumn get arabicMeaning => text()();
  TextColumn get cefrLevel => text()();
  TextColumn get partOfSpeech => text()();
  TextColumn get phonetic => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get exampleSentence => text().nullable()();
  TextColumn get exampleTranslation => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get inReviewSystem =>
      boolean().withDefault(const Constant(true))();
  TextColumn get masteryStatus =>
      text().withDefault(const Constant('new'))();
  IntColumn get reviewCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastReviewedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {word},
      ];
}

@DataClassName('SentenceRow')
class Sentences extends Table {
  TextColumn get id => text()();
  TextColumn get sentence => text()();
  TextColumn get arabicTranslation => text()();
  TextColumn get cefrLevel => text()();
  TextColumn get notes => text().nullable()();
  TextColumn get patternId => text().nullable().references(SentencePatterns, #id)();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get inReviewSystem =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get reminderEnabled =>
      boolean().withDefault(const Constant(false))();
  TextColumn get masteryStatus =>
      text().withDefault(const Constant('new'))();
  IntColumn get reviewCount => integer().withDefault(const Constant(0))();
  BoolColumn get hasPronunciationPractice =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastReviewedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SentencePatternRow')
class SentencePatterns extends Table {
  TextColumn get id => text()();
  TextColumn get pattern => text()();
  TextColumn get arabicExplanation => text()();
  TextColumn get cefrLevel => text()();
  TextColumn get grammarNotes => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get inReviewSystem =>
      boolean().withDefault(const Constant(true))();
  TextColumn get masteryStatus =>
      text().withDefault(const Constant('new'))();
  IntColumn get reviewCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastReviewedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WordCategoryRow')
class WordCategories extends Table {
  TextColumn get wordId => text().references(Words, #id)();
  TextColumn get categoryId => text().references(Categories, #id)();

  @override
  Set<Column> get primaryKey => {wordId, categoryId};
}

@DataClassName('SentenceCategoryRow')
class SentenceCategories extends Table {
  TextColumn get sentenceId => text().references(Sentences, #id)();
  TextColumn get categoryId => text().references(Categories, #id)();

  @override
  Set<Column> get primaryKey => {sentenceId, categoryId};
}

@DataClassName('PatternCategoryRow')
class PatternCategories extends Table {
  TextColumn get patternId => text().references(SentencePatterns, #id)();
  TextColumn get categoryId => text().references(Categories, #id)();

  @override
  Set<Column> get primaryKey => {patternId, categoryId};
}

@DataClassName('SentenceWordRow')
class SentenceWords extends Table {
  TextColumn get sentenceId => text().references(Sentences, #id)();
  TextColumn get wordId => text().references(Words, #id)();

  @override
  Set<Column> get primaryKey => {sentenceId, wordId};
}

@DataClassName('ReviewItemRow')
class ReviewItems extends Table {
  TextColumn get id => text()();
  TextColumn get itemType => text()();
  TextColumn get itemId => text()();
  RealColumn get easeFactor => real().withDefault(const Constant(2.5))();
  IntColumn get intervalDays => integer().withDefault(const Constant(0))();
  IntColumn get repetitions => integer().withDefault(const Constant(0))();
  DateTimeColumn get nextReviewAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {itemType, itemId},
      ];
}

@DataClassName('ReviewHistoryRow')
class ReviewHistory extends Table {
  TextColumn get id => text()();
  TextColumn get reviewItemId => text().references(ReviewItems, #id)();
  TextColumn get itemType => text()();
  TextColumn get itemId => text()();
  IntColumn get rating => integer()();
  IntColumn get previousInterval => integer()();
  IntColumn get newInterval => integer()();
  DateTimeColumn get reviewedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PronunciationCacheRow')
class PronunciationCache extends Table {
  TextColumn get id => text()();
  TextColumn get contentHash => text()();
  TextColumn get textContent => text()();
  TextColumn get accent => text()();
  RealColumn get speed => real()();
  TextColumn get filePath => text()();
  TextColumn get provider => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {contentHash, accent, speed, provider},
      ];
}

@DataClassName('LearningSessionRow')
class LearningSessions extends Table {
  TextColumn get id => text()();
  TextColumn get sessionType => text()();
  IntColumn get reviewedCount => integer().withDefault(const Constant(0))();
  IntColumn get correctCount => integer().withDefault(const Constant(0))();
  IntColumn get incorrectCount => integer().withDefault(const Constant(0))();
  IntColumn get skippedCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('UserPreferenceRow')
class UserPreferences extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}

@DataClassName('VocabularyEntryRow')
class VocabularyEntries extends Table {
  TextColumn get id => text()();
  TextColumn get lemma => text()();
  TextColumn get cefrLevel => text()();
  TextColumn get partOfSpeech => text()();
  TextColumn get definitionEn => text()();
  TextColumn get arabicMeaning => text()();
  TextColumn get exampleSentence => text()();
  TextColumn get phonetic => text().nullable()();
  BoolColumn get academic => boolean().withDefault(const Constant(false))();
  BoolColumn get ieltsRelevant =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get toeflRelevant =>
      boolean().withDefault(const Constant(false))();
  IntColumn get catalogVersion => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Optional catalog ranks. Kept apart from [VocabularyEntries] so a catalog
/// reimport cannot wipe values that arrive with a later dataset.
@DataClassName('VocabularyEntryRankRow')
class VocabularyEntryRanks extends Table {
  TextColumn get entryId => text().references(VocabularyEntries, #id)();
  IntColumn get frequencyRank => integer().nullable()();
  IntColumn get generalImportance => integer().nullable()();
  IntColumn get spokenRelevance => integer().nullable()();
  IntColumn get newsRelevance => integer().nullable()();
  IntColumn get academicRank => integer().nullable()();

  @override
  Set<Column> get primaryKey => {entryId};
}

@DataClassName('VocabularyFormRow')
class VocabularyForms extends Table {
  TextColumn get surface => text()();
  TextColumn get entryId => text().references(VocabularyEntries, #id)();

  @override
  Set<Column> get primaryKey => {surface};
}

@DataClassName('UserVocabularyRow')
class UserVocabulary extends Table {
  TextColumn get entryId => text().references(VocabularyEntries, #id)();
  TextColumn get status =>
      text().withDefault(const Constant('discovered'))();
  DateTimeColumn get firstDiscoveredAt => dateTime()();
  TextColumn get discoveredIn => text()();
  TextColumn get sourceId => text().nullable()();
  IntColumn get usageCount => integer().withDefault(const Constant(1))();
  DateTimeColumn get lastUsedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {entryId};
}

@DataClassName('BlogEntryRow')
class BlogEntries extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  IntColumn get wordCount => integer().withDefault(const Constant(0))();
  IntColumn get uniqueClassified => integer().withDefault(const Constant(0))();
  IntColumn get newDiscoveries => integer().withDefault(const Constant(0))();
  TextColumn get cefrDistributionJson =>
      text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('BlogVocabularyRow')
class BlogVocabulary extends Table {
  TextColumn get blogId => text().references(BlogEntries, #id)();
  TextColumn get entryId => text().references(VocabularyEntries, #id)();
  IntColumn get occurrences => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {blogId, entryId};
}

@DataClassName('TopicGroupRow')
class TopicGroups extends Table {
  TextColumn get id => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameAr => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TopicRow')
class Topics extends Table {
  TextColumn get id => text()();
  TextColumn get slug => text()();
  TextColumn get groupId => text().references(TopicGroups, #id)();
  TextColumn get nameEn => text()();
  TextColumn get nameAr => text()();
  TextColumn get descriptionEn => text()();
  TextColumn get descriptionAr => text()();
  TextColumn get iconKey => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('VocabularyTopicRow')
class VocabularyTopics extends Table {
  TextColumn get entryId => text().references(VocabularyEntries, #id)();
  TextColumn get topicId => text().references(Topics, #id)();
  TextColumn get relevance => text()();
  IntColumn get weight => integer()();

  @override
  Set<Column> get primaryKey => {entryId, topicId};
}

@DataClassName('TopicSentenceRow')
class TopicSentences extends Table {
  TextColumn get id => text()();
  TextColumn get sentenceEn => text()();
  TextColumn get sentenceAr => text()();
  TextColumn get cefrLevel => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TopicSentenceTopicRow')
class TopicSentenceTopics extends Table {
  TextColumn get sentenceId => text().references(TopicSentences, #id)();
  TextColumn get topicId => text().references(Topics, #id)();

  @override
  Set<Column> get primaryKey => {sentenceId, topicId};
}

@DataClassName('LearningPathRow')
class LearningPaths extends Table {
  TextColumn get id => text()();
  TextColumn get slug => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameAr => text()();
  TextColumn get descriptionEn => text()();
  TextColumn get descriptionAr => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LearningPathTopicRow')
class LearningPathTopics extends Table {
  TextColumn get pathId => text().references(LearningPaths, #id)();
  TextColumn get topicId => text().references(Topics, #id)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {pathId, topicId};
}

@DataClassName('AppStatisticRow')
class AppStatistics extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}
