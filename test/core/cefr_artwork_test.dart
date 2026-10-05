import 'dart:math' as math;

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
  test('artwork progress follows mastered words only', () {
    expect(artProgressFraction(mastered: 0, total: 2422), 0);
    expect(visibleArtRegions(mastered: 0, total: 2422), 0);
    expect(artProgressFraction(mastered: 1211, total: 2422), closeTo(0.5, 0.001));
    expect(visibleArtRegions(mastered: 50, total: 100), 90);
    expect(artProgressFraction(mastered: 2422, total: 2422), 1);
    expect(visibleArtRegions(mastered: 2422, total: 2422), cefrArtRegionCount);
    expect(artProgressFraction(mastered: 0, total: 0), 0);
    expect(visibleArtRegions(mastered: 4, total: 0), 0);
    expect(artProgressFraction(mastered: 3, total: 2), 1);
  });

  test('words added in sentences and the word list color that level only', () {
    const progress = CatalogProgress(
      totals: {'A1': 4, 'B1': 10},
      discovered: {'B1': 3},
      learning: {'A1': 1},
      masteredByLevel: {'B1': 1},
      personalByLevel: {'A1': 2},
      mastered: 1,
      academic: 0,
      ielts: 0,
      toefl: 0,
      discoveredThisWeek: 0,
    );
    expect(progress.recognizedFor('B1'), 4);
    expect(progress.recognizedFor('A1'), 3);
    expect(progress.recognizedFor('A2'), 0);
    expect(paintingWordCount(recognized: 4, total: 10), 4);
    expect(
      visibleArtRegions(mastered: progress.recognizedFor('B1'), total: 10),
      greaterThan(0),
    );
    expect(shouldShowWhatsNew(seen: null, current: '1.0.0+15'), isTrue);
    expect(shouldShowWhatsNew(seen: '1.0.0+14', current: '1.0.0+15'), isTrue);
    expect(shouldShowWhatsNew(seen: '1.0.0+15', current: '1.0.0+15'), isFalse);
  });

  test('each level is an independent painting', () {
    expect(artProgressFraction(mastered: 10, total: 10), 1);
    expect(artProgressFraction(mastered: 4, total: 100), closeTo(0.04, 0.001));
    expect(sceneAnchorsFor('A1').length, isNot(sceneAnchorsFor('C2').length));
    expect(artRegionsFor('A1').first.x, isNot(artRegionsFor('B2').first.x));
  });

  test('previous levels stay open and completed art stays fully revealed', () {
    for (final level in ['A1', 'A2', 'B1', 'B2', 'C1', 'C2']) {
      expect(levelArtIsOpen(level), isTrue);
      expect(levelArtPath(level.toLowerCase()), '/progress/level/$level');
    }
    expect(
      visibleArtRegions(mastered: 80, total: 80),
      cefrArtRegionCount,
    );
  });

  test('reveal masks are deterministic and not a left-to-right bar', () {
    final first = artRegionsFor('B1');
    final again = artRegionsFor('B1');
    expect(identical(first, again), isTrue);
    expect(first.length, cefrArtRegionCount);
    expect(stableHash('B1:city'), stableHash('B1:city'));
    expect(stableHash('B1:city'), isNot(stableHash('A1:city')));

    final random = math.Random(stableHash('lexora-art-mask-B1'));
    final jitterX = (random.nextDouble() - 0.5) * 0.045;
    final expectedX = ((0.5) / 15 + jitterX).clamp(0.02, 0.98);
    expect(
      first.any((region) => (region.x - expectedX).abs() < 0.000001),
      isTrue,
    );

    final ordered = [...first]..sort((a, b) => a.order.compareTo(b.order));
    var inversions = 0;
    for (var index = 1; index < ordered.length; index++) {
      if (ordered[index].x < ordered[index - 1].x) inversions++;
    }
    expect(inversions, greaterThan(40));
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
    expect(en.masterpieceCompleted('B1'), 'B1 masterpiece completed');
    expect(en.masteredCountOfTotal(1211, 2422), '1211 / 2422 mastered');
    expect(en.collectionNotOfficialLevel.toLowerCase(), contains('not an official'));
    expect(ar.masterpieceCompleted('B1'), 'اكتملت لوحة B1');
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
