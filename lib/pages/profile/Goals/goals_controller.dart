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
      if (goal['active'] == true &&
          key == 'weight' &&
          goal['current'] != null) {
        final progress = getProgress(key);
        if (progress >= 1.0) {
          count++;
        }
      }
    });
    return count;
  }

  double getProgress(String key) {
    final goal = _goals[key]!;

    // Only weight goals have progress tracking
    if (key != 'weight' || goal['current'] == null) return 0.0;

    final target =
        goal['target'] is int ? goal['target'].toDouble() : goal['target'];
    final current =
        goal['current'] is int ? goal['current'].toDouble() : goal['current'];

    // For weight goals with goal type
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

    // Default for maintain weight goals
    if (target == 0) return 0.0;
    return (current / target).clamp(0.0, 1.0);
  }

  int getProgressPercentage(String key) {
    final progress = getProgress(key);
    return (progress * 100).toInt();
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

  // Check if goal should show percentage (only for weight goals with current value)
  bool shouldShowPercentage(String key) {
    final goal = _goals[key];
    if (goal == null) return false;
    return key == 'weight' && goal['current'] != null;
  }

  // Check if goal should show progress bar (only for weight goals)
  bool shouldShowProgressBar(String key) {
    final goal = _goals[key];
    if (goal == null) return false;
    return key == 'weight' && goal['current'] != null;
  }

  String getGoalStatus(String key) {
    final goal = _goals[key]!;

    // For calories and protein goals - always "Goal Set"
    if (key == 'calories' || key == 'protein') {
      return 'Goal Set';
    }

    // For weight goals
    if (key == 'weight' && goal['current'] != null) {
      final progress = getProgress(key);
      if (progress >= 1.0) {
        return 'Goal achieved';
      } else {
        return 'In progress';
      }
    }

    // Default for other goals
    return 'Not started';
  }

  // Helper methods for square cards
  Color getCardColor(String key) {
    switch (key) {
      case 'calories':
        return Colors.red;
      case 'protein':
        return Colors.orange;
      case 'weight':
        return blueColor;
      default:
        return primaryColor;
    }
  }

  String getShortTitle(String key) {
    switch (key) {
      case 'calories':
        return 'Calories';
      case 'protein':
        return 'Protein';
      case 'weight':
        return 'Weight';
      default:
        return capitalize(key);
    }
  }

  IconData getIcon(String key) {
    switch (key) {
      case 'calories':
        return Icons.local_fire_department;
      case 'protein':
        return Icons.restaurant;
      case 'weight':
        return Icons.monitor_weight;
      default:
        return Icons.flag;
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
