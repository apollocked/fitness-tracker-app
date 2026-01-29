// lib/services/goals_service.dart
import 'package:myapp/utils/user_data.dart';

class GoalsService {
  static void updateGoalFromCalculator(String goalType, double target) {
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

      // Update in users list
      final index = users.indexWhere((u) => u['id'] == currentUser!['id']);
      if (index != -1) {
        users[index]['goals'] = Map.from(currentUser!['goals']);
      }
    }
  }

  static void updateWeightGoalWithTarget(
      double currentWeight, double targetWeight, String goalType) {
    if (currentUser != null) {
      // Initialize goals if not exists
      if (currentUser!['goals'] == null) {
        currentUser!['goals'] = {};
      }

      // For weight goals, store the starting weight
      double startWeight = currentWeight;

      // Determine start weight based on goal type
      if (goalType == 'lose') {
        // For lose goal, start weight is current weight (or higher if already below target)
        startWeight =
            currentWeight > targetWeight ? currentWeight : targetWeight;
      } else if (goalType == 'gain') {
        // For gain goal, start weight is current weight (or lower if already above target)
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
        'startWeight':
            startWeight, // Store initial weight for progress calculation
      };

      // Update in users list
      final index = users.indexWhere((u) => u['id'] == currentUser!['id']);
      if (index != -1) {
        users[index]['goals'] = Map.from(currentUser!['goals']);
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
