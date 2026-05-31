import 'package:flutter/foundation.dart';

class CalculatorsViewModel extends ChangeNotifier {
  double calculateBMI(double weight, double height) {
    if (height <= 0) return 0;
    final heightM = height / 100;
    return weight / (heightM * heightM);
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  double calculateBMR(double weight, double height, int age, String gender) {
    final base = (10 * weight) + (6.25 * height) - (5 * age);
    return gender == 'Male' ? base + 5 : base - 161;
  }

  double calculateTDEE(double bmr, String activityLevel) {
    final multiplier = switch (activityLevel) {
      'Sedentary' => 1.2,
      'Lightly Active' => 1.375,
      'Moderately Active' => 1.55,
      'Very Active' => 1.725,
      'Extra Active' => 1.9,
      _ => 1.2,
    };
    return bmr * multiplier;
  }

  double getCalorieAdjustment(String goalType, double weeklyGoal) {
    if (goalType == 'lose') return -(weeklyGoal * 7700 / 7);
    if (goalType == 'gain') return weeklyGoal * 7700 / 7;
    return 0;
  }

  double calculateIdealWeight(double height, String gender) {
    return gender == 'Male'
        ? 50 + (0.91 * (height - 152.4))
        : 45.5 + (0.91 * (height - 152.4));
  }

  ({double normal, double min, double max}) calculateProteinValues(
      double weight, bool isBodybuilder) {
    if (isBodybuilder) {
      final maxVal = (2.0 * weight * 100).round() / 100;
      final minVal = (1.2 * weight * 100).round() / 100;
      return (normal: 0.0, min: minVal, max: maxVal);
    }
    final normal = (0.8 * weight * 100).round() / 100;
    return (normal: normal, min: 0.0, max: 0.0);
  }
}
