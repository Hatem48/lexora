import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/features/home/presentation/today_plan_screen.dart';

void main() {
  testWidgets('a finished task stays, with a check and a strike', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DailyTaskTile(
            title: 'Review what is due',
            detail: '3 items',
            done: true,
            onOpen: () {},
            onToggle: () {},
          ),
        ),
      ),
    );
    final title = tester.widget<Text>(find.text('Review what is due'));
    expect(title.style?.decoration, TextDecoration.lineThrough);
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    expect(find.text('Review what is due'), findsOneWidget);
  });
}
