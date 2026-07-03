import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';

class MiniStat extends StatelessWidget {
  final AppColorsExtension colors;
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const MiniStat({
    super.key,
    required this.colors,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: colors.textColor)),
        Text(label,
            style: TextStyle(fontSize: 11, color: colors.subtitleColor)),
      ],
    );
  }
}
