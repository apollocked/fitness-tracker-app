import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_textfield.dart';
import 'package:fit_tracker/presentation/widgets/shared/select_gender_radio.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class PersonalInfoSection extends StatelessWidget {
  final TextEditingController ageController;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final String gender;
  final Function(String) onGenderChanged;
  const PersonalInfoSection({
    required this.ageController,
    required this.weightController,
    required this.heightController,
    required this.gender,
    required this.onGenderChanged,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Personal Information",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colors.textColor)),
        const SizedBox(height: 16),
        CustomTextfield(
          controller: ageController,
          isObscure: false,
          keyboard: TextInputType.number,
          icon: const Icon(Icons.cake),
          color: primaryColor,
          onSaved: (value) {},
          text: 'Age (years)',
          validator: (value) {
            if (value == null || value.isEmpty) return 'Age required';
            if (int.tryParse(value) == null) return 'Invalid number';
            return null;
          },
          input: FilteringTextInputFormatter.digitsOnly,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomTextfield(
                controller: weightController,
                isObscure: false,
                keyboard: TextInputType.number,
                icon: const Icon(Icons.monitor_weight),
                color: primaryColor,
                onSaved: (value) {},
                text: 'Weight (kg)',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Weight required';
                  if (double.tryParse(value) == null) return 'Invalid';
                  return null;
                },
                input: FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextfield(
                controller: heightController,
                isObscure: false,
                keyboard: TextInputType.number,
                icon: const Icon(Icons.height),
                color: primaryColor,
                text: 'Height (cm)',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Height required';
                  if (double.tryParse(value) == null) return 'Invalid';
                  return null;
                },
                onSaved: (value) {},
                input: FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text("Gender",
            style: TextStyle(
                fontSize: 16,
                color: colors.textColor,
                fontWeight: FontWeight.w600)),
        CustomGenderRatio(
          color: primaryColor,
          selectedGender: gender,
          onGenderChanged: onGenderChanged,
        ),
      ],
    );
  }
}
