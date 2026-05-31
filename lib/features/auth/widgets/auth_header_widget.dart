import 'package:flutter/material.dart';
import 'package:fit_tracker/core/constants.dart';
import 'package:fit_tracker/core/theme/colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthHeader({
    required this.title,
    required this.subtitle,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey[400] : Colors.grey[600];
    return Column(
      children: [
        logoWidget,
        const SizedBox(height: 30),
        Text(
          title,
          style: TextStyle(
            fontSize: title.length > 15 ? 24 : 32,
            fontWeight: FontWeight.bold,
            color: title.length > 15 ? primaryColor : textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(fontSize: 16, color: subtitleColor),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

