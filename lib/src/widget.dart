import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// [RegexedText] A Text widget to provide additional functionality
/// for highlighting text that matches a given list of patterns
class RegexedText extends Text {
  /// [patterns] The list of patterns to match in the text.
  final List<RegExp> patterns;

  /// [normalStyle] The style to apply to normal (non-matching) text.
  final TextStyle normalStyle;

  /// [regexedStyle] A function that takes a RegExp and returns a TextStyle.
  // This function is used to get the style for each pattern.
  final TextStyle? Function(RegExp) regexedStyle;

  /// [onTap] The function to call when a highlighted text is tapped.
  final Function(String, RegExp)? onTap;

  const RegexedText(
    super.data, {
    super.key,
    required this.patterns,
    this.normalStyle = const TextStyle(color: Colors.black),
    required this.regexedStyle,
    super.maxLines,
    super.locale,
    super.overflow,
    super.selectionColor,
    super.semanticsLabel,
    super.softWrap,
    super.strutStyle,
    super.style,
    super.textAlign,
    super.textDirection,
    super.textHeightBehavior,
    super.textScaler,
    super.textWidthBasis,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: key,
      maxLines: maxLines,
      locale: locale,
      overflow: overflow ?? TextOverflow.clip,
      selectionColor: selectionColor,
      softWrap: softWrap ?? true,
      strutStyle: strutStyle,
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection,
      textHeightBehavior: textHeightBehavior,
      textScaler: textScaler ?? TextScaler.noScaling,
      textWidthBasis: textWidthBasis ?? TextWidthBasis.parent,
      text: _highlightText(data ?? ''),
    );
  }

  // This method generates a TextSpan that contains the highlighted and normal text.
  TextSpan _highlightText(String text) {
    // This list will hold all the TextSpans.
    final spans = <TextSpan>[];

    // Split the text into words.
    final words = text.split(' ');

    // Iterate over each word in the list.
    for (var word in words) {
      // Initialize a variable to hold the style & matched pattern for the current word.
      TextStyle? style;
      RegExp? match;

      // Iterate over each pattern in the list.
      for (var pattern in patterns) {
        // If the pattern matches the word, get the style for this pattern.
        if (pattern.hasMatch(word)) {
          style = regexedStyle(pattern);
          match = pattern;
          // Break the loop as soon as a match is found.
          break;
        }
      }

      // Add a TextSpan for the current word to the list.
      // If the word matches a pattern, use the corresponding style.
      // Otherwise, use the normal style.
      // If the word matches a pattern, also add a tap recognizer that calls the onTap function when the word is tapped.
      spans.add(
        TextSpan(
          text: '$word ',
          style: style ?? normalStyle,
          recognizer: (style != null && onTap != null)
              ? (TapGestureRecognizer()..onTap = () => onTap!(word, match!))
              : null,
        ),
      );
    }

    // Return a TextSpan that includes all the TextSpans in the list.
    return TextSpan(children: spans);
  }
}
