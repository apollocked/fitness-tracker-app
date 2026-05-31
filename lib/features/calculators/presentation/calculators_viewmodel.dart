import 'package:flutter/foundation.dart';

class CalculatorsViewModel extends ChangeNotifier {
  // BMI Calculation
  double calculateBMI(double weight, double height) {
    if (height <= 0) return 0;
    return weight / ((height / 100) * (height / 100));
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  // BMR Calculation (Mifflin-St Jeor)
  double calculateBMR(double weight, double height, int age, String gender) {
    final base = (10 * weight) + (6.25 * height) - (5 * age);
    return gender == 'Male' ? base + 5 : base - 161;
  }

  // TDEE based on activity level
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

  // Calorie adjustment for weight goals
  double getCalorieAdjustment(String goalType, double weeklyGoal) {
    if (goalType == 'lose') return -(weeklyGoal * 7700 / 7);
    if (goalType == 'gain') return weeklyGoal * 7700 / 7;
    return 0;
  }

  // Ideal body weight (Devine formula)
  double calculateIdealWeight(double height, String gender) {
    final heightInInches = height / 2.54;
    final baseInches = heightInInches - 60;
    if (gender == 'Male') {
      return 50 + (2.3 * baseInches);
    } else {
      return 45.5 + (2.3 * baseInches);
    }
  }

  // Protein intake recommendation
  Map<String, double> calculateProteinIntake(
      double weight, bool isBodybuilder, String goalType) {
    final double multiplier;
    if (isBodybuilder) {
      multiplier = 2.2;
    } else {
      multiplier = switch (goalType) {
        'lose' => 2.0,
        'gain' => 1.8,
        _ => 1.6,
      };
    }
    final dailyProtein = weight * multiplier;
    final perMeal = dailyProtein / 3;
    return {
      'dailyProtein': double.parse(dailyProtein.toStringAsFixed(1)),
      'perMeal': double.parse(perMeal.toStringAsFixed(1)),
      'multiplier': multiplier,
    };
  }
}
