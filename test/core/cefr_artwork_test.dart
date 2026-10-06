import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/services/progress/achievement_catalog.dart';
import 'package:lexora/core/services/progress/learning_activity_store.dart';
import 'package:lexora/core/services/vocabulary/vocabulary_catalog_importer.dart';
import 'package:lexora/features/home/domain/whats_new.dart';
import 'package:lexora/features/progress/domain/cefr_artwork.dart';
import 'package:lexora/features/progress/presentation/catalog_progress_section.dart';
import 'package:lexora/features/progress/presentation/cefr_artwork_card.dart';
import 'package:lexora/l10n/app_localizations.dart';

const _catalog = '''
{
  "version": 1,
  "datasetType": "production",
  "entries": [
    {"id": "a1-one", "lemma": "one", "cefr": "A1", "pos": "noun", "definitionEn": "The number one.", "arabicMeaning": "واحد", "example": "One book.", "forms": ["one"]},
    {"id": "a1-two", "lemma": "two", "cefr": "A1", "pos": "noun", "definitionEn": "The number two.", "arabicMeaning": "اثنان", "example": "Two books.", "forms": ["two"]},
    {"id": "b1-one", "lemma": "city", "cefr": "B1", "pos": "noun", "definitionEn": "A large town.", "arabicMeaning": "مدينة", "example": "A busy city.", "forms": ["city"]},
    {"id": "b1-two", "lemma": "town", "cefr": "B1", "pos": "noun", "definitionEn": "A small city.", "arabicMeaning": "بلدة", "example": "A quiet town.", "forms": ["town"]}
  ]
}
''';

const _catalogUpdated = '''
{
  "version": 2,
  "datasetType": "production",
  "entries": [
    {"id": "a1-one", "lemma": "one", "cefr": "A1", "pos": "noun", "definitionEn": "The number one.", "arabicMeaning": "واحد", "example": "One book.", "forms": ["one"]},
    {"id": "a1-two", "lemma": "two", "cefr": "A1", "pos": "noun", "definitionEn": "The number two.", "arabicMeaning": "اثنان", "example": "Two books.", "forms": ["two"]},
    {"id": "b1-one", "lemma": "city", "cefr": "B1", "pos": "noun", "definitionEn": "A large town.", "arabicMeaning": "مدينة", "example": "A busy city.", "forms": ["city"]},
    {"id": "b1-two", "lemma": "town", "cefr": "B1", "pos": "noun", "definitionEn": "A small city.", "arabicMeaning": "بلدة", "example": "A quiet town.", "forms": ["town"]}
  ]
}
''';

