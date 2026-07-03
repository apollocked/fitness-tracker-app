import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/daily_calories/calorie_results_content.dart';

class DailyCaloriesResultsDialog {
  static void showResults(
    BuildContext context, {
    required double bmr,
    required double dailyCalories,
    double? maintenanceCalories,
    String goalType = 'maintain',
    double weeklyGoal = 0.5,
    String goalDescription = "",
    VoidCallback? onSetGoal,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: CalorieResultsContent(
            bmr: bmr,
            dailyCalories: dailyCalories,
            maintenanceCalories: maintenanceCalories,
            goalType: goalType,
            weeklyGoal: weeklyGoal,
            goalDescription: goalDescription,
            onSetGoal: onSetGoal,
          ),
        ),
      ),
    );
  }
}
