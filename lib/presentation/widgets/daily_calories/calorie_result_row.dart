import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';

class CalorieResultRow extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const CalorieResultRow({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Row(children: [
      Icon(icon, color: color, size: 24),
      const SizedBox(width: 12),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: TextStyle(fontSize: 13, color: colors.subtitleColor)),
        Text(value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colors.textColor)),
      ])),
    ]);
  }
}
