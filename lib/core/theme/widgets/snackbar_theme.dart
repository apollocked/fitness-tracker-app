import 'package:flutter/material.dart';

class SnackBarThemeConfig {
  static SnackBarThemeData getSnackBarTheme({
    required Color backgroundColor,
    required bool isDark,
  }) {
    return SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      contentTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: 'Rudaw',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
