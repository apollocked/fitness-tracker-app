import 'package:flutter/material.dart';

class InputThemeConfig {
  static InputDecorationTheme getInputDecorationTheme({
    required Color inputFill,
    required Color inputBorder,
    required Color primaryColor,
    required Color redColor,
    required Color subtitle,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: inputFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: inputBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: redColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: redColor, width: 2),
      ),
      labelStyle: TextStyle(color: subtitle, fontFamily: 'Rudaw'),
      hintStyle: TextStyle(color: subtitle, fontFamily: 'Rudaw'),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
    );
  }
}
