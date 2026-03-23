import 'package:flutter/material.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

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
    return Column(
      children: [
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(color),
          title: Text("Male", style: TextStyle(color: getTextColor())),
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
            style: TextStyle(color: getTextColor()),
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
