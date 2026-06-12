import 'package:fit_tracker/data/model/user_model.dart';
import 'package:fit_tracker/data/repositories/auth_repository.dart';
import 'package:fit_tracker/data/services/hive_storage_service.dart';

class LocalAuthRepository implements AuthRepository {
  static const String _guestId = '__guest__';

  @override
  UserModel? getCurrentUser() {
    final userMap = HiveStorageService.getCurrentUser();
    if (userMap == null) return null;
    return UserModel.fromMap(userMap);
  }

  @override
  Future<bool> isLoggedIn() async {
    return HiveStorageService.getCurrentUser() != null;
  }

  @override
  Future<UserModel?> login(String username) async {
    final users = HiveStorageService.getUsers();
    final userMap = users.where((u) => u['username'] == username).firstOrNull;
    if (userMap == null) return null;
    await HiveStorageService.saveCurrentUser(userMap);
    return UserModel.fromMap(userMap);
  }

  @override
  Future<void> logout() async {
    await HiveStorageService.clearCurrentSession();
  }

  @override
  Future<UserModel> register(UserModel user) async {
    final users = HiveStorageService.getUsers();
    users.add(user.toMap());
    await HiveStorageService.saveUsers(users);
    await HiveStorageService.saveCurrentUser(user.toMap());
    return user;
  }

  @override
  Future<void> setCurrentUser(UserModel? user) async {
    await HiveStorageService.saveCurrentUser(user?.toMap());
  }

  @override
  Future<UserModel> loginAsGuest() async {
    final guestUser = UserModel(
      id: _guestId,
      username: 'Guest',
      age: 0,
      weight: 0.0,
      height: 0.0,
      gender: 'Male',
    );
    await HiveStorageService.saveCurrentUser(guestUser.toMap());
    return guestUser;
  }

  @override
  bool usernameExists(String username) {
    final users = HiveStorageService.getUsers();
    return users.any((u) => u['username'] == username);
  }
}
