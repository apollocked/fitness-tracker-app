import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({required this.title, required this.subtitle, super.key});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child:
            Icon(Icons.fitness_center_rounded, size: 48, color: primaryColor),
      ),
      const SizedBox(height: 24),
      Text(title,
          style: TextStyle(
            fontSize: title.length > 12 ? 22 : 28,
            fontWeight: FontWeight.bold,
            color: title.length > 12 ? primaryColor : colors.textColor,
          )),
      const SizedBox(height: 6),
      Text(subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: colors.subtitleColor)),
      const SizedBox(height: 32),
    ]);
  }
}
