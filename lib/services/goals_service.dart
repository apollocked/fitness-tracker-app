import 'package:myapp/utils/user_data.dart';

class GoalsService {
  static Future<void> updateGoalFromCalculator(
      String goalType, double target) async {
    if (currentUser != null) {
      // Initialize goals if not exists
      if (currentUser!['goals'] == null) {
        currentUser!['goals'] = {};
      }

      // Update the specific goal WITHOUT current value
      currentUser!['goals'][goalType] = {
        'target': target,
        'unit': _getUnitForGoal(goalType),
        'active': true,
      };

      // Save to storage
      await updateUser(currentUser!['id'], currentUser!);
    }
  }

  static Future<void> updateWeightGoalWithTarget(
      double currentWeight, double targetWeight, String goalType) async {
    if (currentUser != null) {
      // Initialize goals if not exists
      if (currentUser!['goals'] == null) {
        currentUser!['goals'] = {};
      }

      // For weight goals, store the starting weight
      double startWeight = currentWeight;

      // Determine start weight based on goal type
      if (goalType == 'lose') {
        startWeight =
            currentWeight > targetWeight ? currentWeight : targetWeight;
      } else if (goalType == 'gain') {
        startWeight =
            currentWeight < targetWeight ? currentWeight : targetWeight;
      }

      // Update the weight goal with type and start weight
      currentUser!['goals']['weight'] = {
        'target': targetWeight,
        'current': currentWeight,
        'unit': 'kg',
        'active': true,
        'goalType': goalType,
        'startWeight': startWeight,
      };

      // Save to storage
      await updateUser(currentUser!['id'], currentUser!);
    }
  }

  static Future<void> updateGoal(
      String goalType, Map<String, dynamic> updatedGoal) async {
    if (currentUser != null) {
      if (currentUser!['goals'] == null) {
        currentUser!['goals'] = {};
      }

      currentUser!['goals'][goalType] = updatedGoal;
      await updateUser(currentUser!['id'], currentUser!);
    }
  }

  static Future<void> toggleGoalActive(String goalType, bool active) async {
    if (currentUser != null && currentUser!['goals'] != null) {
      final goal = currentUser!['goals'][goalType];
      if (goal != null) {
        goal['active'] = active;
        currentUser!['goals'][goalType] = goal;
        await updateUser(currentUser!['id'], currentUser!);
      }
    }
  }

  static String _getUnitForGoal(String goalType) {
    switch (goalType) {
      case 'weight':
        return 'kg';
      case 'calories':
        return 'cal';
      case 'protein':
        return 'g';
      default:
        return '';
    }
  }
}
