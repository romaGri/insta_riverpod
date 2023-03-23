import 'package:flutter/material.dart';
import 'package:insta_riverpod/extensions/string/as_html_color.dart';

class AppColors {
  static final loginButtonColor = '#eadff5'.htmlColorToColor();
  static const loginButtonTextColor = Colors.black;
  static final googleColor = '#4285F4'.htmlColorToColor();

  const AppColors._();
}
