import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:fit_tracker/data/model/user_model.dart';
import 'package:fit_tracker/data/repositories/auth_repository.dart';
import 'package:fit_tracker/data/repositories/user_repository.dart';
import 'package:fit_tracker/data/services/hive_storage_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthViewModel(this._authRepository, this._userRepository) {
    _user = _authRepository.getCurrentUser();
  }

  UserModel? _user;
  bool _isLoading = false;
  String? _error;
  String? _errorCode;

  UserModel? get currentUser => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get errorCode => _errorCode;
  bool get isLoggedIn => _user != null;
  bool get isGuest => _user?.id == '__guest__';

  // ── Rate limiting ──
  final Map<String, int> _attemptCount = {};
  final Map<String, DateTime> _lastAttemptTime = {};
  static const int _maxAttempts = 5;
  static const Duration _lockoutDuration = Duration(minutes: 1);

  bool isLockedOut(String username) {
    final last = _lastAttemptTime[username];
    final attempts = _attemptCount[username] ?? 0;
    if (last == null || attempts < _maxAttempts) return false;
    final elapsed = DateTime.now().difference(last);
    final remaining = _lockoutDuration - elapsed;
    if (remaining.isNegative) return false;
    _errorCode = 'lockout';
    _error = null;
    return true;
  }

  Future<void> login(String username, String passkey) async {
    if (isLockedOut(username)) {
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    _errorCode = null;
    notifyListeners();
    try {
      final user = await _authRepository.login(username, passkey);
      if (user == null) {
        _isLoading = false;
        _attemptCount[username] = (_attemptCount[username] ?? 0) + 1;
        _lastAttemptTime[username] = DateTime.now();
        final remaining = _maxAttempts - (_attemptCount[username] ?? 0);
        _error = null;
        _errorCode = remaining > 0 ? 'invalidCredentials' : 'lockedOut';
      } else {
        _attemptCount.remove(username);
        _lastAttemptTime.remove(username);
        _user = user;
        _isLoading = false;
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = null;
      _errorCode = 'loginFailed';
      notifyListeners();
    }
  }

  Future<void> loginAsGuest() async {
    _isLoading = true;
    _error = null;
    _errorCode = null;
    notifyListeners();
    try {
      final guest = await _authRepository.loginAsGuest();
      _user = guest;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = null;
      _errorCode = 'guestSessionFailed';
      notifyListeners();
    }
  }

  Future<void> register(UserModel user) async {
    _isLoading = true;
    _error = null;
    _errorCode = null;
    notifyListeners();
    try {
      // Double-check username doesn't exist (TOCTOU guard)
      if (_authRepository.usernameExists(user.username)) {
        _isLoading = false;
        _error = null;
        _errorCode = 'usernameTaken';
        notifyListeners();
        return;
      }
      final newUser = await _authRepository.register(user);
      _user = newUser;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = null;
      _errorCode = 'registrationFailed';
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _user = null;
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    if (_user == null) return;
    final username = _user!.username;
    await _userRepository.deleteUser(_user!.id);
    await _authRepository.logout();
    await HiveStorageService.deleteUserData(username);
    _user = null;
    notifyListeners();
  }

  Future<void> updateUser(UserModel user) async {
    await _userRepository.updateUser(user);
    await _authRepository.setCurrentUser(user);
    _user = user;
    notifyListeners();
  }

  Future<void> reloadUser() async {
    _user = _authRepository.getCurrentUser();
    notifyListeners();
  }

  bool usernameExists(String username) =>
      _authRepository.usernameExists(username);
}
