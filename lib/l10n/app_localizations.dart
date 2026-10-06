import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Lexora'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Learn English your way'**
  String get appTagline;

  /// No description provided for @developedBy.
  ///
  /// In en, this message translates to:
  /// **'Developed by Hatem Husam'**
  String get developedBy;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navWords.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get navWords;

  /// No description provided for @navAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get navAdd;

  /// No description provided for @navSentences.
  ///
  /// In en, this message translates to:
  /// **'Sentences'**
  String get navSentences;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name}'**
  String goodMorning(String name);

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon, {name}'**
  String goodAfternoon(String name);

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening, {name}'**
  String goodEvening(String name);

  /// No description provided for @keepGoingTo.
  ///
  /// In en, this message translates to:
  /// **'Keep going to {level}'**
  String keepGoingTo(String level);

  /// No description provided for @words.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get words;

  /// No description provided for @sentences.
  ///
  /// In en, this message translates to:
  /// **'Sentences'**
  String get sentences;

  /// No description provided for @mastered.
  ///
  /// In en, this message translates to:
  /// **'Mastered'**
  String get mastered;

  /// No description provided for @dueToday.
  ///
  /// In en, this message translates to:
  /// **'Due today'**
  String get dueToday;

  /// No description provided for @yourCefrProgress.
  ///
  /// In en, this message translates to:
  /// **'Your CEFR Progress'**
  String get yourCefrProgress;

  /// No description provided for @vocabularyJourney.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary journey'**
  String get vocabularyJourney;

  /// No description provided for @masteredCountOfTotal.
  ///
  /// In en, this message translates to:
  /// **'{mastered} / {total} mastered'**
  String masteredCountOfTotal(int mastered, int total);

  /// No description provided for @paintingWordsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} / {total} words'**
  String paintingWordsCount(int count, int total);

  /// No description provided for @whatsNewTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s new'**
  String get whatsNewTitle;

  /// No description provided for @whatsNewThisVersion.
  ///
  /// In en, this message translates to:
  /// **'In this version'**
  String get whatsNewThisVersion;

  /// No description provided for @whatsNewPreviousVersion.
  ///
  /// In en, this message translates to:
  /// **'In the previous version'**
  String get whatsNewPreviousVersion;

  /// No description provided for @whatsNewCurrentBody.
  ///
  /// In en, this message translates to:
  /// **'Level paintings now fill from the words Lexora recognizes when you add a word or a sentence. Each level has its own painting. Tapping a sentence opens it and shows your notes. Pronunciation is slower, and an empty painting is a calm canvas instead of a white block.'**
  String get whatsNewCurrentBody;

  /// No description provided for @whatsNewPreviousBody.
  ///
  /// In en, this message translates to:
  /// **'The full vocabulary catalog was installed without erasing your words, sentences, or progress. The CEFR rings count words you have actually met.'**
  String get whatsNewPreviousBody;

  /// No description provided for @wordsRemainingCount.
  ///
  /// In en, this message translates to:
  /// **'{count} still to master'**
  String wordsRemainingCount(int count);

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @masterpieceCompleted.
  ///
  /// In en, this message translates to:
  /// **'{level} Vocabulary Masterpiece Completed'**
  String masterpieceCompleted(String level);

  /// No description provided for @collectionNotOfficialLevel.
  ///
  /// In en, this message translates to:
  /// **'This completes the vocabulary collection, not an official CEFR level.'**
  String get collectionNotOfficialLevel;

  /// No description provided for @artNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get artNotStarted;

  /// No description provided for @continueLearning.
  ///
  /// In en, this message translates to:
  /// **'Continue Learning'**
  String get continueLearning;

  /// No description provided for @itemsNeedReview.
  ///
  /// In en, this message translates to:
  /// **'{words} words + {sentences} sentences need review'**
  String itemsNeedReview(int words, int sentences);

  /// No description provided for @startReview.
  ///
  /// In en, this message translates to:
  /// **'Start Review'**
  String get startReview;

  /// No description provided for @whatYouNeedToAdd.
  ///
  /// In en, this message translates to:
  /// **'What You Need to Add'**
  String get whatYouNeedToAdd;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @addWord.
  ///
  /// In en, this message translates to:
  /// **'Add Word'**
  String get addWord;

  /// No description provided for @addSentence.
  ///
  /// In en, this message translates to:
  /// **'Add Sentence'**
  String get addSentence;

  /// No description provided for @addPattern.
  ///
  /// In en, this message translates to:
  /// **'Add Sentence Pattern'**
  String get addPattern;

  /// No description provided for @addWordDescription.
  ///
  /// In en, this message translates to:
  /// **'Build your personal vocabulary'**
  String get addWordDescription;

  /// No description provided for @addSentenceDescription.
  ///
  /// In en, this message translates to:
  /// **'Save useful phrases and examples'**
  String get addSentenceDescription;

  /// No description provided for @addPatternDescription.
  ///
  /// In en, this message translates to:
  /// **'Master grammar structures'**
  String get addPatternDescription;

  /// No description provided for @saveWord.
  ///
  /// In en, this message translates to:
  /// **'Save Word'**
  String get saveWord;

  /// No description provided for @saveAndAddAnother.
  ///
  /// In en, this message translates to:
  /// **'Save & Add Another'**
  String get saveAndAddAnother;

  /// No description provided for @saveSentence.
  ///
  /// In en, this message translates to:
  /// **'Save Sentence'**
  String get saveSentence;

  /// No description provided for @word.
  ///
  /// In en, this message translates to:
  /// **'Word'**
  String get word;

  /// No description provided for @arabicMeaning.
  ///
  /// In en, this message translates to:
  /// **'Arabic Meaning'**
  String get arabicMeaning;

  /// No description provided for @cefrLevel.
  ///
  /// In en, this message translates to:
  /// **'CEFR Level'**
  String get cefrLevel;

  /// No description provided for @partOfSpeech.
  ///
  /// In en, this message translates to:
  /// **'Part of Speech'**
  String get partOfSpeech;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @exampleSentence.
  ///
  /// In en, this message translates to:
  /// **'Example Sentence'**
  String get exampleSentence;

  /// No description provided for @arabicTranslation.
  ///
  /// In en, this message translates to:
  /// **'Arabic Translation'**
  String get arabicTranslation;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @noNotesYet.
  ///
  /// In en, this message translates to:
  /// **'No notes yet'**
  String get noNotesYet;

  /// No description provided for @addToReviewSystem.
  ///
  /// In en, this message translates to:
  /// **'Add to review system'**
  String get addToReviewSystem;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @wordAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'This word already exists in your library'**
  String get wordAlreadyExists;

  /// No description provided for @noWordsYet.
  ///
  /// In en, this message translates to:
  /// **'No words yet'**
  String get noWordsYet;

  /// No description provided for @noWordsYetMessage.
  ///
  /// In en, this message translates to:
  /// **'Start building your personal vocabulary.'**
  String get noWordsYetMessage;

  /// No description provided for @addYourFirstWord.
  ///
  /// In en, this message translates to:
  /// **'Add your first word'**
  String get addYourFirstWord;

  /// No description provided for @noSentencesYet.
  ///
  /// In en, this message translates to:
  /// **'No sentences yet'**
  String get noSentencesYet;

  /// No description provided for @noSentencesYetMessage.
  ///
  /// In en, this message translates to:
  /// **'Save phrases you want to remember.'**
  String get noSentencesYetMessage;

  /// No description provided for @addYourFirstSentence.
  ///
  /// In en, this message translates to:
  /// **'Add your first sentence'**
  String get addYourFirstSentence;

  /// No description provided for @noReviewsToday.
  ///
  /// In en, this message translates to:
  /// **'No reviews today'**
  String get noReviewsToday;

  /// No description provided for @allCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up.'**
  String get allCaughtUp;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @tapToSeeTranslation.
  ///
  /// In en, this message translates to:
  /// **'Tap to see translation'**
  String get tapToSeeTranslation;

  /// No description provided for @forgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot'**
  String get forgot;

  /// No description provided for @difficult.
  ///
  /// In en, this message translates to:
  /// **'Difficult'**
  String get difficult;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @easy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// No description provided for @reviewComplete.
  ///
  /// In en, this message translates to:
  /// **'Review Complete!'**
  String get reviewComplete;

  /// No description provided for @reviewed.
  ///
  /// In en, this message translates to:
  /// **'Reviewed'**
  String get reviewed;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get correct;

  /// No description provided for @incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get incorrect;

  /// No description provided for @skipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get skipped;

  /// No description provided for @accuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get accuracy;

  /// No description provided for @reviewIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Review Incorrect'**
  String get reviewIncorrect;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @pronunciation.
  ///
  /// In en, this message translates to:
  /// **'Pronunciation'**
  String get pronunciation;

  /// No description provided for @accent.
  ///
  /// In en, this message translates to:
  /// **'Accent'**
  String get accent;

  /// No description provided for @american.
  ///
  /// In en, this message translates to:
  /// **'American'**
  String get american;

  /// No description provided for @british.
  ///
  /// In en, this message translates to:
  /// **'British'**
  String get british;

  /// No description provided for @playbackSpeed.
  ///
  /// In en, this message translates to:
  /// **'Playback speed'**
  String get playbackSpeed;

  /// No description provided for @learning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get learning;

  /// No description provided for @dailyGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily goal'**
  String get dailyGoal;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationCenter.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationCenter;

  /// No description provided for @noNewNotifications.
  ///
  /// In en, this message translates to:
  /// **'No new notifications'**
  String get noNewNotifications;

  /// No description provided for @notificationsHelp.
  ///
  /// In en, this message translates to:
  /// **'Review reminders and learning milestones will appear here.'**
  String get notificationsHelp;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @dueWordsNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Words ready for review'**
  String get dueWordsNoticeTitle;

  /// No description provided for @dueWordsNotice.
  ///
  /// In en, this message translates to:
  /// **'{count} words are ready for review'**
  String dueWordsNotice(int count);

  /// No description provided for @dueSentencesNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Sentences ready for review'**
  String get dueSentencesNoticeTitle;

  /// No description provided for @dueSentencesNotice.
  ///
  /// In en, this message translates to:
  /// **'{count} sentences are ready for review'**
  String dueSentencesNotice(int count);

  /// No description provided for @dailyLearningNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily learning'**
  String get dailyLearningNoticeTitle;

  /// No description provided for @dailyLearningNotice.
  ///
  /// In en, this message translates to:
  /// **'A short review keeps your English moving.'**
  String get dailyLearningNotice;

  /// No description provided for @streakNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Streak reminder'**
  String get streakNoticeTitle;

  /// No description provided for @streakNotice.
  ///
  /// In en, this message translates to:
  /// **'Your {count}-day streak is still open today'**
  String streakNotice(int count);

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @localStorageOnly.
  ///
  /// In en, this message translates to:
  /// **'Local Storage Only'**
  String get localStorageOnly;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @importData.
  ///
  /// In en, this message translates to:
  /// **'Import Data'**
  String get importData;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(String version);

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Lexora'**
  String get signInTitle;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your personal English companion — offline-first, bilingual, and built around how you learn.'**
  String get signInSubtitle;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid username or password'**
  String get invalidCredentials;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get createAccountTitle;

  /// No description provided for @createAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your account stays on this device.'**
  String get createAccountSubtitle;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'I already have an account'**
  String get alreadyHaveAccount;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get displayName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'The passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @usernameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use 3 to 32 letters, numbers, dots, or underscores'**
  String get usernameInvalid;

  /// No description provided for @passwordShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordShort;

  /// No description provided for @accountExists.
  ///
  /// In en, this message translates to:
  /// **'An account already exists on this device. Sign in, or delete it first.'**
  String get accountExists;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get emailInvalid;

  /// No description provided for @editAccount.
  ///
  /// In en, this message translates to:
  /// **'Edit account'**
  String get editAccount;

  /// No description provided for @choosePhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose photo'**
  String get choosePhoto;

  /// No description provided for @photoPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Photo library access is needed to choose a profile photo.'**
  String get photoPermissionDenied;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhoto;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Account details saved'**
  String get profileSaved;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @passwordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed'**
  String get passwordChanged;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect'**
  String get wrongPassword;

  /// No description provided for @privacyNote.
  ///
  /// In en, this message translates to:
  /// **'Your learning data stays on this device unless you choose to back it up.'**
  String get privacyNote;

  /// No description provided for @onboardingLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Interface language'**
  String get onboardingLanguageTitle;

  /// No description provided for @onboardingLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can change this anytime in Settings.'**
  String get onboardingLanguageSubtitle;

  /// No description provided for @onboardingLevelTitle.
  ///
  /// In en, this message translates to:
  /// **'Your English level'**
  String get onboardingLevelTitle;

  /// No description provided for @onboardingLevelSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll tailor recommendations to this CEFR level.'**
  String get onboardingLevelSubtitle;

  /// No description provided for @onboardingAccentTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferred pronunciation'**
  String get onboardingAccentTitle;

  /// No description provided for @onboardingAccentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the accent you want to hear.'**
  String get onboardingAccentSubtitle;

  /// No description provided for @onboardingGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily learning goal'**
  String get onboardingGoalTitle;

  /// No description provided for @onboardingGoalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A realistic goal keeps you consistent.'**
  String get onboardingGoalSubtitle;

  /// No description provided for @onboardingRemindersTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily reminders'**
  String get onboardingRemindersTitle;

  /// No description provided for @onboardingRemindersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Gentle nudges to keep your streak alive.'**
  String get onboardingRemindersSubtitle;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete this item?'**
  String get confirmDelete;

  /// No description provided for @confirmDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get confirmDeleteMessage;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @needsReview.
  ///
  /// In en, this message translates to:
  /// **'Needs review'**
  String get needsReview;

  /// No description provided for @patterns.
  ///
  /// In en, this message translates to:
  /// **'Patterns'**
  String get patterns;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @intermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermediate;

  /// No description provided for @beginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @moreB1Vocabulary.
  ///
  /// In en, this message translates to:
  /// **'B1 Vocabulary'**
  String get moreB1Vocabulary;

  /// No description provided for @needMoreWords.
  ///
  /// In en, this message translates to:
  /// **'You need more words'**
  String get needMoreWords;

  /// No description provided for @sentencePatterns.
  ///
  /// In en, this message translates to:
  /// **'Sentence Patterns'**
  String get sentencePatterns;

  /// No description provided for @addMorePatterns.
  ///
  /// In en, this message translates to:
  /// **'Add more patterns'**
  String get addMorePatterns;

  /// No description provided for @speakingPractice.
  ///
  /// In en, this message translates to:
  /// **'Speaking Practice'**
  String get speakingPractice;

  /// No description provided for @sentencesWithoutPractice.
  ///
  /// In en, this message translates to:
  /// **'{count} sentences without pronunciation practice'**
  String sentencesWithoutPractice(int count);

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @americanNatural.
  ///
  /// In en, this message translates to:
  /// **'American — Natural'**
  String get americanNatural;

  /// No description provided for @britishNatural.
  ///
  /// In en, this message translates to:
  /// **'British — Natural'**
  String get britishNatural;

  /// No description provided for @normalSpeed.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normalSpeed;

  /// No description provided for @slowSpeed.
  ///
  /// In en, this message translates to:
  /// **'Learning / Slow'**
  String get slowSpeed;

  /// No description provided for @dailyReminder.
  ///
  /// In en, this message translates to:
  /// **'Daily Reminder'**
  String get dailyReminder;

  /// No description provided for @remindersPerDay.
  ///
  /// In en, this message translates to:
  /// **'Reminders per day'**
  String get remindersPerDay;

  /// No description provided for @reminderType.
  ///
  /// In en, this message translates to:
  /// **'Reminder Type'**
  String get reminderType;

  /// No description provided for @quietHours.
  ///
  /// In en, this message translates to:
  /// **'Quiet Hours'**
  String get quietHours;

  /// No description provided for @wordsLearnedThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Words learned this week'**
  String get wordsLearnedThisWeek;

  /// No description provided for @sentencesLearnedThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Sentences learned this week'**
  String get sentencesLearnedThisWeek;

  /// No description provided for @reviewsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Reviews completed'**
  String get reviewsCompleted;

  /// No description provided for @currentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current streak'**
  String get currentStreak;

  /// No description provided for @longestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest streak'**
  String get longestStreak;

  /// No description provided for @learningOverTime.
  ///
  /// In en, this message translates to:
  /// **'Learning Over Time'**
  String get learningOverTime;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @learned.
  ///
  /// In en, this message translates to:
  /// **'Learned'**
  String get learned;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @needReview.
  ///
  /// In en, this message translates to:
  /// **'Need Review'**
  String get needReview;

  /// No description provided for @listen.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get listen;

  /// No description provided for @record.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get record;

  /// No description provided for @practicePattern.
  ///
  /// In en, this message translates to:
  /// **'Practice Pattern'**
  String get practicePattern;

  /// No description provided for @relatedWords.
  ///
  /// In en, this message translates to:
  /// **'Related Words'**
  String get relatedWords;

  /// No description provided for @relatedSentences.
  ///
  /// In en, this message translates to:
  /// **'Related Sentences'**
  String get relatedSentences;

  /// No description provided for @examples.
  ///
  /// In en, this message translates to:
  /// **'Examples'**
  String get examples;

  /// No description provided for @related.
  ///
  /// In en, this message translates to:
  /// **'Related'**
  String get related;

  /// No description provided for @generatePronunciation.
  ///
  /// In en, this message translates to:
  /// **'Generate Pronunciation'**
  String get generatePronunciation;

  /// No description provided for @addReminderNotification.
  ///
  /// In en, this message translates to:
  /// **'Add reminder notification'**
  String get addReminderNotification;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @sortRecentlyAdded.
  ///
  /// In en, this message translates to:
  /// **'Recently added'**
  String get sortRecentlyAdded;

  /// No description provided for @sortAlphabetical.
  ///
  /// In en, this message translates to:
  /// **'Alphabetical'**
  String get sortAlphabetical;

  /// No description provided for @sortCefr.
  ///
  /// In en, this message translates to:
  /// **'CEFR'**
  String get sortCefr;

  /// No description provided for @sortMostReviewed.
  ///
  /// In en, this message translates to:
  /// **'Most reviewed'**
  String get sortMostReviewed;

  /// No description provided for @sortLeastReviewed.
  ///
  /// In en, this message translates to:
  /// **'Least reviewed'**
  String get sortLeastReviewed;

  /// No description provided for @sortMastery.
  ///
  /// In en, this message translates to:
  /// **'Mastery'**
  String get sortMastery;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @mastery.
  ///
  /// In en, this message translates to:
  /// **'Mastery'**
  String get mastery;

  /// No description provided for @noun.
  ///
  /// In en, this message translates to:
  /// **'Noun'**
  String get noun;

  /// No description provided for @verb.
  ///
  /// In en, this message translates to:
  /// **'Verb'**
  String get verb;

  /// No description provided for @adjective.
  ///
  /// In en, this message translates to:
  /// **'Adjective'**
  String get adjective;

  /// No description provided for @adverb.
  ///
  /// In en, this message translates to:
  /// **'Adverb'**
  String get adverb;

  /// No description provided for @pronoun.
  ///
  /// In en, this message translates to:
  /// **'Pronoun'**
  String get pronoun;

  /// No description provided for @preposition.
  ///
  /// In en, this message translates to:
  /// **'Preposition'**
  String get preposition;

  /// No description provided for @conjunction.
  ///
  /// In en, this message translates to:
  /// **'Conjunction'**
  String get conjunction;

  /// No description provided for @interjection.
  ///
  /// In en, this message translates to:
  /// **'Interjection'**
  String get interjection;

  /// No description provided for @phrase.
  ///
  /// In en, this message translates to:
  /// **'Phrase'**
  String get phrase;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @levelA1.
  ///
  /// In en, this message translates to:
  /// **'A1'**
  String get levelA1;

  /// No description provided for @levelA2.
  ///
  /// In en, this message translates to:
  /// **'A2'**
  String get levelA2;

  /// No description provided for @levelB1.
  ///
  /// In en, this message translates to:
  /// **'B1'**
  String get levelB1;

  /// No description provided for @levelB2.
  ///
  /// In en, this message translates to:
  /// **'B2'**
  String get levelB2;

  /// No description provided for @levelC1.
  ///
  /// In en, this message translates to:
  /// **'C1'**
  String get levelC1;

  /// No description provided for @levelC2.
  ///
  /// In en, this message translates to:
  /// **'C2'**
  String get levelC2;

  /// No description provided for @goalItems.
  ///
  /// In en, this message translates to:
  /// **'{count} items / day'**
  String goalItems(int count);

  /// No description provided for @enableReminders.
  ///
  /// In en, this message translates to:
  /// **'Enable reminders'**
  String get enableReminders;

  /// No description provided for @disableReminders.
  ///
  /// In en, this message translates to:
  /// **'Maybe later'**
  String get disableReminders;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get addCategory;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit category'**
  String get editCategory;

  /// No description provided for @categoryNameEn.
  ///
  /// In en, this message translates to:
  /// **'Name (English)'**
  String get categoryNameEn;

  /// No description provided for @categoryNameAr.
  ///
  /// In en, this message translates to:
  /// **'Name (Arabic)'**
  String get categoryNameAr;

  /// No description provided for @categoryIcon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get categoryIcon;

  /// No description provided for @systemCategory.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemCategory;

  /// No description provided for @noCategoriesYet.
  ///
  /// In en, this message translates to:
  /// **'No categories yet'**
  String get noCategoriesYet;

  /// No description provided for @noCategoriesYetMessage.
  ///
  /// In en, this message translates to:
  /// **'Create categories to organize words and sentences.'**
  String get noCategoriesYetMessage;

  /// No description provided for @categoryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Category deleted'**
  String get categoryDeleted;

  /// No description provided for @cannotDeleteSystemCategory.
  ///
  /// In en, this message translates to:
  /// **'System categories cannot be deleted'**
  String get cannotDeleteSystemCategory;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearFilters;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyFilters;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @masteryNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get masteryNew;

  /// No description provided for @masteryLearning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get masteryLearning;

  /// No description provided for @masteryReviewing.
  ///
  /// In en, this message translates to:
  /// **'Reviewing'**
  String get masteryReviewing;

  /// No description provided for @remindersScheduled.
  ///
  /// In en, this message translates to:
  /// **'Reminders scheduled'**
  String get remindersScheduled;

  /// No description provided for @remindersDisabled.
  ///
  /// In en, this message translates to:
  /// **'Reminders turned off'**
  String get remindersDisabled;

  /// No description provided for @notificationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission is required for reminders'**
  String get notificationPermissionDenied;

  /// No description provided for @manageCategories.
  ///
  /// In en, this message translates to:
  /// **'Manage categories'**
  String get manageCategories;

  /// No description provided for @reminderWords.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get reminderWords;

  /// No description provided for @reminderSentences.
  ///
  /// In en, this message translates to:
  /// **'Sentences'**
  String get reminderSentences;

  /// No description provided for @reminderMixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed'**
  String get reminderMixed;

  /// No description provided for @reminderDueReviews.
  ///
  /// In en, this message translates to:
  /// **'Due reviews'**
  String get reminderDueReviews;

  /// No description provided for @quietHoursStart.
  ///
  /// In en, this message translates to:
  /// **'Quiet hours start'**
  String get quietHoursStart;

  /// No description provided for @quietHoursEnd.
  ///
  /// In en, this message translates to:
  /// **'Quiet hours end'**
  String get quietHoursEnd;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup ready to share'**
  String get exportSuccess;

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup imported'**
  String get importSuccess;

  /// No description provided for @importFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not read this backup file'**
  String get importFailed;

  /// No description provided for @confirmImport.
  ///
  /// In en, this message translates to:
  /// **'Replace learning data?'**
  String get confirmImport;

  /// No description provided for @confirmImportMessage.
  ///
  /// In en, this message translates to:
  /// **'Importing a backup replaces words, sentences, patterns, and reviews on this device.'**
  String get confirmImportMessage;

  /// No description provided for @unsupportedBackup.
  ///
  /// In en, this message translates to:
  /// **'This backup was made by a newer version of Lexora'**
  String get unsupportedBackup;

  /// No description provided for @speakingHint.
  ///
  /// In en, this message translates to:
  /// **'Listen, record yourself, then compare. Scoring is not available yet — nothing is guessed.'**
  String get speakingHint;

  /// No description provided for @stopRecording.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stopRecording;

  /// No description provided for @playRecording.
  ///
  /// In en, this message translates to:
  /// **'Play recording'**
  String get playRecording;

  /// No description provided for @markPracticed.
  ///
  /// In en, this message translates to:
  /// **'Mark as practiced'**
  String get markPracticed;

  /// No description provided for @markedPracticed.
  ///
  /// In en, this message translates to:
  /// **'Saved as practiced'**
  String get markedPracticed;

  /// No description provided for @scoringUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Pronunciation scoring will be available in a future update.'**
  String get scoringUnavailable;

  /// No description provided for @microphonePermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission is required to record'**
  String get microphonePermissionDenied;

  /// No description provided for @clearerVoiceNote.
  ///
  /// In en, this message translates to:
  /// **'Lexora uses the clearest English voice installed on this device.'**
  String get clearerVoiceNote;

  /// No description provided for @writeBlog.
  ///
  /// In en, this message translates to:
  /// **'Write a blog'**
  String get writeBlog;

  /// No description provided for @writeBlogDescription.
  ///
  /// In en, this message translates to:
  /// **'Write in English. Lexora finds new words after you save.'**
  String get writeBlogDescription;

  /// No description provided for @editBlog.
  ///
  /// In en, this message translates to:
  /// **'Edit blog'**
  String get editBlog;

  /// No description provided for @blog.
  ///
  /// In en, this message translates to:
  /// **'Blog'**
  String get blog;

  /// No description provided for @blogTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get blogTitle;

  /// No description provided for @blogContent.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get blogContent;

  /// No description provided for @blogsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No blogs yet'**
  String get blogsEmpty;

  /// No description provided for @confirmDeleteBlog.
  ///
  /// In en, this message translates to:
  /// **'Delete this blog?'**
  String get confirmDeleteBlog;

  /// No description provided for @confirmDeleteBlogMessage.
  ///
  /// In en, this message translates to:
  /// **'The text is removed. Words you already discovered stay in your vocabulary.'**
  String get confirmDeleteBlogMessage;

  /// No description provided for @noNewWords.
  ///
  /// In en, this message translates to:
  /// **'No new words this time'**
  String get noNewWords;

  /// No description provided for @newWordsDiscovered.
  ///
  /// In en, this message translates to:
  /// **'{count} new words discovered'**
  String newWordsDiscovered(int count);

  /// No description provided for @blogStatsLine.
  ///
  /// In en, this message translates to:
  /// **'{words} words · {classified} classified'**
  String blogStatsLine(int words, int classified);

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @vocabulary.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary'**
  String get vocabulary;

  /// No description provided for @wordNotFound.
  ///
  /// In en, this message translates to:
  /// **'This word is not in the catalog'**
  String get wordNotFound;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @usageCount.
  ///
  /// In en, this message translates to:
  /// **'Times used'**
  String get usageCount;

  /// No description provided for @firstDiscovered.
  ///
  /// In en, this message translates to:
  /// **'First discovered'**
  String get firstDiscovered;

  /// No description provided for @lastUsed.
  ///
  /// In en, this message translates to:
  /// **'Last used'**
  String get lastUsed;

  /// No description provided for @academicWord.
  ///
  /// In en, this message translates to:
  /// **'Academic'**
  String get academicWord;

  /// No description provided for @ieltsRelevant.
  ///
  /// In en, this message translates to:
  /// **'IELTS'**
  String get ieltsRelevant;

  /// No description provided for @toeflRelevant.
  ///
  /// In en, this message translates to:
  /// **'TOEFL'**
  String get toeflRelevant;

  /// No description provided for @catalogProgress.
  ///
  /// In en, this message translates to:
  /// **'Discovered vocabulary'**
  String get catalogProgress;

  /// No description provided for @catalogStatsNote.
  ///
  /// In en, this message translates to:
  /// **'These counts describe words you have met. They do not change your CEFR level.'**
  String get catalogStatsNote;

  /// No description provided for @discoveredOf.
  ///
  /// In en, this message translates to:
  /// **'{discovered} / {total}'**
  String discoveredOf(int discovered, int total);

  /// No description provided for @masteredCatalog.
  ///
  /// In en, this message translates to:
  /// **'Mastered'**
  String get masteredCatalog;

  /// No description provided for @academicCatalog.
  ///
  /// In en, this message translates to:
  /// **'Academic'**
  String get academicCatalog;

  /// No description provided for @discoveredThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Discovered this week'**
  String get discoveredThisWeek;

  /// No description provided for @statusDiscovered.
  ///
  /// In en, this message translates to:
  /// **'Discovered'**
  String get statusDiscovered;

  /// No description provided for @statusLearning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get statusLearning;

  /// No description provided for @statusReviewing.
  ///
  /// In en, this message translates to:
  /// **'Reviewing'**
  String get statusReviewing;

  /// No description provided for @statusMastered.
  ///
  /// In en, this message translates to:
  /// **'Mastered'**
  String get statusMastered;

  /// No description provided for @topicsTitle.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get topicsTitle;

  /// No description provided for @topicsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn English by real-life situation.'**
  String get topicsSubtitle;

  /// No description provided for @learningPaths.
  ///
  /// In en, this message translates to:
  /// **'Learning paths'**
  String get learningPaths;

  /// No description provided for @topicVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary'**
  String get topicVocabulary;

  /// No description provided for @topicSentences.
  ///
  /// In en, this message translates to:
  /// **'Sentences'**
  String get topicSentences;

  /// No description provided for @topicProgressTab.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get topicProgressTab;

  /// No description provided for @topicDiscoveredOf.
  ///
  /// In en, this message translates to:
  /// **'{discovered} / {total} discovered'**
  String topicDiscoveredOf(int discovered, int total);

  /// No description provided for @topicMasteredCount.
  ///
  /// In en, this message translates to:
  /// **'{count} mastered'**
  String topicMasteredCount(int count);

  /// No description provided for @topicSentenceCount.
  ///
  /// In en, this message translates to:
  /// **'{count} sentences'**
  String topicSentenceCount(int count);

  /// No description provided for @topicEmptyWords.
  ///
  /// In en, this message translates to:
  /// **'No words for this filter'**
  String get topicEmptyWords;

  /// No description provided for @topicEmptySentences.
  ///
  /// In en, this message translates to:
  /// **'No sentences for this level yet'**
  String get topicEmptySentences;

  /// No description provided for @filterLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get filterLocked;

  /// No description provided for @filterDiscovered.
  ///
  /// In en, this message translates to:
  /// **'Discovered'**
  String get filterDiscovered;

  /// No description provided for @filterLearning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get filterLearning;

  /// No description provided for @filterReviewing.
  ///
  /// In en, this message translates to:
  /// **'Reviewing'**
  String get filterReviewing;

  /// No description provided for @filterMastered.
  ///
  /// In en, this message translates to:
  /// **'Mastered'**
  String get filterMastered;

  /// No description provided for @detectedTopics.
  ///
  /// In en, this message translates to:
  /// **'Topics in this text'**
  String get detectedTopics;

  /// No description provided for @developmentDatasetNote.
  ///
  /// In en, this message translates to:
  /// **'This vocabulary is practice content for trying the app. It is not an official CEFR list, and a licensed catalog can replace it.'**
  String get developmentDatasetNote;

  /// No description provided for @legal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legal;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get termsOfUse;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'This erases your words, sentences, blogs, reviews, and settings on this device. The shared vocabulary catalog stays. This cannot be undone.'**
  String get deleteAccountMessage;

  /// No description provided for @linkOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the page'**
  String get linkOpenFailed;

  /// No description provided for @needsCompletion.
  ///
  /// In en, this message translates to:
  /// **'Needs completion'**
  String get needsCompletion;

  /// No description provided for @wordNeedsReview.
  ///
  /// In en, this message translates to:
  /// **'Needs review'**
  String get wordNeedsReview;

  /// No description provided for @wordReviewNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Review words'**
  String get wordReviewNoticeTitle;

  /// No description provided for @wordReviewNotice.
  ///
  /// In en, this message translates to:
  /// **'We found {count} words in your list that may need a correction.'**
  String wordReviewNotice(int count);

  /// No description provided for @wordReviewProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String wordReviewProgress(int current, int total);

  /// No description provided for @wordMayBeMisspelled.
  ///
  /// In en, this message translates to:
  /// **'This word may be misspelled'**
  String get wordMayBeMisspelled;

  /// No description provided for @wordDidYouMean.
  ///
  /// In en, this message translates to:
  /// **'Did you mean?'**
  String get wordDidYouMean;

  /// No description provided for @wordMeaningImprovement.
  ///
  /// In en, this message translates to:
  /// **'We found a better meaning for this word'**
  String get wordMeaningImprovement;

  /// No description provided for @wordCurrentMeaning.
  ///
  /// In en, this message translates to:
  /// **'Current translation'**
  String get wordCurrentMeaning;

  /// No description provided for @wordSuggestedMeaning.
  ///
  /// In en, this message translates to:
  /// **'Suggested translation'**
  String get wordSuggestedMeaning;

  /// No description provided for @wordCurrentExample.
  ///
  /// In en, this message translates to:
  /// **'Current example'**
  String get wordCurrentExample;

  /// No description provided for @wordSuggestedExample.
  ///
  /// In en, this message translates to:
  /// **'Suggested example'**
  String get wordSuggestedExample;

  /// No description provided for @wordKeepOriginal.
  ///
  /// In en, this message translates to:
  /// **'Keep {word}'**
  String wordKeepOriginal(String word);

  /// No description provided for @wordReviewDone.
  ///
  /// In en, this message translates to:
  /// **'Word review is complete.'**
  String get wordReviewDone;

  /// No description provided for @wordReviewSpellingFixed.
  ///
  /// In en, this message translates to:
  /// **'Corrected {count} words.'**
  String wordReviewSpellingFixed(int count);

  /// No description provided for @wordReviewMeaningsImproved.
  ///
  /// In en, this message translates to:
  /// **'Improved {count} translations.'**
  String wordReviewMeaningsImproved(int count);

  /// No description provided for @wordReviewKept.
  ///
  /// In en, this message translates to:
  /// **'Kept {count} words unchanged.'**
  String wordReviewKept(int count);

  /// No description provided for @needsCompletionCount.
  ///
  /// In en, this message translates to:
  /// **'Needs completion ({count})'**
  String needsCompletionCount(int count);

  /// No description provided for @catalogRecognized.
  ///
  /// In en, this message translates to:
  /// **'Found in the vocabulary catalog'**
  String get catalogRecognized;

  /// No description provided for @generalTag.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get generalTag;

  /// No description provided for @spokenTag.
  ///
  /// In en, this message translates to:
  /// **'Spoken'**
  String get spokenTag;

  /// No description provided for @formsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Word forms are not available yet.'**
  String get formsUnavailable;

  /// No description provided for @definitionUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No licensed definition yet.'**
  String get definitionUnavailable;

  /// No description provided for @exampleUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No example yet.'**
  String get exampleUnavailable;

  /// No description provided for @grammarUsageUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Usage notes are not available yet.'**
  String get grammarUsageUnavailable;

  /// No description provided for @saveCompletion.
  ///
  /// In en, this message translates to:
  /// **'Save completion'**
  String get saveCompletion;

  /// No description provided for @grammarTitle.
  ///
  /// In en, this message translates to:
  /// **'Grammar'**
  String get grammarTitle;

  /// No description provided for @grammarSampleNote.
  ///
  /// In en, this message translates to:
  /// **'Development sample. Not an official CEFR grammar list.'**
  String get grammarSampleNote;

  /// No description provided for @grammarUse.
  ///
  /// In en, this message translates to:
  /// **'Use'**
  String get grammarUse;

  /// No description provided for @grammarStructure.
  ///
  /// In en, this message translates to:
  /// **'Structure'**
  String get grammarStructure;

  /// No description provided for @grammarPositive.
  ///
  /// In en, this message translates to:
  /// **'Positive'**
  String get grammarPositive;

  /// No description provided for @grammarNegative.
  ///
  /// In en, this message translates to:
  /// **'Negative'**
  String get grammarNegative;

  /// No description provided for @grammarQuestion.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get grammarQuestion;

  /// No description provided for @grammarMistake.
  ///
  /// In en, this message translates to:
  /// **'Common mistake'**
  String get grammarMistake;

  /// No description provided for @grammarPractice.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get grammarPractice;

  /// No description provided for @grammarCheck.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get grammarCheck;

  /// No description provided for @grammarCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get grammarCorrect;

  /// No description provided for @grammarTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Not quite. Read the short note and try again.'**
  String get grammarTryAgain;

  /// No description provided for @advancedPracticeLocked.
  ///
  /// In en, this message translates to:
  /// **'Extra practice unlocks after 10 mastered words. Word levels stay the same.'**
  String get advancedPracticeLocked;

  /// No description provided for @advancedPracticeUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Extra practice is available.'**
  String get advancedPracticeUnlocked;

  /// No description provided for @topicQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get topicQuestions;

  /// No description provided for @yourAnswer.
  ///
  /// In en, this message translates to:
  /// **'Your answer'**
  String get yourAnswer;

  /// No description provided for @suggestedAnswer.
  ///
  /// In en, this message translates to:
  /// **'Suggested answer'**
  String get suggestedAnswer;

  /// No description provided for @submitAnswer.
  ///
  /// In en, this message translates to:
  /// **'Submit answer'**
  String get submitAnswer;

  /// No description provided for @showAnswer.
  ///
  /// In en, this message translates to:
  /// **'Show Answer'**
  String get showAnswer;

  /// No description provided for @hideAnswer.
  ///
  /// In en, this message translates to:
  /// **'Hide Answer'**
  String get hideAnswer;

  /// No description provided for @englishQuestion.
  ///
  /// In en, this message translates to:
  /// **'English question'**
  String get englishQuestion;

  /// No description provided for @arabicQuestion.
  ///
  /// In en, this message translates to:
  /// **'Arabic question'**
  String get arabicQuestion;

  /// No description provided for @englishAnswer.
  ///
  /// In en, this message translates to:
  /// **'English answer'**
  String get englishAnswer;

  /// No description provided for @arabicAnswer.
  ///
  /// In en, this message translates to:
  /// **'Arabic translation'**
  String get arabicAnswer;

  /// No description provided for @artJourneyLevel.
  ///
  /// In en, this message translates to:
  /// **'{level} Journey'**
  String artJourneyLevel(String level);

  /// No description provided for @artMasteredWords.
  ///
  /// In en, this message translates to:
  /// **'Mastered Words'**
  String get artMasteredWords;

  /// No description provided for @artRemainingWords.
  ///
  /// In en, this message translates to:
  /// **'Remaining Words'**
  String get artRemainingWords;

  /// No description provided for @artPaintingGrows.
  ///
  /// In en, this message translates to:
  /// **'Your painting grows as you master new words.'**
  String get artPaintingGrows;

  /// No description provided for @wordsFound.
  ///
  /// In en, this message translates to:
  /// **'Words found'**
  String get wordsFound;

  /// No description provided for @masteredProgress.
  ///
  /// In en, this message translates to:
  /// **'Mastered: {mastered} / {total}'**
  String masteredProgress(int mastered, int total);

  /// No description provided for @learningProgressCount.
  ///
  /// In en, this message translates to:
  /// **'Learning: {count}'**
  String learningProgressCount(int count);

  /// No description provided for @discoveredProgressCount.
  ///
  /// In en, this message translates to:
  /// **'Discovered: {count}'**
  String discoveredProgressCount(int count);

  /// No description provided for @levelCollectionNote.
  ///
  /// In en, this message translates to:
  /// **'Mastered means completed reviews, not an official CEFR level.'**
  String get levelCollectionNote;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get congratulations;

  /// No description provided for @achievementUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Achievement unlocked'**
  String get achievementUnlocked;

  /// No description provided for @learningTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Learning time'**
  String get learningTimeTitle;

  /// No description provided for @learningTimeValue.
  ///
  /// In en, this message translates to:
  /// **'{hours} h {minutes} min'**
  String learningTimeValue(int hours, int minutes);

  /// No description provided for @developmentSample.
  ///
  /// In en, this message translates to:
  /// **'Development sample'**
  String get developmentSample;

  /// No description provided for @definition.
  ///
  /// In en, this message translates to:
  /// **'Definition'**
  String get definition;

  /// No description provided for @wordForms.
  ///
  /// In en, this message translates to:
  /// **'Word forms'**
  String get wordForms;

  /// No description provided for @todayPlan.
  ///
  /// In en, this message translates to:
  /// **'Today\'s plan'**
  String get todayPlan;

  /// No description provided for @todayPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s learning'**
  String get todayPlanTitle;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @todayTasks.
  ///
  /// In en, this message translates to:
  /// **'Today\'s tasks'**
  String get todayTasks;

  /// No description provided for @journeyStep.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String journeyStep(int current, int total);

  /// No description provided for @todayJourneyFocus.
  ///
  /// In en, this message translates to:
  /// **'Today, stay with {level}. Review what is due, meet a few new words, then practice a sentence or a topic.'**
  String todayJourneyFocus(String level);

  /// No description provided for @todayJourneyReview.
  ///
  /// In en, this message translates to:
  /// **'{count} items are due today. Reviewing them keeps yesterday\'s words with you.'**
  String todayJourneyReview(int count);

  /// No description provided for @todayJourneyReviewClear.
  ///
  /// In en, this message translates to:
  /// **'Nothing is due yet. A short look at your words still keeps the habit.'**
  String get todayJourneyReviewClear;

  /// No description provided for @todayJourneyList.
  ///
  /// In en, this message translates to:
  /// **'This is today\'s work. When you finish a task it stays on the list, with a check and a line through it. Tomorrow the list starts again.'**
  String get todayJourneyList;

  /// No description provided for @taskReview.
  ///
  /// In en, this message translates to:
  /// **'Review what is due'**
  String get taskReview;

  /// No description provided for @taskReviewDetail.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String taskReviewDetail(int count);

  /// No description provided for @taskWords.
  ///
  /// In en, this message translates to:
  /// **'Learn {level} words'**
  String taskWords(String level);

  /// No description provided for @taskWordsDetail.
  ///
  /// In en, this message translates to:
  /// **'Open your level\'s words and keep going.'**
  String get taskWordsDetail;

  /// No description provided for @taskSentence.
  ///
  /// In en, this message translates to:
  /// **'Practice a sentence'**
  String get taskSentence;

  /// No description provided for @taskSentenceDetail.
  ///
  /// In en, this message translates to:
  /// **'Open a sentence and listen to it.'**
  String get taskSentenceDetail;

  /// No description provided for @taskTopic.
  ///
  /// In en, this message translates to:
  /// **'Open a topic'**
  String get taskTopic;

  /// No description provided for @taskTopicDetail.
  ///
  /// In en, this message translates to:
  /// **'Answer one question in a topic.'**
  String get taskTopicDetail;

  /// No description provided for @importTopicContent.
  ///
  /// In en, this message translates to:
  /// **'Import topics'**
  String get importTopicContent;

  /// No description provided for @importTopicContentHint.
  ///
  /// In en, this message translates to:
  /// **'Add categories, topics, sentences, and questions from a JSON file.'**
  String get importTopicContentHint;

  /// No description provided for @importTopicContentDone.
  ///
  /// In en, this message translates to:
  /// **'Import completed'**
  String get importTopicContentDone;

  /// No description provided for @importTopicCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories: {added} added, {updated} updated'**
  String importTopicCategories(int added, int updated);

  /// No description provided for @importTopicTopics.
  ///
  /// In en, this message translates to:
  /// **'Topics: {added} added, {updated} updated'**
  String importTopicTopics(int added, int updated);

  /// No description provided for @importTopicVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary links: {added} added, {unresolved} unresolved'**
  String importTopicVocabulary(int added, int unresolved);

  /// No description provided for @importTopicSentences.
  ///
  /// In en, this message translates to:
  /// **'Sentences: {added} added, {updated} updated'**
  String importTopicSentences(int added, int updated);

  /// No description provided for @importTopicQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions: {added} added, {updated} updated'**
  String importTopicQuestions(int added, int updated);

  /// No description provided for @importTopicWarnings.
  ///
  /// In en, this message translates to:
  /// **'Warnings: {count}'**
  String importTopicWarnings(int count);

  /// No description provided for @importTopicMalformed.
  ///
  /// In en, this message translates to:
  /// **'This file is not valid JSON.'**
  String get importTopicMalformed;

  /// No description provided for @importTopicUnsupported.
  ///
  /// In en, this message translates to:
  /// **'This topics file uses an unsupported version.'**
  String get importTopicUnsupported;

  /// No description provided for @importTopicInvalid.
  ///
  /// In en, this message translates to:
  /// **'This topics file is missing required fields.'**
  String get importTopicInvalid;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
