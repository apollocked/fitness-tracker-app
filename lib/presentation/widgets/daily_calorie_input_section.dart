import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fit_tracker/presentation/widgets/custom_textfield.dart';
import 'package:fit_tracker/presentation/widgets/select_gender_radio.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

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
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colors.textColor)),
        const SizedBox(height: 8),
        CustomGenderRatio(
          color: redColor,
          selectedGender: gender,
          onGenderChanged: onGenderChanged,
        ),
        const SizedBox(height: 16),
        CustomTextfield(
          controller: ageController,
          isObscure: false,
          keyboard: TextInputType.number,
          icon: const Icon(Icons.cake),
          color: redColor,
          text: 'Age (years)',
          onSaved: (value) {},
          validator: (value) {
            if (value == null || value.isEmpty) return 'Required';
            if (int.tryParse(value) == null) return 'Invalid number';
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
          text: 'Weight (kg)',
          onSaved: (value) {},
          validator: (value) {
            if (value == null || value.isEmpty) return 'Required';
            if (double.tryParse(value) == null) return 'Invalid number';
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
          text: 'Height (cm)',
          onSaved: (value) {},
          validator: (value) {
            if (value == null || value.isEmpty) return 'Required';
            if (double.tryParse(value) == null) return 'Invalid number';
            return null;
          },
          input: FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ),
        const SizedBox(height: 16),
        Text('Activity Level',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colors.textColor)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: colors.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.subtitleColor.withOpacity(0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: activityLevel,
              dropdownColor: colors.cardColor,
              style: TextStyle(
                  color: colors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                    value: 'Sedentary',
                    child: Text('Sedentary (little or no exercise)')),
                DropdownMenuItem(
                    value: 'Lightly Active',
                    child: Text('Lightly Active (1-3 days/week)')),
                DropdownMenuItem(
                    value: 'Moderately Active',
                    child: Text('Moderately Active (3-5 days/week)')),
                DropdownMenuItem(
                    value: 'Very Active',
                    child: Text('Very Active (6-7 days/week)')),
                DropdownMenuItem(
                    value: 'Extra Active',
                    child: Text('Extra Active (athlete/physical job)')),
              ],
              onChanged: (value) => onActivityChanged(value!),
            ),
          ),
        ),
      ],
    );
  }
}

