// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Lexora';

  @override
  String get appTagline => 'Learn English your way';

  @override
  String get developedBy => 'Developed by Hatem Husam';

  @override
  String get navHome => 'Home';

  @override
  String get navWords => 'Words';

  @override
  String get navAdd => 'Add';

  @override
  String get navSentences => 'Sentences';

  @override
  String get navProgress => 'Progress';

  @override
  String goodMorning(String name) {
    return 'Good morning, $name';
  }

  @override
  String goodAfternoon(String name) {
    return 'Good afternoon, $name';
  }

  @override
  String goodEvening(String name) {
    return 'Good evening, $name';
  }

  @override
  String keepGoingTo(String level) {
    return 'Keep going to $level';
  }

  @override
  String get words => 'Words';

  @override
  String get sentences => 'Sentences';

  @override
  String get mastered => 'Mastered';

  @override
  String get dueToday => 'Due today';

  @override
  String get yourCefrProgress => 'Your CEFR Progress';

  @override
  String get vocabularyJourney => 'Vocabulary journey';

  @override
  String masteredCountOfTotal(int mastered, int total) {
    return '$mastered / $total mastered';
  }

  @override
  String wordsRemainingCount(int count) {
    return '$count still to master';
  }

  @override
  String get remaining => 'Remaining';

  @override
  String masterpieceCompleted(String level) {
    return '$level masterpiece completed';
  }

  @override
  String get collectionNotOfficialLevel =>
      'This completes the vocabulary collection, not an official CEFR level.';

  @override
  String get artNotStarted => 'Not started';

  @override
  String get continueLearning => 'Continue Learning';

  @override
  String itemsNeedReview(int words, int sentences) {
    return '$words words + $sentences sentences need review';
  }

  @override
  String get startReview => 'Start Review';

  @override
  String get whatYouNeedToAdd => 'What You Need to Add';

  @override
  String get search => 'Search';

  @override
  String get all => 'All';

  @override
  String get addWord => 'Add Word';

  @override
  String get addSentence => 'Add Sentence';

  @override
  String get addPattern => 'Add Sentence Pattern';

  @override
  String get addWordDescription => 'Build your personal vocabulary';

  @override
  String get addSentenceDescription => 'Save useful phrases and examples';

  @override
  String get addPatternDescription => 'Master grammar structures';

  @override
  String get saveWord => 'Save Word';

  @override
  String get saveAndAddAnother => 'Save & Add Another';

  @override
  String get saveSentence => 'Save Sentence';

  @override
  String get word => 'Word';

  @override
  String get arabicMeaning => 'Arabic Meaning';

  @override
  String get cefrLevel => 'CEFR Level';

  @override
  String get partOfSpeech => 'Part of Speech';

  @override
  String get category => 'Category';

  @override
  String get exampleSentence => 'Example Sentence';

  @override
  String get arabicTranslation => 'Arabic Translation';

  @override
  String get notes => 'Notes';

  @override
  String get addToReviewSystem => 'Add to review system';

  @override
  String get requiredField => 'This field is required';

  @override
  String get wordAlreadyExists => 'This word already exists in your library';

  @override
  String get noWordsYet => 'No words yet';

  @override
  String get noWordsYetMessage => 'Start building your personal vocabulary.';

  @override
  String get addYourFirstWord => 'Add your first word';

  @override
  String get noSentencesYet => 'No sentences yet';

  @override
  String get noSentencesYetMessage => 'Save phrases you want to remember.';

  @override
  String get addYourFirstSentence => 'Add your first sentence';

  @override
  String get noReviewsToday => 'No reviews today';

  @override
  String get allCaughtUp => 'You\'re all caught up.';

  @override
  String get review => 'Review';

  @override
  String get tapToSeeTranslation => 'Tap to see translation';

  @override
  String get forgot => 'Forgot';

  @override
  String get difficult => 'Difficult';

  @override
  String get good => 'Good';

  @override
  String get easy => 'Easy';

  @override
  String get reviewComplete => 'Review Complete!';

  @override
  String get reviewed => 'Reviewed';

  @override
  String get correct => 'Correct';

  @override
  String get incorrect => 'Incorrect';

  @override
  String get skipped => 'Skipped';

  @override
  String get accuracy => 'Accuracy';

  @override
  String get reviewIncorrect => 'Review Incorrect';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get settings => 'Settings';

  @override
  String get account => 'Account';

  @override
  String get language => 'Language';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get pronunciation => 'Pronunciation';

  @override
  String get accent => 'Accent';

  @override
  String get american => 'American';

  @override
  String get british => 'British';

  @override
  String get playbackSpeed => 'Playback speed';

  @override
  String get learning => 'Learning';

  @override
  String get dailyGoal => 'Daily goal';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationCenter => 'Notifications';

  @override
  String get noNewNotifications => 'No new notifications';

  @override
  String get notificationsHelp =>
      'Review reminders and learning milestones will appear here.';

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get dueWordsNoticeTitle => 'Words ready for review';

  @override
  String dueWordsNotice(int count) {
    return '$count words are ready for review';
  }

  @override
  String get dueSentencesNoticeTitle => 'Sentences ready for review';

  @override
  String dueSentencesNotice(int count) {
    return '$count sentences are ready for review';
  }

  @override
  String get dailyLearningNoticeTitle => 'Daily learning';

  @override
  String get dailyLearningNotice => 'A short review keeps your English moving.';

  @override
  String get streakNoticeTitle => 'Streak reminder';

  @override
  String streakNotice(int count) {
    return 'Your $count-day streak is still open today';
  }

  @override
  String get data => 'Data';

  @override
  String get localStorageOnly => 'Local Storage Only';

  @override
  String get exportData => 'Export Data';

  @override
  String get importData => 'Import Data';

  @override
  String get backup => 'Backup';

  @override
  String get privacy => 'Privacy';

  @override
  String get about => 'About';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get signInTitle => 'Welcome to Lexora';

  @override
  String get signInSubtitle =>
      'Your personal English companion — offline-first, bilingual, and built around how you learn.';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get signIn => 'Sign in';

  @override
  String get invalidCredentials => 'Invalid username or password';

  @override
  String get createAccount => 'Create account';

  @override
  String get createAccountTitle => 'Create your account';

  @override
  String get createAccountSubtitle => 'Your account stays on this device.';

  @override
  String get alreadyHaveAccount => 'I already have an account';

  @override
  String get displayName => 'Name';

  @override
  String get email => 'Email';

  @override
  String get optional => 'Optional';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get passwordMismatch => 'The passwords do not match';

  @override
  String get usernameInvalid =>
      'Use 3 to 32 letters, numbers, dots, or underscores';

  @override
  String get passwordShort => 'Password must be at least 6 characters';

  @override
  String get accountExists =>
      'An account already exists on this device. Sign in, or delete it first.';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get emailInvalid => 'Enter a valid email';

  @override
  String get editAccount => 'Edit account';

  @override
  String get choosePhoto => 'Choose photo';

  @override
  String get photoPermissionDenied =>
      'Photo library access is needed to choose a profile photo.';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get profileSaved => 'Account details saved';

  @override
  String get changePassword => 'Change password';

  @override
  String get currentPassword => 'Current password';

  @override
  String get newPassword => 'New password';

  @override
  String get passwordChanged => 'Password changed';

  @override
  String get wrongPassword => 'Current password is incorrect';

  @override
  String get privacyNote =>
      'Your learning data stays on this device unless you choose to back it up.';

  @override
  String get onboardingLanguageTitle => 'Interface language';

  @override
  String get onboardingLanguageSubtitle =>
      'You can change this anytime in Settings.';

  @override
  String get onboardingLevelTitle => 'Your English level';

  @override
  String get onboardingLevelSubtitle =>
      'We\'ll tailor recommendations to this CEFR level.';

  @override
  String get onboardingAccentTitle => 'Preferred pronunciation';

  @override
  String get onboardingAccentSubtitle => 'Choose the accent you want to hear.';

  @override
  String get onboardingGoalTitle => 'Daily learning goal';

  @override
  String get onboardingGoalSubtitle => 'A realistic goal keeps you consistent.';

  @override
  String get onboardingRemindersTitle => 'Daily reminders';

  @override
  String get onboardingRemindersSubtitle =>
      'Gentle nudges to keep your streak alive.';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get getStarted => 'Get started';

  @override
  String get skip => 'Skip';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get save => 'Save';

  @override
  String get confirmDelete => 'Delete this item?';

  @override
  String get confirmDeleteMessage => 'This action cannot be undone.';

  @override
  String get favorites => 'Favorites';

  @override
  String get needsReview => 'Needs review';

  @override
  String get patterns => 'Patterns';

  @override
  String get categories => 'Categories';

  @override
  String get intermediate => 'Intermediate';

  @override
  String get beginner => 'Beginner';

  @override
  String get advanced => 'Advanced';

  @override
  String get moreB1Vocabulary => 'B1 Vocabulary';

  @override
  String get needMoreWords => 'You need more words';

  @override
  String get sentencePatterns => 'Sentence Patterns';

  @override
  String get addMorePatterns => 'Add more patterns';

  @override
  String get speakingPractice => 'Speaking Practice';

  @override
  String sentencesWithoutPractice(int count) {
    return '$count sentences without pronunciation practice';
  }

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading…';

  @override
  String get signOut => 'Sign out';

  @override
  String get americanNatural => 'American — Natural';

  @override
  String get britishNatural => 'British — Natural';

  @override
  String get normalSpeed => 'Normal';

  @override
  String get slowSpeed => 'Learning / Slow';

  @override
  String get dailyReminder => 'Daily Reminder';

  @override
  String get remindersPerDay => 'Reminders per day';

  @override
  String get reminderType => 'Reminder Type';

  @override
  String get quietHours => 'Quiet Hours';

  @override
  String get wordsLearnedThisWeek => 'Words learned this week';

  @override
  String get sentencesLearnedThisWeek => 'Sentences learned this week';

  @override
  String get reviewsCompleted => 'Reviews completed';

  @override
  String get currentStreak => 'Current streak';

  @override
  String get longestStreak => 'Longest streak';

  @override
  String get learningOverTime => 'Learning Over Time';

  @override
  String get total => 'Total';

  @override
  String get learned => 'Learned';

  @override
  String get inProgress => 'In Progress';

  @override
  String get needReview => 'Need Review';

  @override
  String get listen => 'Listen';

  @override
  String get record => 'Record';

  @override
  String get practicePattern => 'Practice Pattern';

  @override
  String get relatedWords => 'Related Words';

  @override
  String get relatedSentences => 'Related Sentences';

  @override
  String get examples => 'Examples';

  @override
  String get related => 'Related';

  @override
  String get generatePronunciation => 'Generate Pronunciation';

  @override
  String get addReminderNotification => 'Add reminder notification';

  @override
  String get favorite => 'Favorite';

  @override
  String get sortRecentlyAdded => 'Recently added';

  @override
  String get sortAlphabetical => 'Alphabetical';

  @override
  String get sortCefr => 'CEFR';

  @override
  String get sortMostReviewed => 'Most reviewed';

  @override
  String get sortLeastReviewed => 'Least reviewed';

  @override
  String get sortMastery => 'Mastery';

  @override
  String get filters => 'Filters';

  @override
  String get mastery => 'Mastery';

  @override
  String get noun => 'Noun';

  @override
  String get verb => 'Verb';

  @override
  String get adjective => 'Adjective';

  @override
  String get adverb => 'Adverb';

  @override
  String get pronoun => 'Pronoun';

  @override
  String get preposition => 'Preposition';

  @override
  String get conjunction => 'Conjunction';

  @override
  String get interjection => 'Interjection';

  @override
  String get phrase => 'Phrase';

  @override
  String get other => 'Other';

  @override
  String get levelA1 => 'A1';

  @override
  String get levelA2 => 'A2';

  @override
  String get levelB1 => 'B1';

  @override
  String get levelB2 => 'B2';

  @override
  String get levelC1 => 'C1';

  @override
  String get levelC2 => 'C2';

  @override
  String goalItems(int count) {
    return '$count items / day';
  }

  @override
  String get enableReminders => 'Enable reminders';

  @override
  String get disableReminders => 'Maybe later';

  @override
  String get addCategory => 'Add category';

  @override
  String get editCategory => 'Edit category';

  @override
  String get categoryNameEn => 'Name (English)';

  @override
  String get categoryNameAr => 'Name (Arabic)';

  @override
  String get categoryIcon => 'Icon';

  @override
  String get systemCategory => 'System';

  @override
  String get noCategoriesYet => 'No categories yet';

  @override
  String get noCategoriesYetMessage =>
      'Create categories to organize words and sentences.';

  @override
  String get categoryDeleted => 'Category deleted';

  @override
  String get cannotDeleteSystemCategory =>
      'System categories cannot be deleted';

  @override
  String get clearFilters => 'Clear';

  @override
  String get applyFilters => 'Apply';

  @override
  String get sortBy => 'Sort by';

  @override
  String get masteryNew => 'New';

  @override
  String get masteryLearning => 'Learning';

  @override
  String get masteryReviewing => 'Reviewing';

  @override
  String get remindersScheduled => 'Reminders scheduled';

  @override
  String get remindersDisabled => 'Reminders turned off';

  @override
  String get notificationPermissionDenied =>
      'Notification permission is required for reminders';

  @override
  String get manageCategories => 'Manage categories';

  @override
  String get reminderWords => 'Words';

  @override
  String get reminderSentences => 'Sentences';

  @override
  String get reminderMixed => 'Mixed';

  @override
  String get reminderDueReviews => 'Due reviews';

  @override
  String get quietHoursStart => 'Quiet hours start';

  @override
  String get quietHoursEnd => 'Quiet hours end';

  @override
  String get exportSuccess => 'Backup ready to share';

  @override
  String get importSuccess => 'Backup imported';

  @override
  String get importFailed => 'Could not read this backup file';

  @override
  String get confirmImport => 'Replace learning data?';

  @override
  String get confirmImportMessage =>
      'Importing a backup replaces words, sentences, patterns, and reviews on this device.';

  @override
  String get unsupportedBackup =>
      'This backup was made by a newer version of Lexora';

  @override
  String get speakingHint =>
      'Listen, record yourself, then compare. Scoring is not available yet — nothing is guessed.';

  @override
  String get stopRecording => 'Stop';

  @override
  String get playRecording => 'Play recording';

  @override
  String get markPracticed => 'Mark as practiced';

  @override
  String get markedPracticed => 'Saved as practiced';

  @override
  String get scoringUnavailable =>
      'Pronunciation scoring will be available in a future update.';

  @override
  String get microphonePermissionDenied =>
      'Microphone permission is required to record';

  @override
  String get clearerVoiceNote =>
      'Lexora uses the clearest English voice installed on this device.';

  @override
  String get writeBlog => 'Write a blog';

  @override
  String get writeBlogDescription =>
      'Write in English. Lexora finds new words after you save.';

  @override
  String get editBlog => 'Edit blog';

  @override
  String get blog => 'Blog';

  @override
  String get blogTitle => 'Title';

  @override
  String get blogContent => 'Text';

  @override
  String get blogsEmpty => 'No blogs yet';

  @override
  String get confirmDeleteBlog => 'Delete this blog?';

  @override
  String get confirmDeleteBlogMessage =>
      'The text is removed. Words you already discovered stay in your vocabulary.';

  @override
  String get noNewWords => 'No new words this time';

  @override
  String newWordsDiscovered(int count) {
    return '$count new words discovered';
  }

  @override
  String blogStatsLine(int words, int classified) {
    return '$words words · $classified classified';
  }

  @override
  String get done => 'Done';

  @override
  String get vocabulary => 'Vocabulary';

  @override
  String get wordNotFound => 'This word is not in the catalog';

  @override
  String get status => 'Status';

  @override
  String get usageCount => 'Times used';

  @override
  String get firstDiscovered => 'First discovered';

  @override
  String get lastUsed => 'Last used';

  @override
  String get academicWord => 'Academic';

  @override
  String get ieltsRelevant => 'IELTS';

  @override
  String get toeflRelevant => 'TOEFL';

  @override
  String get catalogProgress => 'Discovered vocabulary';

  @override
  String get catalogStatsNote =>
      'These counts describe words you have met. They do not change your CEFR level.';

  @override
  String discoveredOf(int discovered, int total) {
    return '$discovered / $total';
  }

  @override
  String get masteredCatalog => 'Mastered';

  @override
  String get academicCatalog => 'Academic';

  @override
  String get discoveredThisWeek => 'Discovered this week';

  @override
  String get statusDiscovered => 'Discovered';

  @override
  String get statusLearning => 'Learning';

  @override
  String get statusReviewing => 'Reviewing';

  @override
  String get statusMastered => 'Mastered';

  @override
  String get topicsTitle => 'Topics';

  @override
  String get topicsSubtitle => 'Learn English by real-life situation.';

  @override
  String get learningPaths => 'Learning paths';

  @override
  String get topicVocabulary => 'Vocabulary';

  @override
  String get topicSentences => 'Sentences';

  @override
  String get topicProgressTab => 'Progress';

  @override
  String topicDiscoveredOf(int discovered, int total) {
    return '$discovered / $total discovered';
  }

  @override
  String topicMasteredCount(int count) {
    return '$count mastered';
  }

  @override
  String topicSentenceCount(int count) {
    return '$count sentences';
  }

  @override
  String get topicEmptyWords => 'No words for this filter';

  @override
  String get topicEmptySentences => 'No sentences for this level yet';

  @override
  String get filterLocked => 'Locked';

  @override
  String get filterDiscovered => 'Discovered';

  @override
  String get filterLearning => 'Learning';

  @override
  String get filterReviewing => 'Reviewing';

  @override
  String get filterMastered => 'Mastered';

  @override
  String get detectedTopics => 'Topics in this text';

  @override
  String get developmentDatasetNote =>
      'This vocabulary is practice content for trying the app. It is not an official CEFR list, and a licensed catalog can replace it.';

  @override
  String get legal => 'Legal';

  @override
  String get support => 'Support';

  @override
  String get termsOfUse => 'Terms of use';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get deleteAccountMessage =>
      'This erases your words, sentences, blogs, reviews, and settings on this device. The shared vocabulary catalog stays. This cannot be undone.';

  @override
  String get linkOpenFailed => 'Could not open the page';

  @override
  String get needsCompletion => 'Needs completion';

  @override
  String needsCompletionCount(int count) {
    return 'Needs completion ($count)';
  }

  @override
  String get catalogRecognized => 'Found in the vocabulary catalog';

  @override
  String get generalTag => 'General';

  @override
  String get spokenTag => 'Spoken';

  @override
  String get formsUnavailable => 'Word forms are not available yet.';

  @override
  String get definitionUnavailable => 'No licensed definition yet.';

  @override
  String get exampleUnavailable => 'No example yet.';

  @override
  String get grammarUsageUnavailable => 'Usage notes are not available yet.';

  @override
  String get saveCompletion => 'Save completion';

  @override
  String get grammarTitle => 'Grammar';

  @override
  String get grammarSampleNote =>
      'Development sample. Not an official CEFR grammar list.';

  @override
  String get grammarUse => 'Use';

  @override
  String get grammarStructure => 'Structure';

  @override
  String get grammarPositive => 'Positive';

  @override
  String get grammarNegative => 'Negative';

  @override
  String get grammarQuestion => 'Question';

  @override
  String get grammarMistake => 'Common mistake';

  @override
  String get grammarPractice => 'Practice';

  @override
  String get grammarCheck => 'Check';

  @override
  String get grammarCorrect => 'Correct';

  @override
  String get grammarTryAgain => 'Not quite. Read the short note and try again.';

  @override
  String get advancedPracticeLocked =>
      'Extra practice unlocks after 10 mastered words. Word levels stay the same.';

  @override
  String get advancedPracticeUnlocked => 'Extra practice is available.';

  @override
  String get topicQuestions => 'Questions';

  @override
  String get yourAnswer => 'Your answer';

  @override
  String get suggestedAnswer => 'Suggested answer';

  @override
  String get submitAnswer => 'Submit answer';

  @override
  String get wordsFound => 'Words found';

  @override
  String masteredProgress(int mastered, int total) {
    return 'Mastered: $mastered / $total';
  }

  @override
  String learningProgressCount(int count) {
    return 'Learning: $count';
  }

  @override
  String discoveredProgressCount(int count) {
    return 'Discovered: $count';
  }

  @override
  String get levelCollectionNote =>
      'Mastered means completed reviews, not an official CEFR level.';

  @override
  String get achievements => 'Achievements';

  @override
  String get congratulations => 'Congratulations';

  @override
  String get achievementUnlocked => 'Achievement unlocked';

  @override
  String get learningTimeTitle => 'Learning time';

  @override
  String learningTimeValue(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get developmentSample => 'Development sample';

  @override
  String get definition => 'Definition';

  @override
  String get wordForms => 'Word forms';
}
