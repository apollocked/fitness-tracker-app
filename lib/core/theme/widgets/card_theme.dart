import 'package:flutter/material.dart';

class CardThemeConfig {
  static CardThemeData getCardTheme({
    required Color card,
  }) {
    return CardThemeData(
      color: card,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
