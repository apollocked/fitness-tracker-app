import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class CustomBodyTypeRatio extends StatelessWidget {
  final bool isBodybuilder;
  final Function(bool) onChanged;

  const CustomBodyTypeRatio({
    super.key,
    required this.isBodybuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(orangeColor),
          title: Text("No", style: TextStyle(color: getTextColor())),
          value: false.toString(),
          groupValue: isBodybuilder.toString(),
          onChanged: (value) {
            onChanged(false);
          },
        ),
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(orangeColor),
          title: Text(
            "Yes",
            style: TextStyle(color: getTextColor()),
          ),
          value: true.toString(),
          groupValue: isBodybuilder.toString(),
          onChanged: (value) {
            onChanged(true);
          },
        ),
      ],
    );
  }
}
