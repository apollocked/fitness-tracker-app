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
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: color, width: 1)),
            minimumSize: const Size(70, 35)),
        onPressed: onpressed,
        child: Text(
          "OK",
          style: TextStyle(color: secondColor),
        ));
  }
}
