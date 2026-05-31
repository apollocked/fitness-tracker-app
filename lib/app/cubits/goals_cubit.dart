import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/data/services/auth_repository.dart';
import 'package:fit_tracker/data/services/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalsState {
  final Map<String, Map<String, dynamic>> goals;
  final bool isLoading;
  const GoalsState({this.goals = const {}, this.isLoading = false});
  GoalsState copyWith(
      {Map<String, Map<String, dynamic>>? goals, bool? isLoading}) {
    return GoalsState(
      goals: goals ?? this.goals,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class GoalsCubit extends Cubit<GoalsState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  GoalsCubit(this._userRepository, this._authRepository)
      : super(const GoalsState()) {
    loadGoals();
  }
  void loadGoals() {
    final user = _authRepository.getCurrentUser();
    if (user != null) {
      final goals = Map<String, Map<String, dynamic>>.from(
        (user.goals).map((k, v) => MapEntry(k, Map<String, dynamic>.from(v))),
      );
      emit(GoalsState(goals: goals));
    }
  }

  Future<void> saveGoals() async {
    final user = _authRepository.getCurrentUser();
    if (user != null) {
      user.goals = Map<String, dynamic>.from(state.goals);
      await _userRepository.updateUser(user);
    }
  }

  Future<void> updateGoal(String key, Map<String, dynamic> newGoal) async {
    final updated = Map<String, Map<String, dynamic>>.from(state.goals);
    updated[key] = Map.from(newGoal);
    emit(GoalsState(goals: updated));
    await saveGoals();
  }

  Future<void> toggleGoalActive(String key, bool active) async {
    final updated = Map<String, Map<String, dynamic>>.from(state.goals);
    if (updated.containsKey(key)) {
      updated[key] = Map<String, dynamic>.from(updated[key]!);
      updated[key]!['active'] = active;
      emit(GoalsState(goals: updated));
      await saveGoals();
    }
  }

  int get activeCount =>
      state.goals.values.where((g) => g['active'] == true).length;
  int get completedCount {
    int count = 0;
    state.goals.forEach((key, goal) {
      if (goal['active'] == true &&
          key == 'weight' &&
          goal['current'] != null &&
          getProgress(key) >= 1.0) {
        count++;
      }
    });
    return count;
  }

  double getProgress(String key) {
    final goal = state.goals[key];
    if (goal == null || goal['current'] == null) return 0.0;
    if (key == 'weight') {
      final double target = _toDouble(goal['target']) ?? 0.0;
      final double current = _toDouble(goal['current']) ?? 0.0;
      final String goalType = goal['goalType'] ?? 'lose';
      if (goalType == 'lose') {
        final double startWeight = _toDouble(goal['startWeight']) ??
            (current > target ? current : target + 5.0);
        final double totalToLose = startWeight - target;
        if (totalToLose <= 0) return 1.0;
        return ((startWeight - current) / totalToLose).clamp(0.0, 1.0);
      } else if (goalType == 'gain') {
        final double startWeight = _toDouble(goal['startWeight']) ??
            (current < target ? current : target - 5.0);
        final double totalToGain = target - startWeight;
        if (totalToGain <= 0) return 1.0;
        return ((current - startWeight) / totalToGain).clamp(0.0, 1.0);
      } else if (goalType == 'maintain') {
        if (target == 0) return 0.0;
        final double diff = (current - target).abs();
        if (diff <= (target * 0.01)) return 1.0;
        return (1.0 - (diff / 5.0)).clamp(0.0, 1.0);
      }
    }
    final double targetValue = _toDouble(goal['target']) ?? 0.0;
    final double currentValue = _toDouble(goal['current']) ?? 0.0;
    if (targetValue == 0) return 0.0;
    return (currentValue / targetValue).clamp(0.0, 1.0);
  }

  int getProgressPercentage(String key) => (getProgress(key) * 100).toInt();
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

  bool shouldShowPercentage(String key) {
    final goal = state.goals[key];
    return goal != null && key == 'weight' && goal['current'] != null;
  }

  bool shouldShowProgressBar(String key) {
    final goal = state.goals[key];
    return goal != null && key == 'weight' && goal['current'] != null;
  }

  String getGoalStatus(String key) {
    final goal = state.goals[key]!;
    if (key == 'calories' || key == 'protein') return 'Goal Set';
    if (key == 'weight' && goal['current'] != null) {
      return getProgress(key) >= 1.0 ? 'Goal achieved' : 'Active';
    }
    return 'Not started';
  }

  Color getCardColor(String key) {
    switch (key) {
      case 'calories':
        return redColor;
      case 'protein':
        return orangeColor;
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
        return _capitalize(key);
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

  String _capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : '';
  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    return double.tryParse(value.toString());
  }

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
