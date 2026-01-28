import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class GoalsController extends ChangeNotifier {
  Map<String, Map<String, dynamic>> _goals = {
    'weight': {'target': 70.0, 'current': 75.0, 'unit': 'kg', 'active': true},
    'calories': {
      'target': 2500,
      'current': 1800,
      'unit': 'cal',
      'active': true
    },
    'protein': {'target': 150.0, 'current': 120.0, 'unit': 'g', 'active': true},
  };

  Map<String, Map<String, dynamic>> get goals => _goals;

  void loadGoals() {
    if (currentUser != null && currentUser!['goals'] != null) {
      _goals = Map<String, Map<String, dynamic>>.from(currentUser!['goals']);
    }
    notifyListeners();
  }

  void saveGoals() {
    if (currentUser != null) {
      currentUser!['goals'] = Map.from(_goals);
      final index = users.indexWhere((u) => u['id'] == currentUser!['id']);
      if (index != -1) users[index]['goals'] = Map.from(_goals);
    }
  }

  void updateGoal(String key, Map<String, dynamic> newGoal) {
    _goals[key] = Map.from(newGoal);
    saveGoals();
    notifyListeners();
  }

  void toggleGoalActive(String key, bool active) {
    if (_goals.containsKey(key)) {
      _goals[key]!['active'] = active;
      saveGoals();
      notifyListeners();
    }
  }

  int get activeCount => _goals.values.where((g) => g['active']).length;

  int get completedCount {
    int count = 0;
    _goals.forEach((key, goal) {
      if (goal['active'] == true) {
        if (goal['goalType'] == 'lose') {
          // For lose goal, current should be less than or equal to target
          if (goal['current'] <= goal['target']) {
            count++;
          }
        } else if (goal['goalType'] == 'gain') {
          // For gain goal, current should be greater than or equal to target
          if (goal['current'] >= goal['target']) {
            count++;
          }
        } else {
          // For maintain or no goal type, use default logic
          if (goal['current'] >= goal['target']) {
            count++;
          }
        }
      }
    });
    return count;
  }

  double getProgress(String key) {
    final goal = _goals[key]!;
    final target =
        goal['target'] is int ? goal['target'].toDouble() : goal['target'];
    final current =
        goal['current'] is int ? goal['current'].toDouble() : goal['current'];

    // Adjust progress calculation based on goal type
    if (goal['goalType'] == 'lose') {
      // For lose goal: progress = how much lost / total to lose
      double startWeight = current > target ? current : target;
      double weightToLose = (startWeight - target).abs();
      if (weightToLose == 0) return 1.0;
      double weightLost = (startWeight - current).abs();
      return (weightLost / weightToLose).clamp(0.0, 1.0);
    } else if (goal['goalType'] == 'gain') {
      // For gain goal: progress = how much gained / total to gain
      double startWeight = current < target ? current : target;
      double weightToGain = (target - startWeight).abs();
      if (weightToGain == 0) return 1.0;
      double weightGained = (current - startWeight).abs();
      return (weightGained / weightToGain).clamp(0.0, 1.0);
    } else {
      // Default logic for maintain or no goal type
      return target == 0 ? 0.0 : (current / target).clamp(0.0, 1.0);
    }
  }

  Color getProgressColor(String key) {
    final progress = getProgress(key);
    return progress >= 1.0
        ? greenColor
        : progress >= 0.75
            ? blueColor
            : progress >= 0.5
                ? orangeColor
                : redColor;
  }

  static String capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : '';

  static String getGoalDescription(String key) {
    switch (key) {
      case 'weight':
        return 'Target body weight';
      case 'calories':
        return 'Daily calorie intake';
      case 'protein':
        return 'Daily protein intake';
      default:
        return 'Fitness goal';
    }
  }

  static IconData getGoalIcon(String key) {
    switch (key) {
      case 'weight':
        return Icons.monitor_weight;
      case 'calories':
        return Icons.local_fire_department;
      case 'protein':
        return Icons.restaurant;
      default:
        return Icons.flag;
    }
  }
}
