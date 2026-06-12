import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/data/model/user_model.dart';
import 'package:fit_tracker/data/repositories/auth_repository.dart';
import 'package:fit_tracker/data/repositories/user_repository.dart';
import 'package:fit_tracker/data/services/notification_service.dart';

class AppViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final NotificationService _notificationService;

  AppViewModel(
    this._authRepository,
    this._userRepository, {
    NotificationService? notificationService,
  }) : _notificationService =
            notificationService ?? NotificationService.instance {
    syncWithUser(_authRepository.getCurrentUser(), notify: false);
  }

  // --- Theme ---
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> toggleTheme() => setDarkMode(!isDarkMode);

  Future<void> setDarkMode(bool isDark) async {
    final nextMode = isDark ? ThemeMode.dark : ThemeMode.light;
    if (_themeMode != nextMode) {
      _themeMode = nextMode;
      notifyListeners();
    }
    await _persistCurrentUser((user) => user.copyWith(darkMode: isDark));
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
  bool _notificationsEnabled = false;
  bool get notificationsEnabled => _notificationsEnabled;
  bool _settingsLoading = false;
  bool get settingsLoading => _settingsLoading;
  String? _settingsError;
  String? get settingsError => _settingsError;
  String? _successMessage;
  String? get successMessage => _successMessage;

  Future<bool> setNotifications(bool enabled) async {
    _settingsLoading = true;
    _settingsError = null;
    _successMessage = null;
    notifyListeners();

    try {
      if (enabled) {
        final granted =
            await _notificationService.requestNotificationPermission();
        if (!granted) {
          _notificationsEnabled = false;
          await _notificationService.cancelWeightReminder();
          await _persistCurrentUser(
            (user) => user.copyWith(notificationsEnabled: false),
          );
          _settingsLoading = false;
          _settingsError = 'Notification permission was not granted.';
          notifyListeners();
          return false;
        }

        final scheduled = await _notificationService.scheduleWeightReminder();
        if (!scheduled) {
          _notificationsEnabled = false;
          await _persistCurrentUser(
            (user) => user.copyWith(notificationsEnabled: false),
          );
          _settingsLoading = false;
          _settingsError = 'Unable to schedule notifications on this device.';
          notifyListeners();
          return false;
        }
      } else {
        await _notificationService.cancelWeightReminder();
      }

      _notificationsEnabled = enabled;
      await _persistCurrentUser(
        (user) => user.copyWith(notificationsEnabled: enabled),
      );
      _settingsLoading = false;
      _successMessage = enabled
          ? 'Weight reminder scheduled every three days.'
          : 'Notifications disabled.';
      notifyListeners();
      return true;
    } catch (_) {
      _settingsLoading = false;
      _settingsError = 'Failed to update notifications.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> toggleNotifications() =>
      setNotifications(!_notificationsEnabled);

  void syncWithUser(UserModel? user, {bool notify = true}) {
    // For guest users, settings are in-memory only and should not be overwritten
    // by the default false values in the ephemeral guest user object.
    if (user != null && user.id == '__guest__') return;

    final nextMode =
        (user?.darkMode ?? false) ? ThemeMode.dark : ThemeMode.light;
    final nextNotifications = user?.notificationsEnabled ?? false;
    final changed =
        _themeMode != nextMode || _notificationsEnabled != nextNotifications;

    _themeMode = nextMode;
    _notificationsEnabled = nextNotifications;

    if (changed) {
      if (nextNotifications) {
        unawaited(_notificationService.scheduleWeightReminder());
      } else {
        unawaited(_notificationService.cancelWeightReminder());
      }

      if (notify) {
        notifyListeners();
      }
    }
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

  Future<UserModel?> _persistCurrentUser(
    UserModel Function(UserModel user) update,
  ) async {
    final user = _authRepository.getCurrentUser();
    if (user == null || user.id == '__guest__') return null; // no persistence for guests

    final updated = update(user);
    await _userRepository.updateUser(updated);
    await _authRepository.setCurrentUser(updated);
    return updated;
  }
}
