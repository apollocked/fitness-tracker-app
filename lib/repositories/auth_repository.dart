import 'package:myapp/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> login(String email, String password);
  Future<UserModel> register(UserModel user);
  Future<void> logout();
  Future<bool> isLoggedIn();
  UserModel? getCurrentUser();
  Future<void> setCurrentUser(UserModel? user);
}
