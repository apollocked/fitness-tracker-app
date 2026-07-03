import 'package:flutter/material.dart';

class TextThemeConfig {
  static TextTheme getTextTheme({
    required Color text,
    required Color subtitle,
  }) {
    return TextTheme(
      headlineLarge: TextStyle(
        color: text,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: 0,
        fontFamily: 'Rudaw',
      ),
      titleLarge: TextStyle(
        color: text,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Rudaw',
      ),
      titleMedium: TextStyle(
        color: text,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Rudaw',
      ),
      bodyLarge: TextStyle(
        color: text,
        fontSize: 16,
        fontFamily: 'Rudaw',
      ),
      bodyMedium: TextStyle(
        color: subtitle,
        fontSize: 14,
        fontFamily: 'Rudaw',
      ),
      bodySmall: TextStyle(
        color: subtitle,
        fontSize: 12,
        fontFamily: 'Rudaw',
      ),
    );
  }
}
