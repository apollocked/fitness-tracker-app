import 'package:flutter/material.dart';
import 'package:myapp/utils/user_data.dart';

class ThemeProvider extends ChangeNotifier {
  late bool _isDarkMode;

  ThemeProvider() {
    // Initialize dark mode from current user or default
    if (currentUser != null) {
      _isDarkMode = currentUser!['darkMode'] ?? false;
    } else {
      _isDarkMode = false;
    }
  }

  bool get isDarkMode => _isDarkMode;

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;

    // Update user data
    if (currentUser != null) {
      currentUser!['darkMode'] = _isDarkMode;
      await updateUser(currentUser!['id'], currentUser!);
    }
    await Future.delayed(Duration(seconds: 1));
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
    await Future.delayed(Duration(seconds: 1));

    notifyListeners();
  }
}
