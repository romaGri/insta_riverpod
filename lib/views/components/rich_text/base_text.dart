import 'package:flutter/material.dart';
import 'package:insta_riverpod/views/components/rich_text/link_text.dart';

class BaseText {
  final String text;
  final TextStyle? textStyle;

  const BaseText({required this.text, this.textStyle});

  factory BaseText.plain({
    required String text,
    TextStyle? textStyle = const TextStyle(),
  }) =>
      BaseText(
        text: text,
        textStyle: textStyle,
      );

  factory BaseText.link({
    required String text,
    required VoidCallback onTapped,
    TextStyle? textStyle = const TextStyle(
      color: Colors.blue,
    ),
  }) =>
      LinkText(
        text: text,
        onTapped: onTapped,
        textStyle: textStyle,
      );
}
