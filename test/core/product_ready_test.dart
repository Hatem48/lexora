import 'dart:io';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/core/constants/enums.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/help/context_help_icon.dart';
import 'package:lexora/core/help/help_catalog.dart';
import 'package:lexora/core/services/app_package_info.dart';
import 'package:lexora/core/services/notifications/reminder_scheduler.dart';
import 'package:lexora/core/services/progress/learning_activity_store.dart';
import 'package:lexora/features/notifications/data/notice_read_store.dart';
import 'package:lexora/features/notifications/domain/in_app_notice.dart';
import 'package:lexora/features/notifications/presentation/notification_center_screen.dart';
import 'package:lexora/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  final now = DateTime.utc(2026, 10, 5, 12);

  test('notices follow live learning data and read state', () {
    final open = buildInAppNotices(
      dueWords: 5,
      dueSentences: 2,
      studiedToday: false,
      currentStreak: 3,
      uncelebrated: [
        (id: 'level-b1', unlockedAt: now),
        (id: 'mastered-100', unlockedAt: now),
      ],
      now: now,
    );
    expect(unreadNoticeCount(open), 5);
    expect(noticeBadgeLabel(0), isNull);
    expect(noticeBadgeLabel(3), '3');
    expect(noticeBadgeLabel(12), '9+');
    expect(open.firstWhere((item) => item.kind == NoticeKind.dueWords).route, '/review');
    expect(routeForAchievement('level-b1'), '/progress/level/B1');
    expect(routeForAchievement('mastered-100'), '/progress');
    expect(notificationRoute('/progress/level/B1'), '/progress/level/B1');
    expect(notificationRoute('https://example.test'), '/review');

    final read = applyReadState(open, {'due-words-5'});
    expect(unreadNoticeCount(read), 4);
    expect(unreadNoticeCount(markNoticesRead(read)), 0);

    final quiet = buildInAppNotices(
      dueWords: 0,
      dueSentences: 0,
      studiedToday: true,
      currentStreak: 1,
      uncelebrated: const [],
      now: now,
    );
    expect(quiet, isEmpty);
    final discoveredOnly = buildInAppNotices(
      dueWords: 0,
      dueSentences: 0,
      studiedToday: true,
      currentStreak: 0,
      uncelebrated: const [],
      now: now,
    );
    expect(discoveredOnly, isEmpty);
  });

  test('marking notices read does not touch vocabulary progress', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final when = DateTime.utc(2026, 10, 5);
    await db.into(db.vocabularyEntries).insert(
          VocabularyEntriesCompanion.insert(
            id: 'city',
            lemma: 'city',
            cefrLevel: 'B1',
            partOfSpeech: 'noun',
            definitionEn: 'A large town.',
            arabicMeaning: 'مدينة',
            exampleSentence: 'A busy city.',
          ),
        );
    await db.into(db.userVocabulary).insert(
          UserVocabularyCompanion.insert(
            entryId: 'city',
            status: const Value('mastered'),
            firstDiscoveredAt: when,
            discoveredIn: 'test',
            lastUsedAt: when,
          ),
        );
    await NoticeReadStore(db).markRead(['due-words-5', 'due-words-5']);
    await NoticeReadStore(db).markRead(['streak-1']);
    final progress = await db.select(db.userVocabulary).getSingle();
    expect(progress.status, 'mastered');
    expect(await NoticeReadStore(db).readIds(), {'due-words-5', 'streak-1'});
    final words = await db.select(db.vocabularyEntries).get();
    expect(words, hasLength(1));
  });

  test('local reminders schedule only when enabled and permitted', () {
    expect(
      shouldScheduleReminders(enabled: true, permitted: false),
      isFalse,
    );
    expect(
      shouldScheduleReminders(enabled: false, permitted: true),
      isFalse,
    );
    expect(shouldScheduleReminders(enabled: true, permitted: true), isTrue);
    expect(reminderPayload(ReminderType.dueReviews), '/review');
  });

  test('help explanations stay Arabic and live in one catalog', () {
    final mastered = HelpCatalog.of(HelpTopic.masteredWords);
    final cefr = HelpCatalog.of(HelpTopic.cefr);
    expect(mastered.title, 'ما معنى كلمة متقنة؟');
    expect(mastered.body, contains('لا يجعلها متقنة'));
    expect(cefr.title, 'ما هي مستويات CEFR؟');
    expect(cefr.body, contains('A1'));
    expect(cefr.body, contains('رسمي'));
    for (final topic in HelpTopic.values) {
      final entry = HelpCatalog.of(topic);
      expect(RegExp(r'[\u0600-\u06FF]').hasMatch(entry.title), isTrue);
      expect(RegExp(r'[\u0600-\u06FF]').hasMatch(entry.body), isTrue);
    }
    var copies = 0;
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      if (entity.readAsStringSync().contains('ما معنى كلمة متقنة؟')) copies++;
    }
    expect(copies, 1);
  });

  test('settings reads the installed version instead of a fixed string', () {
    final settings = File(
      'lib/features/settings/presentation/settings_screen.dart',
    ).readAsStringSync();
    expect(settings.contains('1.0.0'), isFalse);
    expect(settings.contains('AppInfo.version'), isFalse);
    expect(settings.contains('InstalledVersionText'), isTrue);
    expect(formatInstalledVersion(version: '1.0.0', buildNumber: '14'), '1.0.0 (14)');
    expect(formatInstalledVersion(version: '1.1.0', buildNumber: '20'), '1.1.0 (20)');
    expect(formatInstalledVersion(version: ' ', buildNumber: ''), '— (—)');
    final codemagic = File('codemagic.yaml').readAsStringSync();
    expect(codemagic.contains('--build-number=17'), isTrue);
    expect(codemagic.contains('--build-name=1.0.0'), isTrue);
  });

  testWidgets('the bell opens the center and an empty day can be quiet', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await db.into(db.learningDays).insert(
          LearningDaysCompanion.insert(
            day: LearningActivityStore.dayKey(DateTime.now()),
            activeSeconds: const Value(120),
          ),
        );
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: NotificationBell(
              unread: 2,
              tooltip: 'Notifications',
              onPressed: () => context.push('/notifications'),
            ),
          ),
        ),
        GoRoute(
          path: '/notifications',
          builder: (context, state) => const NotificationCenterScreen(),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: MaterialApp.router(
          routerConfig: router,
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    expect(find.text('2'), findsOneWidget);
    await tester.tap(find.byType(NotificationBell));
    await tester.pumpAndSettle();
    expect(find.text('لا توجد إشعارات جديدة'), findsOneWidget);
  });

  testWidgets('opening a notice reports its route and a read badge drops', (
    tester,
  ) async {
    final notice = InAppNotice(
      id: 'due-words-5',
      kind: NoticeKind.dueWords,
      createdAt: now,
      route: '/review',
      count: 5,
    );
    String? opened;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: NotificationCenterBody(
            notices: [notice],
            onOpen: (item) => opened = item.route,
          ),
        ),
      ),
    );
    expect(find.text('5 words are ready for review'), findsOneWidget);
    await tester.tap(find.text('Words ready for review'));
    expect(opened, '/review');
    expect(unreadNoticeCount(markNoticesRead([notice], id: notice.id)), 0);
  });

  testWidgets('help opens the Arabic explanation from right to left', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          body: ContextHelpIcon(topic: HelpTopic.masteredWords),
        ),
      ),
    );
    await tester.tap(find.byType(ContextHelpIcon));
    await tester.pumpAndSettle();
    expect(find.text('ما معنى كلمة متقنة؟'), findsOneWidget);
    final direction = tester.widget<Directionality>(
      find.ancestor(
        of: find.text('ما معنى كلمة متقنة؟'),
        matching: find.byType(Directionality),
      ).first,
    );
    expect(direction.textDirection, TextDirection.rtl);
  });

  testWidgets('the version line follows the installed package', (tester) async {
    PackageInfo.setMockInitialValues(
      appName: 'Lexora',
      packageName: 'com.hatemhusam.lexora',
      version: '1.0.0',
      buildNumber: '14',
      buildSignature: '',
    );
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: InstalledVersionText()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Version 1.0.0 (14)'), findsOneWidget);
  });

  testWidgets('an updated build number changes the version line', (tester) async {
    PackageInfo.setMockInitialValues(
      appName: 'Lexora',
      packageName: 'com.hatemhusam.lexora',
      version: '1.1.0',
      buildNumber: '20',
      buildSignature: '',
    );
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: InstalledVersionText()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('الإصدار 1.1.0 (20)'), findsOneWidget);
  });

  testWidgets('a package lookup failure still leaves a version line', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          installedPackageProvider.overrideWith((ref) async {
            throw StateError('missing');
          }),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: InstalledVersionText()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Version —'), findsOneWidget);
  });
}
