import 'package:flutter/material.dart';
import 'package:fit_tracker/config/theme/app_theme.dart';

class StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? color;

  const StatItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).primaryColor;
    final colors = Theme.of(context).extension<AppColorsExtension>();
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: c.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: c),
        ),
        const SizedBox(height: 8),
        Text(value,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors?.textColor)),
        Text(label,
            style: TextStyle(fontSize: 12, color: colors?.subtitleColor)),
      ],
    );
  }
}
