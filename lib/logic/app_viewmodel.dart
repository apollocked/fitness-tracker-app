import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/data/model/user_model.dart';
import 'package:fit_tracker/data/repositories/auth_repository.dart';
import 'package:fit_tracker/data/repositories/user_repository.dart';
import 'package:fit_tracker/data/services/notification_service.dart';
import 'package:fit_tracker/data/services/registration_validator.dart';
import 'package:fit_tracker/data/services/hive_storage_service.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

const _guestNotificationsKey = 'guest_notifications_enabled';
const _localeStorageKey = 'app_locale';

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
    _loadLocale();
    syncWithUser(_authRepository.getCurrentUser(), notify: false);
  }

  // --- Theme ---
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> setDarkMode(bool isDark) async {
    final nextMode = isDark ? ThemeMode.dark : ThemeMode.light;
    if (_themeMode != nextMode) {
      _themeMode = nextMode;
      notifyListeners();
    }
    final user = _authRepository.getCurrentUser();
    if (user != null && user.id == '__guest__') {
      await HiveStorageService.setGuestDarkMode(isDark);
    } else {
      await _persistCurrentUser((user) => user.copyWith(darkMode: isDark));
    }
  }

  ThemeData get theme => isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

  // --- Locale ---
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  Future<void> setLocale(String languageCode) async {
    _locale = Locale(languageCode);
    notifyListeners();
    await HiveStorageService.saveString(_localeStorageKey, languageCode);
  }

  String get localeCode => _locale.languageCode;

  void _loadLocale() {
    final stored = HiveStorageService.getString(_localeStorageKey);
    if (stored != null && stored.isNotEmpty) {
      _locale = Locale(stored);
    }
  }

  // --- Navigation ---
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
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
  String? _errorCode;
  String? get errorCode => _errorCode;

  Future<bool> setNotifications(bool enabled) async {
    _settingsLoading = true;
    _settingsError = null;
    _errorCode = null;
    _successMessage = null;
    notifyListeners();

    try {
      if (enabled) {
        final result =
            await _notificationService.requestNotificationPermission();

        if (result == NotificationPermissionResult.permanentlyDenied) {
          _notificationsEnabled = false;
          await _notificationService.cancelWeightReminder();
          await _persistNotificationState(false);
          _settingsLoading = false;
          _settingsError = null;
          _errorCode = 'notificationBlocked';
          notifyListeners();
          return false;
        }

        if (result == NotificationPermissionResult.denied) {
          _notificationsEnabled = false;
          await _notificationService.cancelWeightReminder();
          await _persistNotificationState(false);
          _settingsLoading = false;
          _settingsError = null;
          _errorCode = 'notificationDenied';
          notifyListeners();
          return false;
        }

        final scheduled = await _notificationService.scheduleWeightReminder();
        if (!scheduled) {
          _notificationsEnabled = false;
          await _persistNotificationState(false);
          _settingsLoading = false;
          _settingsError = null;
          _errorCode = 'notificationSchedule';
          notifyListeners();
          return false;
        }
      } else {
        await _notificationService.cancelWeightReminder();
      }

      _notificationsEnabled = enabled;
      await _persistNotificationState(enabled);
      _settingsLoading = false;
      _successMessage = null;
      _errorCode = enabled ? null : 'notificationsDisabled';
      notifyListeners();
      return true;
    } catch (_) {
      _settingsLoading = false;
      _settingsError = null;
      _errorCode = 'notificationUpdate';
      notifyListeners();
      return false;
    }
  }

  Future<void> _persistNotificationState(bool enabled) async {
    final user = _authRepository.getCurrentUser();
    if (user == null) return;
    if (user.id == '__guest__') {
      await HiveStorageService.saveString(
          _guestNotificationsKey, enabled.toString());
    } else {
      await _persistCurrentUser(
        (u) => u.copyWith(notificationsEnabled: enabled),
      );
    }
  }

  void syncWithUser(UserModel? user, {bool notify = true}) {
    if (user != null && user.id == '__guest__') {
      final guestDark = HiveStorageService.getGuestDarkMode();
      final guestMode = guestDark ? ThemeMode.dark : ThemeMode.light;
      final guestNotif =
          HiveStorageService.getString(_guestNotificationsKey) == 'true';
      final changed =
          _themeMode != guestMode || _notificationsEnabled != guestNotif;

      _themeMode = guestMode;
      _notificationsEnabled = guestNotif;

      if (changed) {
        if (guestNotif) {
          unawaited(_notificationService.scheduleWeightReminder());
        } else {
          unawaited(_notificationService.cancelWeightReminder());
        }
        if (notify) notifyListeners();
      }
      return;
    }

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
    _errorCode = null;
    _successMessage = null;
    notifyListeners();
  }

  Future<bool> updateProfile(String username, AppLocalizations l10n) async {
    _settingsLoading = true;
    _settingsError = null;
    _errorCode = null;
    _successMessage = null;
    notifyListeners();

    final validator = RegistrationValidator(l10n);
    final validationError = validator.validateUsername(username);
    if (validationError != null) {
      _settingsLoading = false;
      _settingsError = validationError;
      notifyListeners();
      return false;
    }

    try {
      final user = _authRepository.getCurrentUser();
      if (user == null) {
        _settingsLoading = false;
        _settingsError = null;
        _errorCode = 'noUserLoggedIn';
        notifyListeners();
        return false;
      }
      if (username != user.username &&
          _authRepository.usernameExists(username)) {
        _settingsLoading = false;
        _settingsError = null;
        _errorCode = 'usernameTaken';
        notifyListeners();
        return false;
      }
      final updated = user.copyWith(username: username);
      await _userRepository.updateUser(updated);
      await _authRepository.setCurrentUser(updated);
      _settingsLoading = false;
      _successMessage = null;
      _errorCode = 'profileUpdated';
      notifyListeners();
      return true;
    } catch (e) {
      _settingsLoading = false;
      _settingsError = null;
      _errorCode = 'profileUpdate';
      notifyListeners();
      return false;
    }
  }

  Future<UserModel?> _persistCurrentUser(
    UserModel Function(UserModel user) update,
  ) async {
    final user = _authRepository.getCurrentUser();
    if (user == null || user.id == '__guest__') return null;

    final updated = update(user);
    await _userRepository.updateUser(updated);
    await _authRepository.setCurrentUser(updated);
    return updated;
  }
}
