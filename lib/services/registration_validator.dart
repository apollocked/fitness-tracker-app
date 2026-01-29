class RegistrationValidator {
  // Validate username
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (!RegExp(r'^[a-zA-Z0-9._\-]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, ., _, and -';
    }
    return null;
  }

  // Validate email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Validate age
  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(value);
    if (age == null) {
      return 'Enter a valid number';
    }
    if (age < 13) {
      return 'Must be at least 13 years old';
    }
    if (age > 120) {
      return 'Enter a valid age';
    }
    return null;
  }

  // Validate weight
  static String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Weight is required';
    }
    final weight = double.tryParse(value);
    if (weight == null) {
      return 'Enter a valid number';
    }
    if (weight < 1 || weight > 300) {
      return 'Weight must be between 1-300 kg';
    }
    return null;
  }

  // Validate height
  static String? validateHeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Height is required';
    }
    final height = double.tryParse(value);
    if (height == null) {
      return 'Enter a valid number';
    }
    if (height < 1 || height > 300) {
      return 'Height must be between 1-300 cm';
    }
    return null;
  }

  // Validate gender
  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Gender is required';
    }
    if (value != 'Male' && value != 'Female') {
      return 'Select a valid gender';
    }
    return null;
  }

  // Validate all fields at once
  static bool validateAll({
    required String username,
    required String email,
    required String password,
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
        validateGender(gender) == null;
  }
}
