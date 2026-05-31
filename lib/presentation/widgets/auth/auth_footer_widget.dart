import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    required this.buttonText,
    required this.questionText,
    required this.linkText,
    this.onButtonPressed,
    this.onLinkPressed,
    super.key,
  });

  final String buttonText;
  final String questionText;
  final String linkText;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onLinkPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isEnabled = onButtonPressed != null;

    return Column(children: [
      const SizedBox(height: 24),
      SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: onButtonPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isEnabled ? primaryColor : colors.subtitleColor,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
          ),
          child: Text(buttonText,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      ),
      const SizedBox(height: 16),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(questionText,
            style: TextStyle(color: colors.subtitleColor, fontSize: 14)),
        TextButton(
          onPressed: onLinkPressed,
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero, minimumSize: Size.zero),
          child: Text(linkText,
              style: TextStyle(
                color:
                    onLinkPressed != null ? primaryColor : colors.subtitleColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              )),
        ),
      ]),
    ]);
  }
}
