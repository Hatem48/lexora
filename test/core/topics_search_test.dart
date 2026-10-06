import 'dart:convert';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/app/app.dart';
import 'package:lexora/core/constants/enums.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/providers/startup_provider.dart';
import 'package:lexora/core/services/pronunciation/pronunciation_service.dart';
import 'package:lexora/core/services/topics/imported_content_marks.dart';
import 'package:lexora/core/services/topics/topic_content_importer.dart';
import 'package:lexora/core/services/topics/topic_repository.dart';
import 'package:lexora/features/topics/domain/topic_search.dart';
import 'package:lexora/features/topics/presentation/imported_content_providers.dart';
import 'package:lexora/features/topics/presentation/imported_new_badge.dart';
import 'package:lexora/features/topics/presentation/topic_detail_screen.dart';
import 'package:lexora/features/topics/presentation/topic_providers.dart';
import 'package:lexora/features/topics/presentation/topics_screen.dart';
import 'package:lexora/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> unmount(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  }

  void useTallSurface(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  const study = TopicGroupDataView(
    id: 'study-career',
    nameEn: 'Study & Career',
    nameAr: 'الدراسة والعمل',
    sortOrder: 1,
  );
  const technology = TopicGroupDataView(
    id: 'technology',
    nameEn: 'Technology',
    nameAr: 'التكنولوجيا',
    sortOrder: 2,
  );
  final interviews = _card(
    id: 'job-interviews',
    groupId: 'study-career',
    nameEn: 'Job Interviews',
    nameAr: 'مقابلات العمل',
    descriptionEn: 'Applications and interviews.',
    descriptionAr: 'طلبات التوظيف والمقابلات.',
    sortOrder: 1,
  );
  final research = _card(
    id: 'academic-research',
    groupId: 'study-career',
    nameEn: 'Academic Research',
    nameAr: 'البحث العلمي',
    descriptionEn: 'Papers, studies, and research.',
    descriptionAr: 'الأوراق والدراسات والبحث.',
    sortOrder: 2,
  );
  final cyber = _card(
    id: 'cybersecurity',
    groupId: 'technology',
    nameEn: 'Cybersecurity',
    nameAr: 'الأمن السيبراني',
    descriptionEn: 'Networks and security.',
    descriptionAr: 'الشبكات والأمن.',
    sortOrder: 3,
  );
  final groups = [study, technology];
  final cards = [interviews, research, cyber];

  List<String> visibleIds(String query) {
    return [
      for (final section in topicSearchSections(
        groups: groups,
        cards: cards,
        query: query,
      ))
        for (final card in section.cards) card.id,
    ];
  }

  List<String> visibleGroups(String query) {
    return [
      for (final section in topicSearchSections(
        groups: groups,
        cards: cards,
        query: query,
      ))
        section.group.id,
    ];
  }

  test('english topic name search is case-insensitive', () {
    expect(visibleIds('cyber'), ['cybersecurity']);
    expect(visibleIds('CYBER'), ['cybersecurity']);
    expect(visibleIds('  Interview '), ['job-interviews']);
  });

  test('arabic topic name search matches the stored name', () {
    expect(visibleIds('أمن'), ['cybersecurity']);
    expect(visibleIds('مقابلات'), ['job-interviews']);
  });

  test('english and arabic descriptions are searchable', () {
    expect(visibleIds('Applications'), ['job-interviews']);
    expect(visibleIds('طلبات'), ['job-interviews']);
    expect(visibleIds('Networks'), ['cybersecurity']);
    expect(visibleIds('الشبكات'), ['cybersecurity']);
  });

  test('clearing the query restores every topic in the original order', () {
    expect(visibleIds(''), ['job-interviews', 'academic-research', 'cybersecurity']);
    expect(visibleGroups(''), ['study-career', 'technology']);
  });

  test('categories with no matching topics are hidden', () {
    expect(visibleGroups('cyber'), ['technology']);
    expect(visibleIds('zzzz-no-match'), isEmpty);
    expect(visibleGroups('zzzz-no-match'), isEmpty);
  });

  test('a matching category name shows every topic inside it', () {
    expect(
      visibleIds('study'),
      ['job-interviews', 'academic-research'],
    );
    expect(visibleGroups('study'), ['study-career']);
  });

  test('a new empty category stays visible until search hides empty groups', () {
    const fresh = TopicGroupDataView(
      id: 'fresh-lab',
      nameEn: 'Fresh Lab',
      nameAr: 'مختبر جديد',
      sortOrder: 3,
    );
    final idle = topicSearchSections(
      groups: [study, fresh],
      cards: [interviews],
      query: '',
      newCategoryIds: {'fresh-lab'},
    );
    expect(idle.map((section) => section.group.id), ['study-career', 'fresh-lab']);
    expect(idle.last.cards, isEmpty);

    final searching = topicSearchSections(
      groups: [study, fresh],
      cards: [interviews],
      query: 'interview',
      newCategoryIds: {'fresh-lab'},
    );
    expect(searching.map((section) => section.group.id), ['study-career']);
  });

  testWidgets('topics screen searches, hides empty categories, and clears', (
    tester,
  ) async {
    useTallSurface(tester);
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await _seedBoard(db);

    await tester.pumpWidget(_topicsApp(db));
    await tester.pumpAndSettle();

    expect(find.text('Search topics'), findsOneWidget);
    expect(find.text('Study & Career'), findsOneWidget);
    expect(find.text('Job Interviews'), findsOneWidget);
    expect(find.text('Cybersecurity'), findsOneWidget);
    final studyTop = tester.getTopLeft(find.text('Study & Career')).dy;
    final interviewsTop = tester.getTopLeft(find.text('Job Interviews')).dy;
    final technologyTop = tester.getTopLeft(find.text('Technology')).dy;
    final cyberTop = tester.getTopLeft(find.text('Cybersecurity')).dy;
    expect(studyTop, lessThan(interviewsTop));
    expect(interviewsTop, lessThan(technologyTop));
    expect(technologyTop, lessThan(cyberTop));

    await tester.enterText(find.byType(TextField), 'cyber');
    await tester.pump();
    expect(find.text('Cybersecurity'), findsOneWidget);
    expect(find.text('Job Interviews'), findsNothing);
    expect(find.text('Study & Career'), findsNothing);

    await tester.enterText(find.byType(TextField), 'CYBER');
    await tester.pump();
    expect(find.text('Cybersecurity'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'أمن');
    await tester.pump();
    expect(find.text('Cybersecurity'), findsOneWidget);
    expect(find.text('Technology'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'interview');
    await tester.pump();
    expect(find.text('Job Interviews'), findsOneWidget);
    expect(find.text('Cybersecurity'), findsNothing);

    await tester.enterText(find.byType(TextField), 'مقابلات');
    await tester.pump();
    expect(find.text('Job Interviews'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Applications');
    await tester.pump();
    expect(find.text('Job Interviews'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'طلبات');
    await tester.pump();
    expect(find.text('Job Interviews'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'study');
    await tester.pump();
    expect(find.text('Job Interviews'), findsOneWidget);
    expect(find.text('Academic Research'), findsOneWidget);
    expect(find.text('Cybersecurity'), findsNothing);

    await tester.enterText(find.byType(TextField), 'zzzz-no-match');
    await tester.pump();
    expect(find.text('No topics found'), findsOneWidget);
    expect(find.text('Job Interviews'), findsNothing);

    await tester.tap(find.text('Clear search'));
    await tester.pump();
    expect(find.text('Job Interviews'), findsOneWidget);
    expect(find.text('Academic Research'), findsOneWidget);
    expect(find.text('Cybersecurity'), findsOneWidget);
    expect(find.text('No topics found'), findsNothing);
    await unmount(tester);
  });

  testWidgets('new badges clear on category tap and topic open, and stay after reload', (
    tester,
  ) async {
    useTallSurface(tester);
    SharedPreferences.setMockInitialValues({});
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await _seedBoard(db);
    await ImportedContentStore(db).rememberCreated(
      topicIds: ['cybersecurity'],
      categoryIds: ['technology'],
    );

    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        pronunciationServiceProvider.overrideWithValue(_QuietVoice()),
      ],
    );
    var closed = false;
    addTearDown(() {
      if (!closed) container.dispose();
    });

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TopicsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(ImportedNewBadge), findsNWidgets(2));

    await tester.tap(find.text('Technology'));
    await tester.pumpAndSettle();
    expect(find.byType(ImportedNewBadge), findsOneWidget);
    expect(
      (await ImportedContentStore(db).read()).categoryIds,
      isNot(contains('technology')),
    );
    expect(
      (await ImportedContentStore(db).read()).topicIds,
      {'cybersecurity'},
    );

    container.invalidate(importedContentMarksProvider);
    await tester.pumpAndSettle();
    expect(find.byType(ImportedNewBadge), findsOneWidget);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TopicDetailScreen(topicId: 'cybersecurity'),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect((await ImportedContentStore(db).read()).topicIds, isEmpty);
    expect((await ImportedContentStore(db).read()).categoryIds, isEmpty);
    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
    closed = true;
    await tester.pump(const Duration(milliseconds: 1));
  });

  testWidgets('topic cards still open their route', (tester) async {
    useTallSurface(tester);
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await _seedBoard(db);
    final router = GoRouter(
      initialLocation: '/topics',
      routes: [
        GoRoute(
          path: '/topics',
          builder: (_, _) => const TopicsScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (_, state) =>
                  Text('detail:${state.pathParameters['id']}'),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: MaterialApp.router(
          routerConfig: router,
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Job Interviews'));
    await tester.pumpAndSettle();
    expect(find.text('detail:job-interviews'), findsOneWidget);
    await unmount(tester);
  });

  testWidgets('an imported topic appears and can be searched immediately', (
    tester,
  ) async {
    useTallSurface(tester);
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await _seedBoard(db, includeCyber: false);
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    var closed = false;
    addTearDown(() {
      if (!closed) container.dispose();
    });

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TopicsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Cybersecurity'), findsNothing);

    await TopicContentImporter(db).importJson(jsonEncode({
      'schemaVersion': 1,
      'categories': [
        {
          'id': 'technology',
          'name': {'en': 'Technology', 'ar': 'التكنولوجيا'},
        },
      ],
      'topics': [
        {
          'id': 'cybersecurity',
          'categoryId': 'technology',
          'name': {'en': 'Cybersecurity', 'ar': 'الأمن السيبراني'},
          'description': {
            'en': 'Networks and security.',
            'ar': 'الشبكات والأمن.',
          },
          'questions': [
            {
              'id': 'cybersecurity_question_001',
              'type': 'conversation',
              'question': {'en': 'What is a firewall?', 'ar': 'ما هو جدار الحماية؟'},
              'answer': {'en': 'It filters traffic.', 'ar': 'هو يصفّي حركة المرور.'},
              'cefr': 'B1',
            },
          ],
        },
      ],
    }));
    container.read(startupTickProvider.notifier).bump();
    container.invalidate(topicBoardProvider);
    container.invalidate(importedContentMarksProvider);
    await tester.pumpAndSettle();

    expect(find.text('Cybersecurity'), findsOneWidget);
    expect(find.byType(ImportedNewBadge), findsNWidgets(2));
    expect(find.text('Job Interviews'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'cyber');
    await tester.pump();
    expect(find.text('Cybersecurity'), findsOneWidget);
    expect(find.text('Job Interviews'), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
    closed = true;
    await tester.pump(const Duration(milliseconds: 1));
  });

  testWidgets('arabic locale shows the arabic new badge', (tester) async {
    useTallSurface(tester);
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await _seedBoard(db);
    await ImportedContentStore(db).rememberCreated(
      topicIds: ['cybersecurity'],
      categoryIds: ['technology'],
    );

    await tester.pumpWidget(_topicsApp(db, const Locale('ar')));
    await tester.pumpAndSettle();
    expect(find.text('جديد'), findsNWidgets(2));
    expect(find.text('البحث في المواضيع'), findsOneWidget);
    expect(find.text('الأمن السيبراني'), findsOneWidget);
    await unmount(tester);
  });
}

TopicCardData _card({
  required String id,
  required String groupId,
  required String nameEn,
  required String nameAr,
  required String descriptionEn,
  required String descriptionAr,
  required int sortOrder,
}) {
  return TopicCardData(
    id: id,
    groupId: groupId,
    nameEn: nameEn,
    nameAr: nameAr,
    descriptionEn: descriptionEn,
    descriptionAr: descriptionAr,
    iconKey: 'folder',
    sortOrder: sortOrder,
    wordCount: 0,
    sentenceCount: 0,
    unlocked: 0,
    mastered: 0,
  );
}

Widget _topicsApp(AppDatabase db, [Locale locale = const Locale('en')]) {
  return ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(db)],
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const TopicsScreen(),
    ),
  );
}

Future<void> _seedBoard(AppDatabase db, {bool includeCyber = true}) async {
  await db.into(db.topicGroups).insert(
        TopicGroupsCompanion.insert(
          id: 'study-career',
          nameEn: 'Study & Career',
          nameAr: 'الدراسة والعمل',
          sortOrder: const Value(1),
        ),
      );
  if (includeCyber) {
    await db.into(db.topicGroups).insert(
          TopicGroupsCompanion.insert(
            id: 'technology',
            nameEn: 'Technology',
            nameAr: 'التكنولوجيا',
            sortOrder: const Value(2),
          ),
        );
  }
  await _topic(
    db,
    id: 'job-interviews',
    groupId: 'study-career',
    nameEn: 'Job Interviews',
    nameAr: 'مقابلات العمل',
    descriptionEn: 'Applications and interviews.',
    descriptionAr: 'طلبات التوظيف والمقابلات.',
    sortOrder: 1,
  );
  await _topic(
    db,
    id: 'academic-research',
    groupId: 'study-career',
    nameEn: 'Academic Research',
    nameAr: 'البحث العلمي',
    descriptionEn: 'Papers, studies, and research.',
    descriptionAr: 'الأوراق والدراسات والبحث.',
    sortOrder: 2,
  );
  if (!includeCyber) return;
  await _topic(
    db,
    id: 'cybersecurity',
    groupId: 'technology',
    nameEn: 'Cybersecurity',
    nameAr: 'الأمن السيبراني',
    descriptionEn: 'Networks and security.',
    descriptionAr: 'الشبكات والأمن.',
    sortOrder: 3,
  );
}

Future<void> _topic(
  AppDatabase db, {
  required String id,
  required String groupId,
  required String nameEn,
  required String nameAr,
  required String descriptionEn,
  required String descriptionAr,
  required int sortOrder,
}) {
  return db.into(db.topics).insert(
        TopicsCompanion.insert(
          id: id,
          slug: id,
          groupId: groupId,
          nameEn: nameEn,
          nameAr: nameAr,
          descriptionEn: descriptionEn,
          descriptionAr: descriptionAr,
          iconKey: 'folder',
          sortOrder: Value(sortOrder),
        ),
      );
}

class _QuietVoice implements PronunciationService {
  @override
  Future<String?> cacheAudio(
    String text, {
    PronunciationAccent accent = PronunciationAccent.american,
    PlaybackSpeed speed = PlaybackSpeed.normal,
  }) async => null;

  @override
  Future<void> dispose() async {}

  @override
  Future<bool> isCached(
    String text, {
    PronunciationAccent accent = PronunciationAccent.american,
    PlaybackSpeed speed = PlaybackSpeed.normal,
  }) async => false;

  @override
  Future<void> speak(
    String text, {
    PronunciationAccent accent = PronunciationAccent.american,
    PlaybackSpeed speed = PlaybackSpeed.normal,
  }) async {}

  @override
  Future<void> stop() async {}
}
