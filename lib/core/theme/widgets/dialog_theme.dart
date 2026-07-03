import 'package:flutter/material.dart';

class DialogThemeConfig {
  static DialogThemeData getDialogTheme({
    required Color card,
    required Color text,
  }) {
    return DialogThemeData(
      backgroundColor: card,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titleTextStyle: TextStyle(
        color: text,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Rudaw',
      ),
    );
  }
}
