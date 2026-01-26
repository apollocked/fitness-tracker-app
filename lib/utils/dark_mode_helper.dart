import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

bool isDarkMode() => currentUser?['darkMode'] ?? false;

Color getCardColor() {
  return isDarkMode() ? darkCard : backgroundColor;
}

Color getBackgroundColor() {
  return isDarkMode() ? darkBg : Colors.grey[100]!;
}

Color getTextColor() {
  return isDarkMode() ? darkText : Colors.black87;
}

Color getSubtitleColor() {
  return isDarkMode() ? Colors.grey[400]! : Colors.grey[600]!;
}

Color getCardDecorationColor() {
  return isDarkMode() ? Colors.grey[800]! : Colors.white;
}

BoxDecoration getCardDecoration() {
  return BoxDecoration(
    color: getCardColor(),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: isDarkMode()
            ? Colors.black.withOpacity(0.3)
            : Colors.grey.withOpacity(0.1),
        spreadRadius: 1,
        blurRadius: 5,
      ),
    ],
  );
}
