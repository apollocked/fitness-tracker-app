import 'package:flutter/material.dart';
import 'package:fit_tracker/config/theme/app_theme.dart';
import 'package:fit_tracker/config/theme/app_colors.dart';

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
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      children: [
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(orangeColor),
          title: Text("No", style: TextStyle(color: colors.textColor)),
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
            style: TextStyle(color: colors.textColor),
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

