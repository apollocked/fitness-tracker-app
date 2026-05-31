import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tracker/app/repositories/auth_repository.dart';
import 'package:fit_tracker/app/repositories/user_repository.dart';

class SettingsState {
  final bool isLoading;
  final bool notificationsEnabled;
  final String? error;
  final String? successMessage;
  const SettingsState(
      {this.isLoading = false,
      this.notificationsEnabled = true,
      this.error,
      this.successMessage});
  SettingsState copyWith(
      {bool? isLoading,
      bool? notificationsEnabled,
      String? error,
      String? successMessage}) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      error: error,
      successMessage: successMessage,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  SettingsCubit(this._authRepository, this._userRepository)
      : super(const SettingsState());
  void setNotifications(bool enabled) =>
      emit(state.copyWith(notificationsEnabled: enabled));
  void toggleNotifications() =>
      emit(state.copyWith(notificationsEnabled: !state.notificationsEnabled));
  void clearMessages() =>
      emit(state.copyWith(error: null, successMessage: null));
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));
    try {
      final user = _authRepository.getCurrentUser();
      if (user == null) {
        emit(state.copyWith(isLoading: false, error: 'No user logged in'));
        return false;
      }
      if (user.password != oldPassword) {
        emit(state.copyWith(
            isLoading: false, error: 'Old password is incorrect'));
        return false;
      }
      final updated = user.copyWith(password: newPassword);
      await _userRepository.updateUser(updated);
      await _authRepository.setCurrentUser(updated);
      emit(state.copyWith(
          isLoading: false, successMessage: 'Password changed successfully!'));
      return true;
    } catch (e) {
      emit(
          state.copyWith(isLoading: false, error: 'Failed to change password'));
      return false;
    }
  }

  Future<bool> updateProfile(String username, String email) async {
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));
    try {
      final user = _authRepository.getCurrentUser();
      if (user == null) {
        emit(state.copyWith(isLoading: false, error: 'No user logged in'));
        return false;
      }
      final updated = user.copyWith(username: username, email: email);
      await _userRepository.updateUser(updated);
      await _authRepository.setCurrentUser(updated);
      emit(state.copyWith(
          isLoading: false, successMessage: 'Profile updated successfully!'));
      return true;
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Failed to update profile'));
      return false;
    }
  }
}
