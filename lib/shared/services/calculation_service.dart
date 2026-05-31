class CalculationService {
  /// Calculate BMI
  static double calculateBMI(double weightKg, double heightCm) {
    return weightKg / ((heightCm / 100) * (heightCm / 100));
  }

  /// Calculate ideal body weight using Devine formula
  static double calculateIdealWeight({
    required double heightCm,
    required String gender,
  }) {
    if (gender == "Male") {
      return 50 + (0.91 * (heightCm - 152.4));
    } else {
      return 45.5 + (0.91 * (heightCm - 152.4));
    }
  }

  /// Calculate protein intake recommendations
  static Map<String, double> calculateProtein({
    required double weightKg,
    required bool isBodybuilder,
  }) {
    if (!isBodybuilder) {
      final normal = 0.8 * weightKg;
      return {'normal': (normal * 100).round() / 100};
    }
    return {
      'min': (1.2 * weightKg * 100).round() / 100,
      'max': (2.0 * weightKg * 100).round() / 100,
    };
  }

  /// Calculate daily calorie requirements using Harris-Benedict
  static Map<String, double> calculateCalories({
    required double weightKg,
    required double heightCm,
    required int ageYears,
    required String gender,
    required String activityLevel,
  }) {
    double bmr;
    if (gender == 'Male') {
      bmr = 88.362 +
          (13.397 * weightKg) +
          (4.799 * heightCm) -
          (5.677 * ageYears);
    } else {
      bmr = 447.593 +
          (9.247 * weightKg) +
          (3.098 * heightCm) -
          (4.330 * ageYears);
    }

    final multiplier = _getActivityMultiplier(activityLevel);
    return {
      'bmr': (bmr * 100).round() / 100,
      'tdee': ((bmr * multiplier) * 100).round() / 100,
    };
  }

  static double _getActivityMultiplier(String level) {
    switch (level.toLowerCase()) {
      case 'sedentary':
        return 1.2;
      case 'light':
        return 1.375;
      case 'moderate':
        return 1.55;
      case 'heavy':
      case 'veryheavy':
        return 1.725;
      default:
        return 1.375;
    }
  }
}