void main() {
  test('mastered words are the only paint blobs', () {
    expect(artProgressFraction(mastered: 0, total: 2422), 0);
    expect(artProgressFraction(mastered: 1211, total: 2422), closeTo(0.5, 0.001));
    expect(artProgressFraction(mastered: 2422, total: 2422), 1);

    const none = <CatalogWordPaintStatus>[];
    expect(paintBlobsFor(level: 'B1', masteredEntryIds: masteredIdsForLevel('B1', none)), isEmpty);

    final one = masteredIdsForLevel('B1', const [
      CatalogWordPaintStatus(id: 'b1-city', level: 'B1', status: 'mastered'),
    ]);
    expect(paintBlobsFor(level: 'B1', masteredEntryIds: one), hasLength(1));

    final hundred = [
      for (var index = 0; index < 100; index++) 'b1-$index',
    ];
    expect(paintBlobsFor(level: 'B1', masteredEntryIds: hundred), hasLength(100));

    final all = [
      for (var index = 0; index < 2422; index++) 'b1-$index',
    ];
    expect(paintBlobsFor(level: 'B1', masteredEntryIds: all), hasLength(2422));
  });

  test('discovered and learning add no blob; mastered adds exactly one', () {
    const words = [
      CatalogWordPaintStatus(id: 'b1-seen', level: 'B1', status: 'discovered'),
      CatalogWordPaintStatus(id: 'b1-study', level: 'B1', status: 'learning'),
      CatalogWordPaintStatus(id: 'b1-done', level: 'B1', status: 'mastered'),
      CatalogWordPaintStatus(id: 'a1-done', level: 'A1', status: 'mastered'),
    ];
    final b1 = masteredIdsForLevel('B1', words);
    expect(b1, ['b1-done']);
    expect(paintBlobsFor(level: 'B1', masteredEntryIds: b1).single.entryId, 'b1-done');
    expect(
      paintBlobsFor(level: 'B1', masteredEntryIds: b1).any((blob) => blob.entryId == 'a1-done'),
      isFalse,
    );
  });

  test('a catalog word keeps one stable blob across rebuilds', () {
    final first = paintBlobFor(level: 'B1', entryId: 'develop');
    final again = paintBlobFor(level: 'B1', entryId: 'develop');
    expect(identical(first, again), isTrue);
    expect(again.x, first.x);
    expect(again.y, first.y);
    expect(again.color, first.color);
    expect(again.baseSize, first.baseSize);
    expect(again.stretch, first.stretch);
    expect(again.rotation, first.rotation);
    expect(first.x, inInclusiveRange(0.02, 0.98));
    expect(first.y, inInclusiveRange(0.02, 0.98));
    expect(first.baseSize, inInclusiveRange(5, 16));
    expect(first.stretch, inInclusiveRange(0.8, 3.1));
    expect(first.pointCount, inInclusiveRange(8, 12));
    expect(first.noiseX.toSet().length, greaterThan(1));

    final otherLevel = paintBlobFor(level: 'A1', entryId: 'develop');
    expect(
      otherLevel.x != first.x || otherLevel.y != first.y || otherLevel.color != first.color,
      isTrue,
    );
    expect(stableHash('B1:develop'), stableHash('B1:develop'));
    expect(stableHash('B1:develop'), isNot(stableHash('A1:develop')));
  });

  test('blobs spread across the canvas and mix colors', () {
    final blobs = [
      for (var index = 0; index < 400; index++)
        paintBlobFor(level: 'C1', entryId: 'word-$index'),
    ];
    expect(blobs.where((blob) => blob.x < 0.2).length, greaterThan(20));
    expect(blobs.where((blob) => blob.x > 0.8).length, greaterThan(20));
    expect(blobs.where((blob) => blob.y < 0.2).length, greaterThan(20));
    expect(blobs.where((blob) => blob.y > 0.8).length, greaterThan(20));
    expect(blobs.map((blob) => blob.color).toSet().length, greaterThan(8));
  });

  test('each level is an independent painting and stays open', () {
    expect(artProgressFraction(mastered: 10, total: 10), 1);
    expect(artProgressFraction(mastered: 4, total: 100), closeTo(0.04, 0.001));
    final shared = paintBlobFor(level: 'A1', entryId: 'city');
    final other = paintBlobFor(level: 'B1', entryId: 'city');
    expect(shared.x, isNot(other.x));
    for (final level in ['A1', 'A2', 'B1', 'B2', 'C1', 'C2']) {
      expect(levelArtIsOpen(level), isTrue);
      expect(levelArtPath(level.toLowerCase()), '/progress/level/$level');
    }
  });

  test('the painter repaints only when the mastered words or animation change', () {
    final painter = CefrWordArtPainter(
      level: 'B1',
      entryIds: const ['city', 'town'],
    );
    expect(
      painter.shouldRepaint(
        CefrWordArtPainter(level: 'B1', entryIds: const ['city', 'town']),
      ),
      isFalse,
    );
    expect(
      painter.shouldRepaint(
        CefrWordArtPainter(level: 'B1', entryIds: const ['town', 'city']),
      ),
      isTrue,
    );
    expect(
      painter.shouldRepaint(
        CefrWordArtPainter(
          level: 'B1',
          entryIds: const ['city', 'town'],
          appearingId: 'town',
          appearProgress: 0.4,
        ),
      ),
      isTrue,
    );
    expect(
      painter.shouldRepaint(
        CefrWordArtPainter(level: 'A1', entryIds: const ['city', 'town']),
      ),
      isTrue,
    );
  });

  test('discovered and learning do not complete a level; mastered does', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await VocabularyCatalogImporter(db).importJson(_catalog);
    final now = DateTime.utc(2026, 10, 5);
    await _status(db, 'a1-one', 'discovered', now);
    await _status(db, 'a1-two', 'learning', now);
    await _status(db, 'b1-one', 'reviewing', now);

    final before = await _mastered(db);
    expect(artProgressFraction(mastered: before['A1'] ?? 0, total: 2), 0);
    expect(artProgressFraction(mastered: before['B1'] ?? 0, total: 2), 0);
    await AchievementService(db).sync(now: now);
    expect(await _achievement(db, 'level-a1'), isNull);

    await _status(db, 'a1-one', 'mastered', now);
    await _status(db, 'a1-two', 'mastered', now);
    final after = await _mastered(db);
    expect(artProgressFraction(mastered: after['A1'] ?? 0, total: 2), 1);
    expect(artProgressFraction(mastered: after['B1'] ?? 0, total: 2), 0);

    await AchievementService(db).sync(now: now);
    final firstUnlock = await _achievement(db, 'level-a1');
    expect(firstUnlock, isNotNull);
    expect(firstUnlock!.celebrated, isFalse);
    expect(await _achievement(db, 'level-b1'), isNull);

    await AchievementService(db).markCelebrated('level-a1');
    await AchievementService(db).sync(now: now);
    final shown = await _achievement(db, 'level-a1');
    expect(shown!.celebrated, isTrue);
    final pending = await AchievementService(db).uncelebrated();
    expect(pending.where((row) => row.id == 'level-a1'), isEmpty);

    final definition = AchievementCatalog.byId('level-b1');
    expect(definition!.titleEn.toLowerCase(), contains('masterpiece'));
    expect(definition.titleEn.toLowerCase(), isNot(contains('your english level')));
    expect(definition.detailEn.toLowerCase(), contains('not an official cefr'));
  });

  test('a catalog update keeps mastered progress', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await VocabularyCatalogImporter(db).importJson(_catalog);
    final now = DateTime.utc(2026, 10, 5);
    await _status(db, 'b1-one', 'mastered', now);
    await VocabularyCatalogImporter(db).importJson(_catalogUpdated);
    final row = await (db.select(db.userVocabulary)
          ..where((item) => item.entryId.equals('b1-one')))
        .getSingle();
    expect(row.status, 'mastered');
    final totals = await db.customSelect(
      'SELECT COUNT(*) AS c FROM vocabulary_entries',
    ).getSingle();
    expect(totals.read<int>('c'), 4);
  });

  test('English and Arabic name the collection, not an official level', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final en = await AppLocalizations.delegate.load(const Locale('en'));
    final ar = await AppLocalizations.delegate.load(const Locale('ar'));
    expect(en.masterpieceCompleted('B1'), 'B1 Vocabulary Masterpiece Completed');
    expect(en.masteredCountOfTotal(1211, 2422), '1211 / 2422 mastered');
    expect(en.collectionNotOfficialLevel.toLowerCase(), contains('not an official'));
    expect(ar.masterpieceCompleted('B1'), 'اكتملت لوحة مفردات B1');
    expect(ar.vocabularyJourney, 'رحلة المفردات');
    expect(ar.collectionNotOfficialLevel, contains('CEFR'));
  });

  testWidgets('a level card opens that level', (tester) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: CefrArtworkCard(
              level: 'A2',
              mastered: 0,
              total: 4,
              onTap: () => context.push(levelArtPath('A2')),
            ),
          ),
        ),
        GoRoute(
          path: '/progress/level/:level',
          builder: (context, state) => Scaffold(
            body: Text('opened-${state.pathParameters['level']}'),
          ),
        ),
      ],
    );
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('A2'));
    await tester.pumpAndSettle();
    expect(find.text('opened-A2'), findsOneWidget);
    expect(find.text('0%'), findsNothing);
  });

  testWidgets('thousands of mastered words stay on one canvas', (tester) async {
    final ids = [for (var index = 0; index < 1000; index++) 'b1-$index'];
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CefrArtworkCard(
            level: 'B1',
            mastered: 1000,
            total: 2422,
            masteredEntryIds: ids,
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('1,000 / 2,422 Mastered'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is CustomPaint && widget.painter is CefrWordArtPainter,
      ),
      findsOneWidget,
    );
    expect(find.byType(Positioned), findsNothing);
    expect(find.byType(AnimatedContainer), findsNothing);
  });

  test('a new version note still shows once', () {
    expect(shouldShowWhatsNew(seen: null, current: '1.0.0+16'), isTrue);
    expect(shouldShowWhatsNew(seen: '1.0.0+15', current: '1.0.0+16'), isTrue);
    expect(shouldShowWhatsNew(seen: '1.0.0+16', current: '1.0.0+16'), isFalse);
  });

  test('the database paints only mastered ids of that level', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await VocabularyCatalogImporter(db).importJson(_catalog);
    final now = DateTime.utc(2026, 10, 5);
    await _status(db, 'a1-one', 'discovered', now);
    await _status(db, 'a1-two', 'learning', now);
    await _status(db, 'b1-one', 'mastered', now);
    final ids = await queryMasteredEntryIds(db);
    expect(ids['A1'], isNull);
    expect(ids['B1'], ['b1-one']);
    expect(
      paintBlobsFor(level: 'B1', masteredEntryIds: ids['B1']!).single.entryId,
      'b1-one',
    );
    expect(paintBlobsFor(level: 'A1', masteredEntryIds: ids['A1'] ?? const []), isEmpty);
  });
}

Future<void> _status(
  AppDatabase db,
  String id,
  String status,
  DateTime now,
) {
  return db.into(db.userVocabulary).insert(
        UserVocabularyCompanion.insert(
          entryId: id,
          status: Value(status),
          firstDiscoveredAt: now,
          discoveredIn: 'test',
          lastUsedAt: now,
        ),
        mode: InsertMode.insertOrReplace,
      );
}

Future<Map<String, int>> _mastered(AppDatabase db) async {
  final rows = await db.customSelect(
    '''
    SELECT e.cefr_level AS level, COUNT(*) AS c
    FROM user_vocabulary u
    JOIN vocabulary_entries e ON e.id = u.entry_id
    WHERE u.status = 'mastered'
    GROUP BY e.cefr_level
    ''',
  ).get();
  return {
    for (final row in rows) row.read<String>('level'): row.read<int>('c'),
  };
}

Future<UserAchievementRow?> _achievement(AppDatabase db, String id) {
  return (db.select(db.userAchievements)..where((row) => row.id.equals(id)))
      .getSingleOrNull();
}
