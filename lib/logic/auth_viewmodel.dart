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

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final user = await _authRepository.login(email, password);
      if (user == null) {
        _isLoading = false;
        _error = "Invalid email or password";
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

  void updateUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<void> reloadUser() async {
    _user = _authRepository.getCurrentUser();
    notifyListeners();
  }

  bool emailExists(String email) => _userRepository.emailExists(email);
}
