import 'package:myapp/utils/user_data.dart';

class RegistrationValidator {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return "Username is required";
    if (value.trim().length < 3) {
      return "Username must be at least 3 characters";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "Enter a valid email";
    if (users.any((user) =>
        user['email'].toString().toLowerCase() == value.toLowerCase())) {
      return "Email already registered";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 6) return "Min 6 characters";
    return null;
  }

  static String? validateAge(String value) {
    if (value.isEmpty) return "Age is required";
    final age = int.tryParse(value);
    if (age == null || age <= 12 || age > 120) return "Valid age (1-120)";
    return null;
  }

  static String? validateWeight(String value) {
    if (value.isEmpty) return "Weight is required";
    final weight = double.tryParse(value);
    if (weight == null || weight <= 0 || weight > 300) {
      return "Valid weight (1-300)";
    }
    return null;
  }

  static String? validateHeight(String value) {
    if (value.isEmpty) return "Height is required";
    final height = double.tryParse(value);
    if (height == null || height <= 0 || height > 300) {
      return "Valid height (1-300)";
    }
    return null;
  }

  static bool validateAll({
    required String? username,
    required String? email,
    required String? password,
    required String age,
    required String weight,
    required String height,
    required String gender,
  }) {
    return validateUsername(username) == null &&
        validateEmail(email) == null &&
        validatePassword(password) == null &&
        validateAge(age) == null &&
        validateWeight(weight) == null &&
        validateHeight(height) == null &&
        gender.isNotEmpty;
  }
}
