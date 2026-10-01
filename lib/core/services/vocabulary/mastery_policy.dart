import '../../constants/enums.dart';

/// How a catalog word moves between learning states.
///
/// Discovery never marks a word mastered. Mastery follows the spaced
/// repetition result: four successful repetitions and an interval of at
/// least 21 days, which [ReviewEngine] already reports as
/// [MasteryStatus.mastered].
class MasteryPolicy {
  const MasteryPolicy();

  static const successfulReviewsForMastery = 4;
  static const minimumMasteryIntervalDays = 21;

  String statusAfterReview(MasteryStatus reviewStatus) {
    return switch (reviewStatus) {
      MasteryStatus.mastered => VocabularyStatus.mastered.storageValue,
      MasteryStatus.reviewing => VocabularyStatus.reviewing.storageValue,
      MasteryStatus.learning ||
      MasteryStatus.newItem =>
        VocabularyStatus.learning.storageValue,
    };
  }

  String statusAfterCompletion({required bool hasMeaning}) {
    return hasMeaning
        ? VocabularyStatus.learning.storageValue
        : VocabularyStatus.discovered.storageValue;
  }
}
