import 'package:fit_tracker/data/model/user_model.dart';
import 'package:fit_tracker/data/services/storage_service.dart';
import 'package:fit_tracker/data/services/user_repository.dart';

class LocalUserRepository implements UserRepository {
  List<UserModel> _cachedUsers = [];
  @override
  Future<List<UserModel>> getAllUsers() async {
    if (_cachedUsers.isEmpty) {
      final stored = StorageService.getUsers();
      _cachedUsers = stored.map((m) => UserModel.fromMap(m)).toList();
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
  bool emailExists(String email) {
    return _cachedUsers.any(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );
  }

  @override
  UserModel? findUserByEmailAndPassword(String email, String password) {
    return _cachedUsers.cast<UserModel?>().firstWhere(
          (u) =>
              u!.email.toLowerCase() == email.toLowerCase() &&
              u.password == password,
          orElse: () => null,
        );
  }

  Future<void> _persistUsers() async {
    await StorageService.saveUsers(
      _cachedUsers.map((u) => u.toMap()).toList(),
    );
  }

  Future<void> reloadFromStorage() async {
    final stored = StorageService.getUsers();
    _cachedUsers = stored.map((m) => UserModel.fromMap(m)).toList();
  }

  Future<void> addDefaultUserIfEmpty() async {
    if (_cachedUsers.isEmpty) {
      final defaultUser = UserModel(
        id: 'demo_001',
        username: 'demo_user',
        email: 'demo@fitness.com',
        password: 'demo123',
        age: 25,
        weight: 70.0,
        height: 175.0,
        gender: 'Male',
        goals: {
          'weight': {
            'target': 75.0,
            'current': 70.0,
            'unit': 'kg',
            'active': true,
            'goalType': 'gain',
          },
          'protein': {'target': 120, 'unit': 'g', 'active': true},
          'calories': {'target': 2500, 'unit': 'cal', 'active': true},
        },
      );
      _cachedUsers.add(defaultUser);
      await _persistUsers();
    }
  }
}
