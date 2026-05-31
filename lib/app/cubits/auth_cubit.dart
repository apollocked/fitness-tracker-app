import 'package:fit_tracker/app/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tracker/app/repositories/auth_repository.dart';
import 'package:fit_tracker/app/repositories/user_repository.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;
  const AuthState({this.user, this.isLoading = false, this.error});
  bool get isLoggedIn => user != null;
  AuthState copyWith({UserModel? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  AuthCubit(this._authRepository, this._userRepository)
      : super(AuthState(user: _authRepository.getCurrentUser()));
  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final user = await _authRepository.login(email, password);
      if (user == null) {
        emit(state.copyWith(
            isLoading: false, error: "Invalid email or password"));
      } else {
        emit(AuthState(user: user));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Login failed"));
    }
  }

  Future<void> register(UserModel user) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final newUser = await _authRepository.register(user);
      emit(AuthState(user: newUser));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Registration failed"));
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(const AuthState());
  }

  Future<void> deleteAccount() async {
    if (state.user == null) return;
    await _userRepository.deleteUser(state.user!.id);
    await _authRepository.logout();
    emit(const AuthState());
  }

  void updateUser(UserModel user) {
    emit(state.copyWith(user: user));
  }

  Future<void> reloadUser() async {
    final user = _authRepository.getCurrentUser();
    emit(AuthState(user: user));
  }

  bool emailExists(String email) => _userRepository.emailExists(email);
}
