import 'package:fit_tracker/core/base_viewmodel.dart';
import 'package:fit_tracker/app/models/user_model.dart';

/// AuthViewModel consolidates all authentication logic
/// Replaces: AuthCubit
class AuthViewModel extends BaseViewModel {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<bool> login(String email, String password) async {
    return executeAsync(
      () async {
        // Simulated login - replace with actual auth logic
        _currentUser = UserModel(
          id: 'user_1',
          email: email,
          password: password,
          name: 'User',
          age: 25,
          gender: 'Male',
          weight: 75.0,
          height: 180,
          goals: {},
          darkMode: false,
        );
        notifyListeners();
        return true;
      },
    );
  }

  Future<bool> register(UserModel user) async {
    return executeAsync(
      () async {
        _currentUser = user;
        notifyListeners();
        return true;
      },
    );
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void updateUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }
}
