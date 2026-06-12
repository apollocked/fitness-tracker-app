import 'package:fit_tracker/data/model/user_model.dart';
import 'package:fit_tracker/data/repositories/user_repository.dart';
import 'package:fit_tracker/data/services/hive_storage_service.dart';

class LocalUserRepository implements UserRepository {
  List<UserModel> _cachedUsers = [];

  @override
  Future<List<UserModel>> getAllUsers() async {
    if (_cachedUsers.isEmpty) {
      await reloadFromStorage();
    }
    return List.from(_cachedUsers);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    _cachedUsers.add(user);
    await _persistUsers();
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final index = _cachedUsers.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _cachedUsers[index] = user;
      await _persistUsers();
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    _cachedUsers.removeWhere((u) => u.id == userId);
    await _persistUsers();
  }

  @override
  bool usernameExists(String username) {
    return _cachedUsers.any((u) => u.username == username);
  }

  @override
  UserModel? findUserByUsername(String username) {
    return _cachedUsers.cast<UserModel?>().firstWhere(
          (u) => u!.username == username,
          orElse: () => null,
        );
  }

  Future<void> _persistUsers() async {
    await HiveStorageService.saveUsers(
      _cachedUsers.map((u) => u.toMap()).toList(),
    );
  }

  Future<void> reloadFromStorage() async {
    final stored = HiveStorageService.getUsers();
    _cachedUsers = stored.map((m) => UserModel.fromMap(m)).toList();
  }
}
