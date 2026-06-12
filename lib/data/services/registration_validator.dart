class RegistrationValidator {
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

  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Gender is required';
    }
    if (value != 'Male' && value != 'Female') {
      return 'Select a valid gender';
    }
    return null;
  }
}
