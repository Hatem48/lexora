import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/database/app_database.dart';
import 'package:lexora/core/widgets/content_filter_sheet.dart';
import 'package:lexora/core/widgets/lexora_widgets.dart';
import 'package:lexora/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('the filter sheet is requested before categories finish loading', () async {
    final launch = ContentFilterLaunch();
    final gate = Completer<List<CategoryRow>>();
    var openedWhilePending = false;
    final opened = openContentFilters(
      launch: launch,
      cached: null,
      loadCategories: () => gate.future,
      show: (categories, categoriesFuture) {
        openedWhilePending = categoriesFuture != null && !gate.isCompleted;
        expect(categories, isEmpty);
        return Future<ContentFilterState?>.value(const ContentFilterState(cefr: 'A2'));
      },
    );
    await Future<void>.delayed(Duration.zero);
    expect(openedWhilePending, isTrue);
    expect(gate.isCompleted, isFalse);
    gate.complete(const []);
    expect((await opened)?.cefr, 'A2');
    expect(launch.busy, isFalse);
  });

  test('a second tap does not open another sheet and a failure releases the launch', () async {
    final launch = ContentFilterLaunch();
    final hold = Completer<ContentFilterState?>();
    final first = openContentFilters(
      launch: launch,
      cached: const [],
      loadCategories: () async => const [],
      show: (_, _) => hold.future,
    );
    final second = await openContentFilters(
      launch: launch,
      cached: const [],
      loadCategories: () async => const [],
      show: (_, _) async => const ContentFilterState(),
    );
    expect(second, isNull);
    hold.complete(null);
    expect(await first, isNull);
    expect(launch.busy, isFalse);

    final failed = ContentFilterLaunch();
    await expectLater(
      openContentFilters(
        launch: failed,
        cached: null,
        loadCategories: () => throw StateError('db'),
        show: (_, _) async => null,
      ),
      throwsStateError,
    );
    expect(failed.busy, isFalse);
  });

  test('words and sentences no longer disable the filter button while waiting', () {
    for (final path in [
      'lib/features/words/presentation/words_screen.dart',
      'lib/features/sentences/presentation/sentences_screen.dart',
    ]) {
      final source = File(path).readAsStringSync();
      expect(source.contains('openContentFilters'), isTrue);
      expect(source.contains('_filterLaunch.busy ? null'), isFalse);
    }
  });

  testWidgets('filter UI shows the current selection before categories arrive', (tester) async {
    final gate = Completer<List<CategoryRow>>();
    ContentFilterState? applied;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return TextButton(
                onPressed: () async {
                  applied = await showContentFilterSheet(
                    context: context,
                    initial: const ContentFilterState(cefr: 'B1'),
                    categories: const [],
                    categoriesFuture: gate.future,
                  );
                },
                child: const Text('Filter'),
              );
            },
          ),
        ),
      ),
    );
    await tester.tap(find.text('Filter'));
    await tester.pump();
    expect(find.text('Filters'), findsOneWidget);
    expect(
      tester.widget<FilterChip>(find.widgetWithText(FilterChip, 'B1')).selected,
      isTrue,
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(gate.isCompleted, isFalse);

    gate.complete(const []);
    await tester.pump();
    tester.widget<FilterChip>(find.widgetWithText(FilterChip, 'A2')).onSelected!(true);
    await tester.pump();
    tester.widget<LexoraPrimaryButton>(find.byType(LexoraPrimaryButton)).onPressed!.call();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(applied?.cefr, 'A2');
  });

  testWidgets('dismissing the filter sheet does not apply a new selection', (tester) async {
    ContentFilterState? applied = const ContentFilterState(cefr: 'B1');
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return TextButton(
                onPressed: () async {
                  final next = await showContentFilterSheet(
                    context: context,
                    initial: applied!,
                    categories: const [],
                  );
                  if (next != null) applied = next;
                },
                child: const Text('Filter'),
              );
            },
          ),
        ),
      ),
    );
    await tester.tap(find.text('Filter'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilterChip, 'C1'));
    await tester.pump();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(applied?.cefr, 'B1');
  });
}
