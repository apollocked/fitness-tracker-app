import 'package:fit_tracker/features/auth/data/models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getAllUsers();
  Future<void> saveUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(String userId);
  bool emailExists(String email);
  UserModel? findUserByEmailAndPassword(String email, String password);
}

