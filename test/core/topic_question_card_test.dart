import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/services/topics/topic_question_payload.dart';
import 'package:lexora/features/topics/presentation/topic_question_card.dart';
import 'package:lexora/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('show answer reveals both languages and hide answer removes them', (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    const payload = TopicQuestionPayload(
      type: 'conversation',
      answerEn: 'I want to study cybersecurity because I am interested in protecting systems and data.',
      answerAr: 'أريد دراسة الأمن السيبراني لأنني مهتم بحماية الأنظمة والبيانات.',
      options: [],
      correctOptionId: null,
    );
    await tester.pumpWidget(
      _app(
        TopicQuestionCard(
          promptEn: 'Why do you want to study cybersecurity?',
          promptAr: 'لماذا تريد دراسة الأمن السيبراني؟',
          payload: payload,
          answerController: controller,
          onSubmit: () {},
        ),
      ),
    );
    expect(find.text('Why do you want to study cybersecurity?'), findsOneWidget);
    expect(find.text('لماذا تريد دراسة الأمن السيبراني؟'), findsOneWidget);
    expect(find.text(payload.answerEn), findsNothing);
    expect(find.text(payload.answerAr), findsNothing);

    expect(
      tester
          .widget<Directionality>(
            find
                .ancestor(
                  of: find.text('Why do you want to study cybersecurity?'),
                  matching: find.byType(Directionality),
                )
                .first,
          )
          .textDirection,
      TextDirection.ltr,
    );
    expect(
      tester.widget<Text>(find.text('لماذا تريد دراسة الأمن السيبراني؟')).textDirection,
      TextDirection.rtl,
    );

    await tester.tap(find.text('Show Answer'));
    await tester.pumpAndSettle();
    expect(find.text(payload.answerEn), findsOneWidget);
    expect(find.text(payload.answerAr), findsOneWidget);
    expect(find.text('Hide Answer'), findsOneWidget);

    await tester.tap(find.text('Hide Answer'));
    await tester.pumpAndSettle();
    expect(find.text(payload.answerEn), findsNothing);
    expect(find.text(payload.answerAr), findsNothing);
    expect(find.text('Show Answer'), findsOneWidget);
  });

  testWidgets('a question with no suggested answer does not show an empty answer box', (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _app(
        TopicQuestionCard(
          promptEn: 'Say hello.',
          promptAr: '',
          payload: const TopicQuestionPayload(
            type: 'conversation',
            answerEn: '',
            answerAr: '',
            options: [],
            correctOptionId: null,
          ),
          answerController: controller,
          onSubmit: () {},
        ),
      ),
    );
    expect(find.text('Say hello.'), findsOneWidget);
    expect(find.text('Show Answer'), findsNothing);
    expect(find.text('Suggested answer'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}

Widget _app(Widget child) {
  return MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}
