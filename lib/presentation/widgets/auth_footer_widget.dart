import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';

class AuthFooter extends StatelessWidget {
  final String buttonText;
  final String questionText;
  final String linkText;
  final VoidCallback? onButtonPressed; // Make nullable
  final VoidCallback? onLinkPressed; // Make nullable

  const AuthFooter({
    required this.buttonText,
    required this.questionText,
    required this.linkText,
    this.onButtonPressed, // Now nullable
    this.onLinkPressed, // Now nullable
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subtitleColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return Column(
      children: [
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: onButtonPressed, // Can be null
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  onButtonPressed != null ? primaryColor : Colors.grey,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
            ),
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(questionText, style: TextStyle(color: subtitleColor)),
            TextButton(
              onPressed: onLinkPressed, // Can be null
              child: Text(
                linkText,
                style: TextStyle(
                  color: onLinkPressed != null ? primaryColor : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

