import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_rule_check/password_rule_check.dart';
import 'package:password_rule_check/src/widgets/rule_item.dart';
import 'package:password_rule_check/src/widgets/rule_progress_bar.dart';

import 'mocks.dart';
import 'stub_localization_delegate.dart';

void main() {
  testWidgets('Rule Widget gets Created', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: PasswordRuleCheck(
            controller: TextEditingController(), ruleSet: PasswordRuleSet())));
    await tester.pump();

    expect(find.byType(PasswordRuleCheck), findsOneWidget);
  });

  group('Translation', () {
    testWidgets('Unknown Locale falls back to English', (tester) async {
      await tester.pumpWidget(MaterialApp(
          locale: Locale('ww'),
          supportedLocales: [Locale('ww')],
          localizationsDelegates: [StubMaterialLocalizationDelegate(), StubCupertinoLocalizationDelegate()],
          home: PasswordRuleCheck(
              controller: TextEditingController(),
              ruleSet: PasswordRuleSet(uppercase: 1))));
      await tester.pump();

      expect(
          (tester.widget(find.byType(RuleItem)) as RuleItem)
              .translation
              .runtimeType,
          EnglishTranslation);
    });
  });

  group('validate()', () {
    testWidgets(
        'if all rules are met '
        'returns true', (tester) async {
      final key = GlobalKey<PasswordRuleCheckState>();
      await tester.pumpWidget(MaterialApp(
          home: PasswordRuleCheck(
        key: key,
        controller: TextEditingController(text: 'A'),
        ruleSet: PasswordRuleSet(
          uppercase: 1,
        ),
      )));
      await tester.pump();

      expect(key.currentState?.validate(), true);
    });

    testWidgets(
        'if not rules are met '
        'returns true', (tester) async {
      final key = GlobalKey<PasswordRuleCheckState>();
      await tester.pumpWidget(MaterialApp(
          home: PasswordRuleCheck(
        key: key,
        controller: TextEditingController(),
        ruleSet: PasswordRuleSet(
          uppercase: 1,
        ),
      )));
      await tester.pump();

      expect(key.currentState?.validate(), false);
    });
  });

  group('RuleProgressBar', () {
    testWidgets('gets displayed', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: PasswordRuleCheck(
              controller: TextEditingController(),
              ruleSet: PasswordRuleSet(specialCharacters: 1))));
      await tester.pump();

      expect(find.byType(RuleProgressBar), findsOneWidget);
    });

    testWidgets('shows Error Color', (tester) async {
      final errorColor = Colors.pink;
      await tester.pumpWidget(MaterialApp(
          home: PasswordRuleCheck(
              controller: TextEditingController(),
              errorColor: errorColor,
              ruleSet: PasswordRuleSet(uppercase: 1))));
      await tester.pump();

      expect(
          ((tester.widget(find.descendant(
                      of: find.byType(RuleProgressBar),
                      matching: find.byType(DecoratedBox))) as DecoratedBox)
                  .decoration as BoxDecoration)
              .color,
          errorColor);
    });

    testWidgets('shows Success Color', (tester) async {
      final successColor = Colors.pink;
      await tester.pumpWidget(MaterialApp(
          home: PasswordRuleCheck(
              controller: TextEditingController(text: 'A'),
              successColor: successColor,
              ruleSet: PasswordRuleSet(uppercase: 1))));
      await tester.pump();

      expect(
          ((tester.widget(find.descendant(
                      of: find.byType(RuleProgressBar),
                      matching: find.byType(DecoratedBox))) as DecoratedBox)
                  .decoration as BoxDecoration)
              .color,
          successColor);
    });
  });

  group('TextElements', () {
    testWidgets('Shows Icon', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: PasswordRuleCheck(
        controller: TextEditingController(text: 'A'),
        ruleSet: PasswordRuleSet(
          specialCharacters: 1,
          uppercase: 1,
        ),
        showIcon: true,
      )));
      await tester.pump();

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byIcon(Icons.remove_circle_outline), findsOneWidget);
    });

    testWidgets('String used from Translation', (tester) async {
      final translation = MockTranslation();
      when(() => translation.specialCharacters(any())).thenReturn('');
      when(() => translation.minLength(any())).thenReturn('');
      when(() => translation.maxLength(any())).thenReturn('');
      when(() => translation.uppercase(any())).thenReturn('');
      when(() => translation.lowercase(any())).thenReturn('');
      when(() => translation.digits(any())).thenReturn('');

      await tester.pumpWidget(MaterialApp(
          home: SingleChildScrollView(
        child: PasswordRuleCheck(
          controller: TextEditingController(),
          translation: translation,
          ruleSet: PasswordRuleSet(
            uppercase: 1,
            lowercase: 1,
            minLength: 1,
            maxLength: 1,
            digits: 1,
            specialCharacters: 1,
          ),
        ),
      )));
      await tester.pumpAndSettle();

      verify(() => translation.specialCharacters(any())).called(1);
      verify(() => translation.minLength(any())).called(1);
      verify(() => translation.maxLength(any())).called(1);
      verify(() => translation.uppercase(any())).called(1);
      verify(() => translation.lowercase(any())).called(1);
      verify(() => translation.digits(any())).called(1);
    });
  });

  group('Suggested Safety Bar' ,() {
    testWidgets('Main Rule not met, shows error bar', (tester) async {
      final errorColor = Colors.pink;
      await tester.pumpWidget(MaterialApp(
          home: PasswordRuleCheck.suggestedSafety(
              controller: TextEditingController(text: 'a'),
              errorColor: errorColor,
              ruleSet: PasswordRuleSet(uppercase: 1),
          optimalRules: [],)));
      await tester.pump();

      expect(
          ((tester.widget(find.byType(DecoratedBox)) as DecoratedBox)
              .decoration as BoxDecoration)
              .color,
          errorColor);
    });


    testWidgets('Main Rule met, no optimal provided shows green', (tester) async {
      final successColor = Colors.pink;
      await tester.pumpWidget(MaterialApp(
          home: PasswordRuleCheck.suggestedSafety(
            controller: TextEditingController(text: 'A'),
            successColor: successColor,
            ruleSet: PasswordRuleSet(uppercase: 1),
            optimalRules: [],)));
      await tester.pump();

      expect(
          ((tester.widget(find.byType(DecoratedBox)) as DecoratedBox)
              .decoration as BoxDecoration)
              .color,
          successColor);
    });

    testWidgets('Optimal Rule met shows success color', (tester) async {
      final successColor = Colors.pink;
      await tester.pumpWidget(MaterialApp(
          home: PasswordRuleCheck.suggestedSafety(
            controller: TextEditingController(text: 'Aa'),
            successColor: successColor,
            ruleSet: PasswordRuleSet(uppercase: 1),
            optimalRules: [
              PasswordRuleSet(
                minLength: 2,
              )
            ],)));
      await tester.pump();

      expect(
          ((tester.widget(find.byType(DecoratedBox)) as DecoratedBox)
              .decoration as BoxDecoration)
              .color,
          successColor);
    });

    testWidgets('Minimum met, optimal not, shows accept color', (tester) async {
      final acceptColor = Colors.pink;
      await tester.pumpWidget(MaterialApp(
          home: PasswordRuleCheck.suggestedSafety(
            controller: TextEditingController(text: 'A'),
            acceptColor: acceptColor,
            ruleSet: PasswordRuleSet(uppercase: 1),
            optimalRules: [
              PasswordRuleSet(
                minLength: 2,
              )
            ],)));
      await tester.pump();

      expect(
          ((tester.widget(find.byType(DecoratedBox)) as DecoratedBox)
              .decoration as BoxDecoration)
              .color,
          acceptColor);
    });
  });
}
