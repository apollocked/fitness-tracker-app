import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/Custom_Widgets/select_gender_radio.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class DailyCalorieInputSection extends StatefulWidget {
  final TextEditingController ageController;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final String activityLevel;
  final Function(String) onActivityChanged;

  const DailyCalorieInputSection({
    required this.ageController,
    required this.weightController,
    required this.heightController,
    required this.activityLevel,
    required this.onActivityChanged,
    super.key,
  });

  @override
  State<DailyCalorieInputSection> createState() =>
      _DailyCalorieInputSectionState();
}

class _DailyCalorieInputSectionState extends State<DailyCalorieInputSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Gender',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        CustomGenderRatio(
          color: redColor,
          onGenderChanged: (value) => currentUser?["gender"] = value,
        ),
        const SizedBox(height: 16),
        CustomTextfeild(
          controller: widget.ageController,
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
        CustomTextfeild(
          controller: widget.weightController,
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
        CustomTextfeild(
          controller: widget.heightController,
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
        const Text('Activity Level',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: secondColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.activityLevel,
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
              onChanged: (value) => widget.onActivityChanged(value!),
            ),
          ),
        ),
      ],
    );
  }
}
