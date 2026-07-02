import 'package:fit_tracker/l10n/app_localizations.dart';

class RegistrationValidator {
  final AppLocalizations l10n;
  RegistrationValidator(this.l10n);

  static const _reservedNames = {'Guest', '__guest__', 'Admin', 'admin'};

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return l10n.validatorUsernameRequired;
    if (value.length < 3) return l10n.validatorUsernameMinLength;
    if (_reservedNames.contains(value.trim())) return l10n.validatorUsernameReserved;
    if (!RegExp(r'^[a-zA-Z0-9._\-]+$').hasMatch(value)) return l10n.validatorUsernameChars;
    return null;
  }

  String? validateAge(String? value) {
    if (value == null || value.isEmpty) return l10n.validatorAgeRequired;
    final age = int.tryParse(value);
    if (age == null) return l10n.validatorValidNumber;
    if (age < 13) return l10n.validatorAgeMin;
    if (age > 120) return l10n.validatorAgeValid;
    return null;
  }

  String? validateWeight(String? value) {
    if (value == null || value.isEmpty) return l10n.validatorWeightRequired;
    final weight = double.tryParse(value);
    if (weight == null) return l10n.validatorValidNumber;
    if (weight < 1 || weight > 300) return l10n.validatorWeightRange;
    return null;
  }

  String? validatePasskey(String? value) {
    if (value == null || value.isEmpty) return l10n.validatorPasskeyRequired;
    if (value.length < 6) return l10n.validatorPasskeyMinLength;
    if (value.length > 64) return l10n.validatorPasskeyMaxLength;
    if (!RegExp(r'^[a-zA-Z0-9!@#\$%^&*()_\-+=?.,:;]+$').hasMatch(value)) return l10n.validatorPasskeyChars;
    return null;
  }

  String? validateHeight(String? value) {
    if (value == null || value.isEmpty) return l10n.validatorHeightRequired;
    final height = double.tryParse(value);
    if (height == null) return l10n.validatorValidNumber;
    if (height < 1 || height > 300) return l10n.validatorHeightRange;
    return null;
  }
}
