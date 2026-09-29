enum CefrLevel {
  a1('A1', 'Beginner'),
  a2('A2', 'Elementary'),
  b1('B1', 'Intermediate'),
  b2('B2', 'Upper Intermediate'),
  c1('C1', 'Advanced'),
  c2('C2', 'Proficiency');

  const CefrLevel(this.code, this.labelEn);
  final String code;
  final String labelEn;

  static CefrLevel fromCode(String code) {
    return CefrLevel.values.firstWhere(
      (e) => e.code == code.toUpperCase(),
      orElse: () => CefrLevel.b1,
    );
  }

  CefrLevel? get next {
    final i = index;
    if (i >= CefrLevel.values.length - 1) return null;
    return CefrLevel.values[i + 1];
  }
}

enum PartOfSpeech {
  noun,
  verb,
  adjective,
  adverb,
  pronoun,
  preposition,
  conjunction,
  interjection,
  phrase,
  other;

  String get storageValue => name;
}

enum MasteryStatus {
  newItem('new'),
  learning('learning'),
  reviewing('reviewing'),
  mastered('mastered');

  const MasteryStatus(this.storageValue);
  final String storageValue;

  static MasteryStatus fromStorage(String value) {
    return MasteryStatus.values.firstWhere(
      (e) => e.storageValue == value,
      orElse: () => MasteryStatus.newItem,
    );
  }
}

enum VocabularyStatus {
  discovered('discovered'),
  learning('learning'),
  reviewing('reviewing'),
  mastered('mastered');

  const VocabularyStatus(this.storageValue);
  final String storageValue;

  static VocabularyStatus fromStorage(String value) {
    return VocabularyStatus.values.firstWhere(
      (e) => e.storageValue == value,
      orElse: () => VocabularyStatus.discovered,
    );
  }
}

enum TopicRelevance {
  primary('primary', 4),
  high('high', 3),
  medium('medium', 2),
  low('low', 1);

  const TopicRelevance(this.storageValue, this.weight);
  final String storageValue;
  final int weight;

  static TopicRelevance fromStorage(String value) {
    return TopicRelevance.values.firstWhere(
      (item) => item.storageValue == value,
      orElse: () => TopicRelevance.medium,
    );
  }
}

enum ReviewItemType {
  word,
  sentence,
  pattern;

  String get storageValue => name;
}

enum ReviewRating {
  forgot(0),
  difficult(1),
  good(2),
  easy(3);

  const ReviewRating(this.value);
  final int value;
}

enum PronunciationAccent {
  american('american'),
  british('british');

  const PronunciationAccent(this.storageValue);
  final String storageValue;
}

enum PlaybackSpeed {
  normal(0.95),
  slow(0.7);

  const PlaybackSpeed(this.rate);
  final double rate;
}

enum AppThemeMode {
  system,
  light,
  dark;

  String get storageValue => name;
}

enum ReminderType {
  words,
  sentences,
  mixed,
  dueReviews;

  String get storageValue => name;
}

enum ContentSort {
  recentlyAdded,
  alphabetical,
  cefr,
  mostReviewed,
  leastReviewed,
  mastery,
}
