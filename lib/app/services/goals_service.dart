import 'package:fit_tracker/app/repositories/auth_repository.dart';
import 'package:fit_tracker/app/repositories/user_repository.dart';

class GoalsService {
  static AuthRepository? _authRepository;
  static UserRepository? _userRepository;

  static void initialize(
      AuthRepository authRepository, UserRepository userRepository) {
    _authRepository = authRepository;
    _userRepository = userRepository;
  }

  static Future<void> updateGoalFromCalculator(
      String goalKey, double targetValue) async {
    final user = _authRepository?.getCurrentUser();
    if (user == null) return;

    if (!user.goals.containsKey(goalKey)) {
      user.goals[goalKey] = {};
    }

    user.goals[goalKey]!['target'] = targetValue;
    user.goals[goalKey]!['active'] = true;

    await _userRepository?.updateUser(user);
  }

  static Future<void> updateWeightGoalWithTarget(
    double currentWeight,
    double targetWeight,
    String goalType,
  ) async {
    final user = _authRepository?.getCurrentUser();
    if (user == null) return;

    if (!user.goals.containsKey('weight')) {
      user.goals['weight'] = {};
    }

    user.goals['weight']!['target'] = targetWeight;
    user.goals['weight']!['current'] = currentWeight;
    user.goals['weight']!['startWeight'] = currentWeight;
    user.goals['weight']!['goalType'] = goalType;
    user.goals['weight']!['active'] = true;

    await _userRepository?.updateUser(user);
  }

  static Future<void> updateGoalCurrent(
      String goalKey, double currentValue) async {
    final user = _authRepository?.getCurrentUser();
    if (user == null) return;

    if (!user.goals.containsKey(goalKey)) {
      user.goals[goalKey] = {};
    }

    user.goals[goalKey]!['current'] = currentValue;

    await _userRepository?.updateUser(user);
  }
}
