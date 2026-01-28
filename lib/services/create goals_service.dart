// ignore_for_file: file_names

import 'package:myapp/utils/user_data.dart';

class GoalsService {
  static void updateGoalFromCalculator(
      String goalType, double current, double target) {
    if (currentUser != null) {
      // Initialize goals if not exists
      if (currentUser!['goals'] == null) {
        currentUser!['goals'] = {};
      }

      // Update the specific goal
      currentUser!['goals'][goalType] = {
        'target': target,
        'current': current,
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

      // Update the weight goal with type
      currentUser!['goals']['weight'] = {
        'target': targetWeight,
        'current': currentWeight,
        'unit': 'kg',
        'active': true,
        'goalType': goalType, // 'lose', 'gain', or 'maintain'
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
