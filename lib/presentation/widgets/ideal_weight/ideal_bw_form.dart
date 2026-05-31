import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_textfield.dart';
import 'package:fit_tracker/presentation/widgets/shared/select_gender_radio.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

/// Form fields for the Ideal Body Weight calculator.
class IdealBwForm extends StatelessWidget {
  const IdealBwForm({
    super.key,
    required this.formKey,
    required this.heightController,
    required this.weightController,
    required this.targetWeightController,
    required this.gender,
    required this.onGenderChanged,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController targetWeightController;
  final String gender;
  final ValueChanged<String> onGenderChanged;

  String? _numValidator(String? v, String field) {
    if (v == null || v.isEmpty) return 'Enter your $field';
    if (double.tryParse(v) == null) return 'Invalid number';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Form(
      key: formKey,
      child: Column(children: [
        Text('Select Your Gender',
            style: TextStyle(color: colors.subtitleColor, fontSize: 15)),
        CustomGenderRatio(
            color: blueColor,
            selectedGender: gender,
            onGenderChanged: onGenderChanged),
        const SizedBox(height: 16),
        CustomTextfield(
          controller: heightController,
          isObscure: false,
          keyboard: TextInputType.number,
          color: blueColor,
          onSaved: (_) {},
          text: 'Height (cm)',
          icon: const Icon(Icons.height_rounded),
          input: FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          validator: (v) => _numValidator(v, 'height'),
        ),
        const SizedBox(height: 14),
        CustomTextfield(
          controller: weightController,
          isObscure: false,
          keyboard: TextInputType.number,
          color: blueColor,
          onSaved: (_) {},
          text: 'Current Weight (kg)',
          icon: const Icon(Icons.monitor_weight_outlined),
          input: FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          validator: (v) => _numValidator(v, 'weight'),
        ),
        const SizedBox(height: 14),
        CustomTextfield(
          controller: targetWeightController,
          isObscure: false,
          keyboard: TextInputType.number,
          color: blueColor,
          onSaved: (_) {},
          text: 'Target Weight (kg) — Optional',
          icon: const Icon(Icons.flag_outlined),
          input: FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          validator: (v) {
            if (v != null && v.isNotEmpty && double.tryParse(v) == null) {
              return 'Invalid number';
            }
            return null;
          },
        ),
      ]),
    );
  }
}
