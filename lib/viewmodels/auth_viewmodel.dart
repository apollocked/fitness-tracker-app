import 'package:flutter/material.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/repositories/auth_repository.dart';
import 'package:myapp/repositories/user_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  UserModel? _currentUser;
  bool _isLoading = false;

  AuthViewModel(this._authRepository, this._userRepository) {
    _currentUser = _authRepository.getCurrentUser();
  }

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null;

  Future<UserModel?> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      _currentUser = await _authRepository.login(email, password);
      return _currentUser;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(UserModel user) async {
    _isLoading = true;
    notifyListeners();
    try {
      _currentUser = await _authRepository.register(user);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _currentUser = null;
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    if (_currentUser == null) return;
    await _userRepository.deleteUser(_currentUser!.id);
    await _authRepository.logout();
    _currentUser = null;
    notifyListeners();
  }

  Future<void> reloadUser() async {
    _currentUser = _authRepository.getCurrentUser();
    notifyListeners();
  }

  void updateCurrentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }
}
