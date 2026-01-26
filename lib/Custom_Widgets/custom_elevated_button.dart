import 'package:flutter/material.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {super.key,
      required this.onpressed,
      required this.text,
      required this.color});

  dynamic text;
  dynamic onpressed;
  Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        onPressed: onpressed,
        child: Text(
          text.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: getTextColor(),
          ),
        ));
  }
}
