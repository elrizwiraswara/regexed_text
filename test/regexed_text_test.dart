import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:regexed_text/regexed_text.dart';

void main() {
  group('RegexedText Widget Tests', () {
    testWidgets('RegexedText has correct TextSpans and styles', (tester) async {
      TextStyle regexedStyle = const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.w600,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RegexedText(
              'This is a @sample text with username pattern to highlight',
              patterns: [usernamePattern],
              regexedStyle: (pattern) {
                return regexedStyle;
              },
            ),
          ),
        ),
      );

      final richTextFinder = find.byType(RichText);
      expect(richTextFinder, findsOneWidget);

      final richText = tester.firstWidget<RichText>(richTextFinder);
      final textSpan = richText.text as TextSpan;

      final highlightedText = textSpan.children?.where(
        (e) => e.style == regexedStyle,
      );

      expect(highlightedText, isNotNull);
    });

    testWidgets('The onTap callback is triggered on the highlighted text',
        (tester) async {
      TextStyle regexedStyle = const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.w600,
      );

      String? tappedText;
      RegExp? tappedPattern;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RegexedText(
              'This is a @sample text with username pattern to highlight',
              patterns: [usernamePattern],
              regexedStyle: (pattern) {
                return regexedStyle;
              },
              onTap: (text, pattern) {
                tappedText = text;
                tappedPattern = pattern;
              },
            ),
          ),
        ),
      );

      final highlightedText = find.textRange.ofSubstring('@sample');

      expect(highlightedText, findsOneWidget);

      await tester.tapOnText(highlightedText);
      await tester.pumpAndSettle();

      expect(tappedText, '@sample');
      expect(tappedPattern, usernamePattern);
    });
  });
}
