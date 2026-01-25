// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class CustomGenderRatio extends StatefulWidget {
  CustomGenderRatio({
    super.key,
    required this.color,
  });
  Color color;
  @override
  State<CustomGenderRatio> createState() => _CustomRatioState();
}

class _CustomRatioState extends State<CustomGenderRatio> {
  @override
  Widget build(BuildContext context) {
    var user = currentUser!;
    return Column(
      children: [
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll((widget.color)),
          title: Text("Male", style: TextStyle(color: blackColor)),
          value: "Male",
          groupValue: user["gender"],
          onChanged: (value) {
            setState(() {
              user["gender"] = "Male";
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
