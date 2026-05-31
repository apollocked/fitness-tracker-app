import 'package:fit_tracker/data/model/user_model.dart';
import 'package:fit_tracker/data/services/auth_repository.dart';
import 'package:fit_tracker/data/services/user_repository.dart';
import 'package:fit_tracker/data/services/storage_service.dart';

class LocalAuthRepository implements AuthRepository {
  final UserRepository _userRepository;
  LocalAuthRepository(this._userRepository);
  @override
  UserModel? getCurrentUser() {
    final userMap = StorageService.getCurrentUser();
    if (userMap == null) return null;
    return UserModel.fromMap(userMap);
  }

  @override
  Future<bool> isLoggedIn() async {
    return StorageService.isLoggedIn();
  }

  @override
  Future<UserModel?> login(String email, String password) async {
    final user = _userRepository.findUserByEmailAndPassword(email, password);
    if (user == null) return null;
    await StorageService.saveCurrentUser(user.toMap());
    await StorageService.setLoggedIn(true);
    return user;
  }

  @override
  Future<void> logout() async {
    await StorageService.clearAll();
  }

  @override
  Future<UserModel> register(UserModel user) async {
    await _userRepository.saveUser(user);
    await StorageService.saveCurrentUser(user.toMap());
    await StorageService.setLoggedIn(true);
    return user;
  }

  @override
  Future<void> setCurrentUser(UserModel? user) async {
    if (user == null) {
      await StorageService.saveCurrentUser(null);
    } else {
      await StorageService.saveCurrentUser(user.toMap());
    }
  }
}

