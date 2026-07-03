import 'package:flutter/material.dart';

class AppBarThemeConfig {
  static AppBarTheme getAppBarTheme({
    required Color bg,
    required Color text,
  }) {
    return AppBarTheme(
      backgroundColor: bg,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      foregroundColor: text,
      titleTextStyle: TextStyle(
        color: text,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0,
        fontFamily: 'Rudaw',
      ),
    );
  }
}
