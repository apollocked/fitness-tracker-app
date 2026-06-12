import 'package:fit_tracker/data/model/user_model.dart';
import 'package:fit_tracker/data/repositories/auth_repository.dart';
import 'package:fit_tracker/data/repositories/user_repository.dart';
import 'package:fit_tracker/data/services/storage_service.dart';

class LocalAuthRepository implements AuthRepository {
  final UserRepository _userRepository;
  LocalAuthRepository(this._userRepository);

  static const String _guestId = '__guest__';

  @override
  UserModel? getCurrentUser() {
    // If there's a guest session in memory, return it from storage check
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
    await StorageService.setGuestMode(false);
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
    await StorageService.setGuestMode(false);
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

  @override
  Future<UserModel> loginAsGuest() async {
    final guestUser = UserModel(
      id: _guestId,
      username: 'Guest',
      email: '',
      password: '',
      age: 0,
      weight: 0.0,
      height: 0.0,
      gender: 'Male',
    );
    // Save a minimal marker so getCurrentUser() can return the guest
    await StorageService.saveCurrentUser(guestUser.toMap());
    await StorageService.setLoggedIn(true);
    await StorageService.setGuestMode(true);
    return guestUser;
  }
}
