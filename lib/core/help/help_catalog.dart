enum HelpTopic {
  cefr,
  discoveredWords,
  learningWords,
  masteredWords,
  reviewSystem,
  streak,
  learningTime,
  vocabularyProgress,
  levelArtwork,
  topics,
  vocabularyDiscovery,
  posts,
  grammar,
  achievements,
  academicTag,
  spokenTag,
  wordForms,
  learningPaths,
  backup,
  notifications,
}

class HelpEntry {
  const HelpEntry({required this.title, required this.body});

  final String title;
  final String body;
}

/// Arabic help copy lives here only. Screens never embed their own explanation.
class HelpCatalog {
  const HelpCatalog._();

  static HelpEntry of(HelpTopic topic) => _entries[topic]!;

  static final Map<HelpTopic, HelpEntry> _entries = {
    HelpTopic.cefr: const HelpEntry(
      title: 'ما هي مستويات CEFR؟',
      body:
          'CEFR هو إطار يستخدم لتقسيم تعلم اللغة إلى مستويات تبدأ من A1 للمبتدئ وتصل إلى C2 للمتقدم جدًا. تصنيف الكلمات داخل Lexora يساعدك على تنظيم تعلمك، ولا يُعتبر اختبارًا رسميًا لمستواك في اللغة.',
    ),
    HelpTopic.discoveredWords: const HelpEntry(
      title: 'ما معنى كلمة مكتشفة؟',
      body:
          'الكلمة المكتشفة هي كلمة قابلتها أثناء استخدام Lexora، مثل الكتابة في التدوينات أو الجمل. اكتشاف الكلمة لا يعني أنك أتقنتها بعد.',
    ),
    HelpTopic.learningWords: const HelpEntry(
      title: 'ما معنى قيد التعلم؟',
      body:
          'هي كلمة بدأت في تعلمها ومراجعتها، لكنها لم تحقق شروط الإتقان بعد.',
    ),
    HelpTopic.masteredWords: const HelpEntry(
      title: 'ما معنى كلمة متقنة؟',
      body:
          'الكلمة المتقنة هي كلمة حققت شروط التعلم والمراجعة المعتمدة في Lexora. مجرد اكتشاف الكلمة لا يجعلها متقنة.',
    ),
    HelpTopic.levelArtwork: const HelpEntry(
      title: 'كيف تتكوّن لوحة المستوى؟',
      body:
          'تتلون لوحة كل مستوى بالكلمات التي يتعرف عليها Lexora عندما تضيف كلمة أو جملة من ذلك المستوى. كلما زادت الكلمات ظهرت أجزاء أكثر، وعند إتقان كل كلمات المستوى تكتمل اللوحة.',
    ),
    HelpTopic.streak: const HelpEntry(
      title: 'ما هي سلسلة التعلم؟',
      body:
          'تمثل عدد الأيام المتتالية التي حققت فيها نشاط تعلم فعلي داخل Lexora. مجرد فتح التطبيق لا يُحتسب بالضرورة كيوم تعلم.',
    ),
    HelpTopic.learningTime: const HelpEntry(
      title: 'ما هو وقت التعلم؟',
      body:
          'وقت التعلم هو المدة التي قضيتها في نشاط فعلي داخل Lexora، مثل المراجعة أو التمارين. ترك التطبيق مفتوحًا دون نشاط لا يُحتسب بالكامل.',
    ),
    HelpTopic.vocabularyProgress: const HelpEntry(
      title: 'كيف يُحسب تقدم المفردات؟',
      body:
          'يعرض لكل مستوى كم كلمة اكتشفتها، وكم كلمة ما زالت قيد التعلم، وكم كلمة أتقنتها. كل مستوى يُحسب وحده، وإتقان الكلمات لا يعني حصولك على مستوى CEFR رسمي.',
    ),
    HelpTopic.vocabularyDiscovery: const HelpEntry(
      title: 'كيف يكتشف Lexora الكلمات؟',
      body:
          'عندما تستخدم كلمات من قاموس Lexora أثناء الكتابة في الميزات المدعومة، يستطيع التطبيق التعرف عليها وربطها بتقدمك في المفردات.',
    ),
    HelpTopic.reviewSystem: const HelpEntry(
      title: 'كيف تعمل المراجعة؟',
      body:
          'يساعدك نظام المراجعة على العودة إلى الكلمات والجمل التي تعلمتها في الأوقات المناسبة بدل الاعتماد على القراءة مرة واحدة فقط.',
    ),
    HelpTopic.notifications: const HelpEntry(
      title: 'كيف تعمل التنبيهات؟',
      body:
          'تساعدك التنبيهات على معرفة الكلمات والجمل الجاهزة للمراجعة وتذكرك بالتعلم حسب الإعدادات التي تختارها. مركز التنبيهات داخل التطبيق يعمل حتى لو رفضت إشعارات الجهاز.',
    ),
    HelpTopic.topics: const HelpEntry(
      title: 'ما هي المواضيع؟',
      body:
          'المواضيع تجمع كلمات مرتبطة بسياق واحد، مثل السفر أو العمل، حتى تتدرب عليها معًا. فتح موضوع لا يغيّر حالة إتقان كلماته.',
    ),
    HelpTopic.learningPaths: const HelpEntry(
      title: 'ما هي مسارات التعلم؟',
      body:
          'مسارات التعلم ترتب المواضيع في تسلسل يساعدك على الانتقال بينها. يمكنك الرجوع إلى أي موضوع سابق في أي وقت.',
    ),
    HelpTopic.posts: const HelpEntry(
      title: 'كيف تساعد التدوينات على التعلم؟',
      body:
          'عند الكتابة، يتعرف Lexora على كلمات القاموس التي تستخدمها ويضيفها إلى تقدم المفردات. ظهور الكلمة في النص يعني أنها مكتشفة، لا أنها متقنة.',
    ),
    HelpTopic.grammar: const HelpEntry(
      title: 'ما هو تقدم القواعد؟',
      body:
          'يتابع الدروس والتمارين التي أكملتها. إكمال تمرين قواعد لا يغيّر مستوى كلماتك ولا يُعد مستوى لغة رسميًا.',
    ),
    HelpTopic.achievements: const HelpEntry(
      title: 'ما هي الإنجازات؟',
      body:
          'الإنجازات علامات داخل Lexora على عادات التعلم، مثل سلسلة الأيام أو إكمال مجموعة مفردات. إكمال مجموعة لا يعني أن مستواك الرسمي في اللغة أصبح ذلك المستوى.',
    ),
    HelpTopic.academicTag: const HelpEntry(
      title: 'ما معنى الوسم الأكاديمي؟',
      body:
          'الوسم الأكاديمي يعني أن الكلمة تظهر كثيرًا في السياقات الدراسية. هذا تصنيف داخل الكتالوج، ولا يغيّر شرط الإتقان.',
    ),
    HelpTopic.spokenTag: const HelpEntry(
      title: 'ما معنى وسم المحادثة؟',
      body:
          'وسم المحادثة يشير إلى أن الكلمة شائعة في الإنجليزية المنطوقة. هذا تصنيف داخل الكتالوج، وليس حكمًا على نطقك.',
    ),
    HelpTopic.wordForms: const HelpEntry(
      title: 'ما هي صيغ الكلمة؟',
      body:
          'صيغ الكلمة هي الأشكال المرتبطة بها، مثل الجمع أو الماضي. التعرف على الصيغة يربطها بالكلمة الأصلية في قاموس Lexora.',
    ),
    HelpTopic.backup: const HelpEntry(
      title: 'ماذا يحفظ النسخ الاحتياطي؟',
      body:
          'النسخ الاحتياطي يحفظ بياناتك على جهازك، مثل كلماتك وجملك وتقدمك، حتى تتمكن من استعادتها لاحقًا. لا يُرسل هذا النسخ إلى خادم.',
    ),
  };
}
