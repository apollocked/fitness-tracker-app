import 'package:flutter/material.dart';

class BottomNavThemeConfig {
  static BottomNavigationBarThemeData getBottomNavTheme({
    required Color card,
    required Color primaryColor,
    required bool isDark,
  }) {
    return BottomNavigationBarThemeData(
      backgroundColor: card,
      selectedItemColor: primaryColor,
      unselectedItemColor: isDark ? Colors.grey[600] : Colors.grey[400],
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontFamily: 'Rudaw',
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontFamily: 'Rudaw',
      ),
    );
  }
}
