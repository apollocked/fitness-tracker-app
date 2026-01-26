import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/Custom_Widgets/select_gender_radio.dart';
import 'package:myapp/utils/colors.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Personal Information",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[700])),
        const SizedBox(height: 16),
        CustomTextfeild(
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
              child: CustomTextfeild(
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
              child: CustomTextfeild(
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
        const Text("Gender", style: TextStyle(fontSize: 14)),
        CustomGenderRatio(
          color: primaryColor,
          initialGender: "Male",
          onGenderChanged: onGenderChanged,
        ),
      ],
    );
  }
}
