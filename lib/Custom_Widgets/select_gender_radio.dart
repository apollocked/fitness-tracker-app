// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class CustomGenderRatio extends StatefulWidget {
  const CustomGenderRatio({
    super.key,
  });

  @override
  State<CustomGenderRatio> createState() => _CustomRatioState();
}

class _CustomRatioState extends State<CustomGenderRatio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(secondColor),
          title: Text("Male", style: TextStyle(color: primaryColor)),
          value: "Male",
          groupValue: user["gender"],
          onChanged: (value) {
            setState(() {
              user["gender"] = "Male";
            });
          },
        ),
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(secondColor),
          title: Text(
            "Female",
            style: TextStyle(color: primaryColor),
          ),
          value: "Female",
          groupValue: user["gender"],
          onChanged: (value) {
            setState(() {
              user["gender"] = "Female";
            });
          },
        ),
      ],
    );
  }
}
