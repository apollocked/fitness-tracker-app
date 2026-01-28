import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class GoalsController extends ChangeNotifier {
  Map<String, Map<String, dynamic>> _goals = {};

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
        // For weight goals with goalType
        if (key == 'weight' && goal['goalType'] != null) {
          if (goal['goalType'] == 'lose') {
            if (goal['current'] <= goal['target']) {
              count++;
            }
          } else if (goal['goalType'] == 'gain') {
            if (goal['current'] >= goal['target']) {
              count++;
            }
          }
        }
        // For calories and protein, use simple comparison
        else if (key == 'calories' || key == 'protein') {
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

    // For weight goals, calculate detailed progress
    if (key == 'weight' && goal['goalType'] != null) {
      final target =
          goal['target'] is int ? goal['target'].toDouble() : goal['target'];
      final current =
          goal['current'] is int ? goal['current'].toDouble() : goal['current'];

      if (goal['goalType'] == 'lose') {
        double startWeight =
            goal['startWeight'] ?? (current > target ? current : target);
        double totalToLose = startWeight - target;

        if (totalToLose <= 0) return 1.0;
        double weightLost = startWeight - current;
        if (weightLost > totalToLose) return 1.0;
        if (weightLost < 0) return 0.0;
        return (weightLost / totalToLose).clamp(0.0, 1.0);
      } else if (goal['goalType'] == 'gain') {
        double startWeight =
            goal['startWeight'] ?? (current < target ? current : target);
        double totalToGain = target - startWeight;

        if (totalToGain <= 0) return 1.0;
        double weightGained = current - startWeight;
        if (weightGained > totalToGain) return 1.0;
        if (weightGained < 0) return 0.0;
        return (weightGained / totalToGain).clamp(0.0, 1.0);
      }
    }

    // For all other goals (calories, protein), return 1.0 if target reached
    final target =
        goal['target'] is int ? goal['target'].toDouble() : goal['target'];
    final current =
        goal['current'] is int ? goal['current'].toDouble() : goal['current'];

    return current >= target ? 1.0 : 0.0;
  }

  Color getProgressColor(String key) {
    final progress = getProgress(key);
    return progress >= 1.0
        ? greenColor
        : redColor; // Simple: green for completed, red for not completed
  }

  // New method to check if a goal should show percentage
  bool shouldShowPercentage(String key) {
    return key == 'weight';
  }

  // New method to check if a goal should show progress bar
  bool shouldShowProgressBar(String key) {
    return key == 'weight';
  }

  // New method to get goal status text
  String getGoalStatus(String key) {
    final progress = getProgress(key);
    if (progress >= 1.0) {
      return 'Goal achieved';
    } else {
      return 'In progress';
    }
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
