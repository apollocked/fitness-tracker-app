import 'package:flutter/material.dart';
import 'package:fit_tracker/config/theme/app_theme.dart';
import 'package:fit_tracker/features/auth/data/models/user_model.dart';
import 'package:fit_tracker/features/auth/data/repositories/auth_repository.dart';
import 'package:fit_tracker/features/auth/data/repositories/user_repository.dart';

class AppViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AppViewModel(this._authRepository, this._userRepository);

  // --- Theme ---
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void setDarkMode(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData get theme => isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

  // --- Navigation ---
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  void resetNavigation() {
    _currentIndex = 0;
    notifyListeners();
  }

  // --- Settings ---
  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;
  bool _settingsLoading = false;
  bool get settingsLoading => _settingsLoading;
  String? _settingsError;
  String? get settingsError => _settingsError;
  String? _successMessage;
  String? get successMessage => _successMessage;

  void setNotifications(bool enabled) {
    _notificationsEnabled = enabled;
    notifyListeners();
  }

  void toggleNotifications() {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
  }

  void clearMessages() {
    _settingsError = null;
    _successMessage = null;
    notifyListeners();
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    _settingsLoading = true;
    _settingsError = null;
    _successMessage = null;
    notifyListeners();
    try {
      final user = _authRepository.getCurrentUser();
      if (user == null) {
        _settingsLoading = false;
        _settingsError = 'No user logged in';
        notifyListeners();
        return false;
      }
      if (user.password != oldPassword) {
        _settingsLoading = false;
        _settingsError = 'Old password is incorrect';
        notifyListeners();
        return false;
      }
      final updated = user.copyWith(password: newPassword);
      await _userRepository.updateUser(updated);
      await _authRepository.setCurrentUser(updated);
      _settingsLoading = false;
      _successMessage = 'Password changed successfully!';
      notifyListeners();
      return true;
    } catch (e) {
      _settingsLoading = false;
      _settingsError = 'Failed to change password';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProfile(String username, String email) async {
    _settingsLoading = true;
    _settingsError = null;
    _successMessage = null;
    notifyListeners();
    try {
      final user = _authRepository.getCurrentUser();
      if (user == null) {
        _settingsLoading = false;
        _settingsError = 'No user logged in';
        notifyListeners();
        return false;
      }
      final updated = user.copyWith(username: username, email: email);
      await _userRepository.updateUser(updated);
      await _authRepository.setCurrentUser(updated);
      _settingsLoading = false;
      _successMessage = 'Profile updated successfully!';
      notifyListeners();
      return true;
    } catch (e) {
      _settingsLoading = false;
      _settingsError = 'Failed to update profile';
      notifyListeners();
      return false;
    }
  }
}
