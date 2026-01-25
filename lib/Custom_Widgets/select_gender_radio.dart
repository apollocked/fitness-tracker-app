// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class CustomGenderRatio extends StatefulWidget {
  CustomGenderRatio({
    super.key,
    required this.color,
    required this.onGenderChanged,
    this.initialGender = "Male",
  });
  Color color;
  Function(String) onGenderChanged;
  String initialGender;

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
            setState(() {
              currentUser!["gender"] = "Male";
              selectedGender = "Male";
              widget.onGenderChanged("Male");
            });
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
            setState(() {
              currentUser!["gender"] = "Female";
              selectedGender = "Female";
              widget.onGenderChanged("Female");
            });
          },
        ),
      ],
    );
  }
}
