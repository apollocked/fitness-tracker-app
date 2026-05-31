import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class CustomGenderRatio extends StatelessWidget {
  const CustomGenderRatio({
    super.key,
    required this.color,
    required this.onGenderChanged,
    required this.selectedGender,
  });
  final Color color;
  final Function(String) onGenderChanged;
  final String selectedGender;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      children: [
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(color),
          title: Text("Male", style: TextStyle(color: colors.textColor)),
          value: "Male",
          groupValue: selectedGender,
          onChanged: (value) {
            if (value != null) {
              onGenderChanged(value);
            }
          },
        ),
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(color),
          title: Text(
            "Female",
            style: TextStyle(color: colors.textColor),
          ),
          value: "Female",
          groupValue: selectedGender,
          onChanged: (value) {
            if (value != null) {
              onGenderChanged(value);
            }
          },
        ),
      ],
    );
  }
}
