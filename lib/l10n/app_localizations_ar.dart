// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'Lexora';

  @override
  String get appTagline => 'تعلّم الإنجليزية بطريقتك';

  @override
  String get developedBy => 'تطوير: حاتم حسام';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navWords => 'كلمات';

  @override
  String get navAdd => 'إضافة';

  @override
  String get navSentences => 'جمل';

  @override
  String get navProgress => 'التقدّم';

  @override
  String goodMorning(String name) {
    return 'صباح الخير، $name';
  }

  @override
  String goodAfternoon(String name) {
    return 'مساء الخير، $name';
  }

  @override
  String goodEvening(String name) {
    return 'مساء الخير، $name';
  }

  @override
  String keepGoingTo(String level) {
    return 'واصل نحو $level';
  }

  @override
  String get words => 'كلمات';

  @override
  String get sentences => 'جمل';

  @override
  String get mastered => 'مُتقَنة';

  @override
  String get dueToday => 'مستحقة اليوم';

  @override
  String get yourCefrProgress => 'تقدّمك في مستويات CEFR';

  @override
  String get continueLearning => 'واصل التعلّم';

  @override
  String itemsNeedReview(int words, int sentences) {
    return '$words كلمات + $sentences جمل تحتاج مراجعة';
  }

  @override
  String get startReview => 'ابدأ المراجعة';

  @override
  String get whatYouNeedToAdd => 'ما تحتاج إضافته';

  @override
  String get search => 'بحث';

  @override
  String get all => 'الكل';

  @override
  String get addWord => 'إضافة كلمة';

  @override
  String get addSentence => 'إضافة جملة';

  @override
  String get addPattern => 'إضافة نمط جملة';

  @override
  String get addWordDescription => 'ابنِ مفرداتك الشخصية';

  @override
  String get addSentenceDescription => 'احفظ عبارات وأمثلة مفيدة';

  @override
  String get addPatternDescription => 'أتقن التراكيب النحوية';

  @override
  String get saveWord => 'حفظ الكلمة';

  @override
  String get saveAndAddAnother => 'حفظ وإضافة أخرى';

  @override
  String get saveSentence => 'حفظ الجملة';

  @override
  String get word => 'الكلمة';

  @override
  String get arabicMeaning => 'المعنى بالعربية';

  @override
  String get cefrLevel => 'مستوى CEFR';

  @override
  String get partOfSpeech => 'قسم الكلام';

  @override
  String get category => 'التصنيف';

  @override
  String get exampleSentence => 'جملة مثال';

  @override
  String get arabicTranslation => 'الترجمة العربية';

  @override
  String get notes => 'ملاحظات';

  @override
  String get addToReviewSystem => 'أضف إلى نظام المراجعة';

  @override
  String get requiredField => 'هذا الحقل مطلوب';

  @override
  String get wordAlreadyExists => 'هذه الكلمة موجودة مسبقاً في مكتبتك';

  @override
  String get noWordsYet => 'لا توجد كلمات بعد';

  @override
  String get noWordsYetMessage => 'ابدأ ببناء مفرداتك الشخصية.';

  @override
  String get addYourFirstWord => 'أضف أول كلمة';

  @override
  String get noSentencesYet => 'لا توجد جمل بعد';

  @override
  String get noSentencesYetMessage => 'احفظ العبارات التي تريد تذكّرها.';

  @override
  String get addYourFirstSentence => 'أضف أول جملة';

  @override
  String get noReviewsToday => 'لا مراجعات اليوم';

  @override
  String get allCaughtUp => 'أنت على اطلاع كامل.';

  @override
  String get review => 'مراجعة';

  @override
  String get tapToSeeTranslation => 'انقر لعرض الترجمة';

  @override
  String get forgot => 'نسيت';

  @override
  String get difficult => 'صعب';

  @override
  String get good => 'جيد';

  @override
  String get easy => 'سهل';

  @override
  String get reviewComplete => 'اكتملت المراجعة!';

  @override
  String get reviewed => 'تمت المراجعة';

  @override
  String get correct => 'صحيح';

  @override
  String get incorrect => 'خطأ';

  @override
  String get skipped => 'تم التخطي';

  @override
  String get accuracy => 'الدقة';

  @override
  String get reviewIncorrect => 'راجع الأخطاء';

  @override
  String get backToHome => 'العودة للرئيسية';

  @override
  String get settings => 'الإعدادات';

  @override
  String get account => 'الحساب';

  @override
  String get language => 'اللغة';

  @override
  String get appearance => 'المظهر';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeSystem => 'النظام';

  @override
  String get pronunciation => 'النطق';

  @override
  String get accent => 'اللهجة';

  @override
  String get american => 'أمريكية';

  @override
  String get british => 'بريطانية';

  @override
  String get playbackSpeed => 'سرعة التشغيل';

  @override
  String get learning => 'التعلّم';

  @override
  String get dailyGoal => 'الهدف اليومي';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get data => 'البيانات';

  @override
  String get localStorageOnly => 'تخزين محلي فقط';

  @override
  String get exportData => 'تصدير البيانات';

  @override
  String get importData => 'استيراد البيانات';

  @override
  String get backup => 'نسخة احتياطية';

  @override
  String get privacy => 'الخصوصية';

  @override
  String get about => 'حول التطبيق';

  @override
  String version(String version) {
    return 'الإصدار $version';
  }

  @override
  String get signInTitle => 'مرحباً بك في Lexora';

  @override
  String get signInSubtitle =>
      'رفيقك الشخصي لتعلّم الإنجليزية — يعمل دون اتصال، ثنائي اللغة، ومصمم حول طريقتك.';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get password => 'كلمة المرور';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get invalidCredentials => 'اسم المستخدم أو كلمة المرور غير صحيحة';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get createAccountTitle => 'أنشئ حسابك';

  @override
  String get createAccountSubtitle => 'يبقى حسابك على هذا الجهاز.';

  @override
  String get alreadyHaveAccount => 'لدي حساب بالفعل';

  @override
  String get displayName => 'الاسم';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get optional => 'اختياري';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get passwordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get usernameInvalid =>
      'استخدم من 3 إلى 32 حرفاً أو رقماً أو نقطة أو شرطة سفلية';

  @override
  String get passwordShort => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';

  @override
  String get accountExists =>
      'يوجد حساب على هذا الجهاز. سجّل الدخول أو احذفه أولاً.';

  @override
  String get nameRequired => 'الاسم مطلوب';

  @override
  String get emailInvalid => 'أدخل بريداً إلكترونياً صالحاً';

  @override
  String get editAccount => 'تعديل الحساب';

  @override
  String get choosePhoto => 'اختيار صورة';

  @override
  String get photoPermissionDenied =>
      'يلزم السماح بالوصول إلى الصور لاختيار صورة الحساب.';

  @override
  String get removePhoto => 'إزالة الصورة';

  @override
  String get profileSaved => 'تم حفظ بيانات الحساب';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get passwordChanged => 'تم تغيير كلمة المرور';

  @override
  String get wrongPassword => 'كلمة المرور الحالية غير صحيحة';

  @override
  String get privacyNote =>
      'تبقى بيانات تعلّمك على هذا الجهاز ما لم تختر عمل نسخة احتياطية.';

  @override
  String get onboardingLanguageTitle => 'لغة الواجهة';

  @override
  String get onboardingLanguageSubtitle =>
      'يمكنك تغييرها في أي وقت من الإعدادات.';

  @override
  String get onboardingLevelTitle => 'مستواك في الإنجليزية';

  @override
  String get onboardingLevelSubtitle => 'سنخصّص التوصيات حسب مستوى CEFR هذا.';

  @override
  String get onboardingAccentTitle => 'النطق المفضّل';

  @override
  String get onboardingAccentSubtitle => 'اختر اللهجة التي تريد سماعها.';

  @override
  String get onboardingGoalTitle => 'هدف التعلّم اليومي';

  @override
  String get onboardingGoalSubtitle => 'هدف واقعي يساعدك على الاستمرار.';

  @override
  String get onboardingRemindersTitle => 'تذكيرات يومية';

  @override
  String get onboardingRemindersSubtitle => 'تنبيهات لطيفة للحفاظ على سلسلتك.';

  @override
  String get next => 'التالي';

  @override
  String get back => 'رجوع';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get skip => 'تخطي';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get save => 'حفظ';

  @override
  String get confirmDelete => 'حذف هذا العنصر؟';

  @override
  String get confirmDeleteMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get favorites => 'المفضلة';

  @override
  String get needsReview => 'تحتاج مراجعة';

  @override
  String get patterns => 'الأنماط';

  @override
  String get categories => 'التصنيفات';

  @override
  String get intermediate => 'متوسط';

  @override
  String get beginner => 'مبتدئ';

  @override
  String get advanced => 'متقدم';

  @override
  String get moreB1Vocabulary => 'مفردات B1';

  @override
  String get needMoreWords => 'تحتاج المزيد من الكلمات';

  @override
  String get sentencePatterns => 'أنماط الجمل';

  @override
  String get addMorePatterns => 'أضف المزيد من الأنماط';

  @override
  String get speakingPractice => 'تمرين التحدث';

  @override
  String sentencesWithoutPractice(int count) {
    return '$count جملة بدون تمرين نطق';
  }

  @override
  String get errorGeneric => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get loading => 'جارٍ التحميل…';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get americanNatural => 'أمريكية — طبيعية';

  @override
  String get britishNatural => 'بريطانية — طبيعية';

  @override
  String get normalSpeed => 'عادي';

  @override
  String get slowSpeed => 'تعلّم / بطيء';

  @override
  String get dailyReminder => 'تذكير يومي';

  @override
  String get remindersPerDay => 'عدد التذكيرات يومياً';

  @override
  String get reminderType => 'نوع التذكير';

  @override
  String get quietHours => 'ساعات الهدوء';

  @override
  String get wordsLearnedThisWeek => 'كلمات تعلّمتها هذا الأسبوع';

  @override
  String get sentencesLearnedThisWeek => 'جمل تعلّمتها هذا الأسبوع';

  @override
  String get reviewsCompleted => 'مراجعات مكتملة';

  @override
  String get currentStreak => 'السلسلة الحالية';

  @override
  String get longestStreak => 'أطول سلسلة';

  @override
  String get learningOverTime => 'التعلّم عبر الزمن';

  @override
  String get total => 'الإجمالي';

  @override
  String get learned => 'مُتعلَّم';

  @override
  String get inProgress => 'قيد التقدّم';

  @override
  String get needReview => 'تحتاج مراجعة';

  @override
  String get listen => 'استمع';

  @override
  String get record => 'سجّل';

  @override
  String get practicePattern => 'تمرّن على النمط';

  @override
  String get relatedWords => 'كلمات ذات صلة';

  @override
  String get relatedSentences => 'جمل ذات صلة';

  @override
  String get examples => 'أمثلة';

  @override
  String get related => 'ذات صلة';

  @override
  String get generatePronunciation => 'توليد النطق';

  @override
  String get addReminderNotification => 'إضافة إشعار تذكير';

  @override
  String get favorite => 'مفضلة';

  @override
  String get sortRecentlyAdded => 'الأحدث إضافة';

  @override
  String get sortAlphabetical => 'أبجدي';

  @override
  String get sortCefr => 'CEFR';

  @override
  String get sortMostReviewed => 'الأكثر مراجعة';

  @override
  String get sortLeastReviewed => 'الأقل مراجعة';

  @override
  String get sortMastery => 'الإتقان';

  @override
  String get filters => 'عوامل التصفية';

  @override
  String get mastery => 'الإتقان';

  @override
  String get noun => 'اسم';

  @override
  String get verb => 'فعل';

  @override
  String get adjective => 'صفة';

  @override
  String get adverb => 'ظرف';

  @override
  String get pronoun => 'ضمير';

  @override
  String get preposition => 'حرف جر';

  @override
  String get conjunction => 'أداة ربط';

  @override
  String get interjection => 'تعجب';

  @override
  String get phrase => 'عبارة';

  @override
  String get other => 'أخرى';

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
    return '$count عنصر / يوم';
  }

  @override
  String get enableReminders => 'تفعيل التذكيرات';

  @override
  String get disableReminders => 'ربما لاحقاً';

  @override
  String get addCategory => 'إضافة تصنيف';

  @override
  String get editCategory => 'تعديل التصنيف';

  @override
  String get categoryNameEn => 'الاسم (إنجليزي)';

  @override
  String get categoryNameAr => 'الاسم (عربي)';

  @override
  String get categoryIcon => 'الأيقونة';

  @override
  String get systemCategory => 'نظامي';

  @override
  String get noCategoriesYet => 'لا توجد تصنيفات بعد';

  @override
  String get noCategoriesYetMessage => 'أنشئ تصنيفات لتنظيم الكلمات والجمل.';

  @override
  String get categoryDeleted => 'تم حذف التصنيف';

  @override
  String get cannotDeleteSystemCategory => 'لا يمكن حذف تصنيفات النظام';

  @override
  String get clearFilters => 'مسح';

  @override
  String get applyFilters => 'تطبيق';

  @override
  String get sortBy => 'ترتيب حسب';

  @override
  String get masteryNew => 'جديد';

  @override
  String get masteryLearning => 'قيد التعلّم';

  @override
  String get masteryReviewing => 'قيد المراجعة';

  @override
  String get remindersScheduled => 'تم جدولة التذكيرات';

  @override
  String get remindersDisabled => 'تم إيقاف التذكيرات';

  @override
  String get notificationPermissionDenied => 'يلزم إذن الإشعارات للتذكيرات';

  @override
  String get manageCategories => 'إدارة التصنيفات';

  @override
  String get reminderWords => 'كلمات';

  @override
  String get reminderSentences => 'جمل';

  @override
  String get reminderMixed => 'مختلط';

  @override
  String get reminderDueReviews => 'مراجعات مستحقة';

  @override
  String get quietHoursStart => 'بداية ساعات الهدوء';

  @override
  String get quietHoursEnd => 'نهاية ساعات الهدوء';

  @override
  String get exportSuccess => 'النسخة الاحتياطية جاهزة للمشاركة';

  @override
  String get importSuccess => 'تم استيراد النسخة الاحتياطية';

  @override
  String get importFailed => 'تعذر قراءة ملف النسخة الاحتياطية';

  @override
  String get confirmImport => 'استبدال بيانات التعلم؟';

  @override
  String get confirmImportMessage =>
      'الاستيراد يستبدل الكلمات والجمل والأنماط والمراجعات على هذا الجهاز.';

  @override
  String get unsupportedBackup => 'هذه النسخة من إصدار أحدث من Lexora';

  @override
  String get speakingHint =>
      'استمع، سجّل صوتك، ثم قارن. تقييم النطق غير متاح بعد ولا يتم تخمين نتيجة.';

  @override
  String get stopRecording => 'إيقاف';

  @override
  String get playRecording => 'تشغيل التسجيل';

  @override
  String get markPracticed => 'تعليم كمُمارَس';

  @override
  String get markedPracticed => 'تم الحفظ كمُمارَس';

  @override
  String get scoringUnavailable => 'تقييم النطق سيكون متاحاً في تحديث لاحق.';

  @override
  String get microphonePermissionDenied => 'يلزم إذن الميكروفون للتسجيل';

  @override
  String get clearerVoiceNote =>
      'يستخدم Lexora أوضح صوت إنجليزي مثبّت على هذا الجهاز.';

  @override
  String get writeBlog => 'اكتب تدوينة';

  @override
  String get writeBlogDescription =>
      'اكتب بالإنجليزية. يكتشف Lexora الكلمات الجديدة بعد الحفظ.';

  @override
  String get editBlog => 'تعديل التدوينة';

  @override
  String get blog => 'التدوينة';

  @override
  String get blogTitle => 'العنوان';

  @override
  String get blogContent => 'النص';

  @override
  String get blogsEmpty => 'لا توجد تدوينات بعد';

  @override
  String get confirmDeleteBlog => 'حذف هذه التدوينة؟';

  @override
  String get confirmDeleteBlogMessage =>
      'يُحذف النص. الكلمات التي اكتشفتها تبقى في مفرداتك.';

  @override
  String get noNewWords => 'لا كلمات جديدة هذه المرة';

  @override
  String newWordsDiscovered(int count) {
    return 'اكتُشفت $count كلمات جديدة';
  }

  @override
  String blogStatsLine(int words, int classified) {
    return '$words كلمة · $classified مصنّفة';
  }

  @override
  String get done => 'تم';

  @override
  String get vocabulary => 'المفردات';

  @override
  String get wordNotFound => 'هذه الكلمة غير موجودة في القاموس';

  @override
  String get status => 'الحالة';

  @override
  String get usageCount => 'مرات الاستخدام';

  @override
  String get firstDiscovered => 'أول اكتشاف';

  @override
  String get lastUsed => 'آخر استخدام';

  @override
  String get academicWord => 'أكاديمية';

  @override
  String get ieltsRelevant => 'IELTS';

  @override
  String get toeflRelevant => 'TOEFL';

  @override
  String get catalogProgress => 'المفردات المكتشفة';

  @override
  String get catalogStatsNote =>
      'هذه الأرقام تصف الكلمات التي التقيت بها، ولا تغيّر مستواك في CEFR.';

  @override
  String discoveredOf(int discovered, int total) {
    return '$discovered / $total';
  }

  @override
  String get masteredCatalog => 'متقنة';

  @override
  String get academicCatalog => 'أكاديمية';

  @override
  String get discoveredThisWeek => 'اكتُشفت هذا الأسبوع';

  @override
  String get statusDiscovered => 'مكتشفة';

  @override
  String get statusLearning => 'قيد التعلّم';

  @override
  String get statusReviewing => 'قيد المراجعة';

  @override
  String get statusMastered => 'متقنة';

  @override
  String get topicsTitle => 'المواضيع';

  @override
  String get topicsSubtitle => 'تعلّم الإنجليزية حسب موقف حقيقي.';

  @override
  String get learningPaths => 'مسارات التعلم';

  @override
  String get topicVocabulary => 'المفردات';

  @override
  String get topicSentences => 'الجمل';

  @override
  String get topicProgressTab => 'التقدم';

  @override
  String topicDiscoveredOf(int discovered, int total) {
    return '$discovered / $total مكتشفة';
  }

  @override
  String topicMasteredCount(int count) {
    return '$count متقنة';
  }

  @override
  String topicSentenceCount(int count) {
    return '$count جملة';
  }

  @override
  String get topicEmptyWords => 'لا كلمات لهذا التصفية';

  @override
  String get topicEmptySentences => 'لا جمل لهذا المستوى بعد';

  @override
  String get filterLocked => 'مقفلة';

  @override
  String get filterDiscovered => 'مكتشفة';

  @override
  String get filterLearning => 'قيد التعلّم';

  @override
  String get filterReviewing => 'قيد المراجعة';

  @override
  String get filterMastered => 'متقنة';

  @override
  String get detectedTopics => 'مواضيع هذا النص';

  @override
  String get developmentDatasetNote =>
      'هذه المفردات محتوى تدريبي لتجربة التطبيق. ليست قائمة CEFR رسمية، ويمكن استبدالها بكتالوج مرخّص.';

  @override
  String get legal => 'قانوني';

  @override
  String get support => 'الدعم';

  @override
  String get termsOfUse => 'سياسة الاستخدام';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get deleteAccountMessage =>
      'يمسح هذا كلماتك وجملك وتدويناتك ومراجعاتك وإعداداتك على هذا الجهاز. كتالوج المفردات المشترك يبقى. لا يمكن التراجع.';

  @override
  String get linkOpenFailed => 'تعذّر فتح الصفحة';

  @override
  String get needsCompletion => 'تحتاج إكمال';

  @override
  String needsCompletionCount(int count) {
    return 'تحتاج إكمال ($count)';
  }

  @override
  String get catalogRecognized => 'موجودة في كتالوج المفردات';

  @override
  String get generalTag => 'عامة';

  @override
  String get spokenTag => 'محكية';

  @override
  String get formsUnavailable => 'صيغ الكلمة غير متوفرة بعد.';

  @override
  String get definitionUnavailable => 'لا يوجد تعريف مرخّص بعد.';

  @override
  String get exampleUnavailable => 'لا يوجد مثال بعد.';

  @override
  String get grammarUsageUnavailable => 'ملاحظات الاستخدام غير متوفرة بعد.';

  @override
  String get saveCompletion => 'حفظ الإكمال';

  @override
  String get grammarTitle => 'القواعد';

  @override
  String get grammarSampleNote => 'عينة تطوير. ليست قائمة قواعد CEFR رسمية.';

  @override
  String get grammarUse => 'الاستخدام';

  @override
  String get grammarStructure => 'التركيب';

  @override
  String get grammarPositive => 'إثبات';

  @override
  String get grammarNegative => 'نفي';

  @override
  String get grammarQuestion => 'سؤال';

  @override
  String get grammarMistake => 'خطأ شائع';

  @override
  String get grammarPractice => 'تدريب';

  @override
  String get grammarCheck => 'تحقق';

  @override
  String get grammarCorrect => 'صحيح';

  @override
  String get grammarTryAgain =>
      'ليس بعد. اقرأ الملاحظة القصيرة وحاول مرة أخرى.';

  @override
  String get advancedPracticeLocked =>
      'التدريب الإضافي يُفتح بعد إتقان 10 كلمات. مستويات الكلمات تبقى كما هي.';

  @override
  String get advancedPracticeUnlocked => 'التدريب الإضافي متاح.';

  @override
  String get topicQuestions => 'أسئلة';

  @override
  String get yourAnswer => 'إجابتك';

  @override
  String get suggestedAnswer => 'إجابة مقترحة';

  @override
  String get submitAnswer => 'إرسال الإجابة';

  @override
  String get wordsFound => 'كلمات وُجدت';

  @override
  String masteredProgress(int mastered, int total) {
    return 'متقنة: $mastered / $total';
  }

  @override
  String learningProgressCount(int count) {
    return 'قيد التعلم: $count';
  }

  @override
  String discoveredProgressCount(int count) {
    return 'مكتشفة: $count';
  }

  @override
  String get levelCollectionNote =>
      'الإتقان يعني مراجعات مكتملة، وليس مستوى CEFR رسميًا.';

  @override
  String get achievements => 'الإنجازات';

  @override
  String get congratulations => 'تهانينا';

  @override
  String get achievementUnlocked => 'تم فتح إنجاز';

  @override
  String get learningTimeTitle => 'وقت التعلم';

  @override
  String learningTimeValue(int hours, int minutes) {
    return '$hours س $minutes د';
  }

  @override
  String get developmentSample => 'عينة تطوير';

  @override
  String get definition => 'التعريف';

  @override
  String get wordForms => 'صيغ الكلمة';
}
