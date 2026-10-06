import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/features/progress/domain/art_journey_language.dart';
import 'package:lexora/features/progress/domain/cefr_artwork.dart';
import 'package:lexora/features/progress/presentation/art_journey_language_controller.dart';
import 'package:lexora/features/progress/presentation/cefr_artwork_card.dart';
import 'package:lexora/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a saved art journey language is restored without following the app language', () async {
    SharedPreferences.setMockInitialValues({
      artJourneyLanguagePrefsKey: 'ar',
    });
    final first = ProviderContainer();
    addTearDown(first.dispose);
    expect(await first.read(artJourneyLanguageProvider.future), 'ar');
    await first.read(artJourneyLanguageProvider.notifier).select('en');
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(artJourneyLanguagePrefsKey), 'en');

    final second = ProviderContainer();
    addTearDown(second.dispose);
    expect(await second.read(artJourneyLanguageProvider.future), 'en');
  });

  testWidgets('English and Arabic journey copy do not rebuild a different painting', (tester) async {
    const ids = ['b1-city', 'b1-town'];
    Future<void> pump(String language) {
      return tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: CefrArtworkCard(
              level: 'B1',
              mastered: 2,
              total: 4,
              masteredEntryIds: ids,
              languageCode: language,
            ),
          ),
        ),
      );
    }

    await pump('en');
    expect(find.textContaining('Mastered'), findsOneWidget);
    expect(
      tester
          .widget<Directionality>(
            find
                .descendant(
                  of: find.byType(CefrArtworkCard),
                  matching: find.byType(Directionality),
                )
                .first,
          )
          .textDirection,
      TextDirection.ltr,
    );
    final englishPainter = tester.widget<CustomPaint>(
      find.byWidgetPredicate(
        (widget) => widget is CustomPaint && widget.painter is CefrWordArtPainter,
      ),
    ).painter! as CefrWordArtPainter;

    await pump('ar');
    expect(find.textContaining('مُتقَنة'), findsOneWidget);
    expect(
      tester
          .widget<Directionality>(
            find
                .descendant(
                  of: find.byType(CefrArtworkCard),
                  matching: find.byType(Directionality),
                )
                .first,
          )
          .textDirection,
      TextDirection.rtl,
    );
    final arabicPainter = tester.widget<CustomPaint>(
      find.byWidgetPredicate(
        (widget) => widget is CustomPaint && widget.painter is CefrWordArtPainter,
      ),
    ).painter! as CefrWordArtPainter;
    expect(arabicPainter.entryIds, englishPainter.entryIds);
    expect(arabicPainter.level, 'B1');
    expect(
      paintBlobsFor(level: 'B1', masteredEntryIds: englishPainter.entryIds)
          .map((blob) => (blob.x, blob.y, blob.color))
          .toList(),
      paintBlobsFor(level: 'B1', masteredEntryIds: arabicPainter.entryIds)
          .map((blob) => (blob.x, blob.y, blob.color))
          .toList(),
    );
  });
}
