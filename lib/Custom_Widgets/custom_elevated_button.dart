import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';

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
          foregroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onpressed,
        child: Text(
          text.toString(),
          style: const TextStyle(
            fontSize: 18,
          ),
        ));
  }
}
