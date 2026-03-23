import 'package:flutter/material.dart';
import 'package:myapp/utils/app_theme.dart';
import 'package:myapp/utils/user_data.dart';

class ThemeProvider extends ChangeNotifier {
  late bool _isDarkMode;

  ThemeProvider() {
    _init();
  }

  void _init() {
    if (currentUser != null) {
      _isDarkMode = currentUser!['darkMode'] ?? false;
    } else {
      _isDarkMode = false;
    }
  }

  /// Synchronizes the theme state with the current user's preferences.
  /// Call this after login, logout, or user data updates.
  void syncWithCurrentUser() {
    _init();
    notifyListeners();
  }

  bool get isDarkMode => _isDarkMode;

  /// Returns the appropriate ThemeData based on the current mode.
  ThemeData get themeData =>
      _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

  /// Returns the current ThemeMode for MaterialApp.
  ThemeMode get themeMode =>
      _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;

    // Update user data
    if (currentUser != null) {
      currentUser!['darkMode'] = _isDarkMode;
      await updateUser(currentUser!['id'], currentUser!);
    }
    notifyListeners();
  }

  Future<void> setTheme(bool isDark) async {
    if (_isDarkMode == isDark) return;

    _isDarkMode = isDark;

    // Update user data
    if (currentUser != null) {
      currentUser!['darkMode'] = _isDarkMode;
      await updateUser(currentUser!['id'], currentUser!);
    }

    notifyListeners();
  }

  void updateTheme() {
    notifyListeners();
  }
}
