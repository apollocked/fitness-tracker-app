import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';

class CustomGenderRatio extends StatefulWidget {
  const CustomGenderRatio({
    super.key,
    required this.color,
    required this.onGenderChanged,
    this.initialGender = "Male",
  });

  final Color color;
  final Function(String) onGenderChanged;
  final String initialGender;

  @override
  State<CustomGenderRatio> createState() => _CustomRatioState();
}

class _CustomRatioState extends State<CustomGenderRatio> {
  late String selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.initialGender;
  }

  void _handleGenderChange(String gender) {
    setState(() {
      selectedGender = gender;
    });
    widget.onGenderChanged(gender);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(widget.color),
          title: Text("Male", style: TextStyle(color: blackColor)),
          value: "Male",
          groupValue: selectedGender,
          onChanged: (value) {
            if (value != null) {
              _handleGenderChange(value);
            }
          },
        ),
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(widget.color),
          title: Text(
            "Female",
            style: TextStyle(color: blackColor),
          ),
          value: "Female",
          groupValue: selectedGender,
          onChanged: (value) {
            if (value != null) {
              _handleGenderChange(value);
            }
          },
        ),
      ],
    );
  }
}
