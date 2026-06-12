import 'package:flutter/foundation.dart';
import 'package:fit_tracker/data/model/user_model.dart';
import 'package:fit_tracker/data/repositories/auth_repository.dart';
import 'package:fit_tracker/data/repositories/user_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthViewModel(this._authRepository, this._userRepository) {
    _user = _authRepository.getCurrentUser();
  }

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;
  bool get isGuest => _user?.id == '__guest__';

  Future<void> login(String username, String passkey) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final user = await _authRepository.login(username, passkey);
      if (user == null) {
        _isLoading = false;
        _error = "Invalid username or passkey";
      } else {
        _user = user;
        _isLoading = false;
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = "Login failed";
      notifyListeners();
    }
  }

  Future<void> loginAsGuest() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final guest = await _authRepository.loginAsGuest();
      _user = guest;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = "Failed to start guest session";
      notifyListeners();
    }
  }

  Future<void> register(UserModel user) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final newUser = await _authRepository.register(user);
      _user = newUser;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = "Registration failed";
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
    await _userRepository.deleteUser(_user!.id);
    await _authRepository.logout();
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
