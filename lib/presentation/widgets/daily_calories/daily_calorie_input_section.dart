import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_textfield.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';
import 'package:fit_tracker/presentation/widgets/daily_calories/calorie_gender_selector.dart';
import 'package:fit_tracker/presentation/widgets/daily_calories/calorie_activity_selector.dart';

class DailyCalorieInputSection extends StatelessWidget {
  final TextEditingController ageController;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final String activityLevel;
  final String gender;
  final Function(String) onActivityChanged;
  final Function(String) onGenderChanged;
  const DailyCalorieInputSection({
    required this.ageController,
    required this.weightController,
    required this.heightController,
    required this.activityLevel,
    required this.gender,
    required this.onActivityChanged,
    required this.onGenderChanged,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CalorieGenderSelector(
          gender: gender,
          onGenderChanged: onGenderChanged,
        ),
        const SizedBox(height: 16),
        CustomTextfield(
          controller: ageController,
          isObscure: false,
          keyboard: TextInputType.number,
          icon: const Icon(Icons.cake),
          color: redColor,
          text: l10n.calorieAge,
          onSaved: (value) {},
          validator: (value) {
            if (value == null || value.isEmpty) return l10n.calorieRequired;
            if (int.tryParse(value) == null) return l10n.calorieInvalidNumber;
            return null;
          },
          input: FilteringTextInputFormatter.digitsOnly,
        ),
        const SizedBox(height: 16),
        CustomTextfield(
          controller: weightController,
          isObscure: false,
          keyboard: TextInputType.number,
          icon: const Icon(Icons.monitor_weight),
          color: redColor,
          text: l10n.calorieWeightKg,
          onSaved: (value) {},
          validator: (value) {
            if (value == null || value.isEmpty) return l10n.calorieRequired;
            if (double.tryParse(value) == null) {
              return l10n.calorieInvalidNumber;
            }
            return null;
          },
          input: FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ),
        const SizedBox(height: 16),
        CustomTextfield(
          controller: heightController,
          isObscure: false,
          keyboard: TextInputType.number,
          icon: const Icon(Icons.height),
          color: redColor,
          text: l10n.calorieHeightCm,
          onSaved: (value) {},
          validator: (value) {
            if (value == null || value.isEmpty) return l10n.calorieRequired;
            if (double.tryParse(value) == null) {
              return l10n.calorieInvalidNumber;
            }
            return null;
          },
          input: FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ),
        const SizedBox(height: 16),
        CalorieActivitySelector(
          activityLevel: activityLevel,
          onActivityChanged: onActivityChanged,
        ),
      ],
    );
  }
}
