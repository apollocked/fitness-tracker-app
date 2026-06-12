import 'package:fit_tracker/data/model/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getAllUsers();
  Future<void> saveUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(String userId);
  bool usernameExists(String username);
  UserModel? findUserByUsername(String username);
}
