import 'package:flutter/material.dart';
import 'package:fit_tracker/data/repositories/auth_repository.dart';
import 'package:fit_tracker/data/repositories/user_repository.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';

class GoalsViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  GoalsViewModel(this._userRepository, this._authRepository) {
    _loadGoals();
  }

  Map<String, dynamic>? _currentGoals;
  Map<String, dynamic> get goals => _currentGoals ?? {};

  void _loadGoals() {
    final user = _authRepository.getCurrentUser();
    _currentGoals = user?.goals ?? {};
  }

  void reload() {
    _loadGoals();
    notifyListeners();
  }

  double getProgress(String key) {
    final goal = _currentGoals?[key];
    if (goal == null) return 0.0;
    final target = (goal['target'] as num?)?.toDouble() ?? 0;
    final current = (goal['current'] as num?)?.toDouble() ?? 0;
    if (target == 0) return 0.0;
    return (current / target).clamp(0.0, 1.0);
  }

  bool shouldShowPercentage(String key) {
    return key == 'weight' || key == 'protein';
  }

  Color getProgressColor(String key) {
    final goal = _currentGoals?[key];
    final active = goal?['active'] == true;
    if (!active) return greyColor;
    final progress = getProgress(key);
    if (progress >= 1.0) return greenColor;
    if (progress >= 0.5) return primaryColor;
    return orangeColor;
  }

  String getGoalStatus(String key) {
    final goal = _currentGoals?[key];
    if (goal == null) return '';
    final current = goal['current'];
    final target = goal['target'];
    if (current == null || target == null) return '';
    return '$current / $target ${goal['unit'] ?? ''}';
  }

  int get completedCount {
    if (_currentGoals == null) return 0;
    return _currentGoals!.values.where((g) {
      final target = (g['target'] as num?)?.toDouble() ?? 0;
      final current = (g['current'] as num?)?.toDouble() ?? 0;
      return target > 0 && current >= target;
    }).length;
  }

  Future<void> updateGoal(String key, Map<String, dynamic> goalData) async {
    _currentGoals ??= {};
    _currentGoals![key] = goalData;
    await _persist();
    notifyListeners();
  }

  Future<void> saveGoal(String key, Map<String, dynamic> goalData) async {
    _currentGoals ??= {};
    _currentGoals![key] = goalData;
    await _persist();
    notifyListeners();
  }

  Future<void> toggleGoal(String key, bool active) async {
    final goal = _currentGoals?[key];
    if (goal == null) return;
    goal['active'] = active;
    await _persist();
    notifyListeners();
  }

  Future<void> setGoalProgress(String key, double current) async {
    final goal = _currentGoals?[key];
    if (goal == null) return;
    goal['current'] = current;
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    final user = _authRepository.getCurrentUser();
    if (user == null || user.id == '__guest__') return;
    final updated = user.copyWith(goals: Map.from(_currentGoals ?? {}));
    await _userRepository.updateUser(updated);
    await _authRepository.setCurrentUser(updated);
  }

  static IconData getGoalIcon(String key) {
    switch (key) {
      case 'weight':
        return Icons.monitor_weight_outlined;
      case 'protein':
        return Icons.restaurant_outlined;
      case 'calories':
        return Icons.local_fire_department_outlined;
      default:
        return Icons.flag_outlined;
    }
  }

  static String getGoalDescription(String key) {
    switch (key) {
      case 'weight':
        return 'Track your weight goals';
      case 'protein':
        return 'Daily protein intake target';
      case 'calories':
        return 'Daily calorie intake target';
      default:
        return '';
    }
  }
}
