import 'package:flutter/material.dart';
import 'package:fit_tracker/core/base_viewmodel.dart';

/// AppViewModel manages global app state
/// Replaces: ThemeCubit, NavigationCubit
class AppViewModel extends BaseViewModel {
  ThemeMode _themeMode = ThemeMode.light;
  String _currentRoute = '/';

  ThemeMode get themeMode => _themeMode;
  String get currentRoute => _currentRoute;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setTheme(ThemeMode theme) {
    _themeMode = theme;
    notifyListeners();
  }

  void navigateToRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }
}
