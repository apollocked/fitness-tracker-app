import 'package:flutter/material.dart';

class ButtonThemeConfig {
  static ElevatedButtonThemeData getElevatedButtonTheme({
    required Color primaryColor,
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Rudaw',
        ),
      ),
    );
  }
}
