import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';

class AuthFooter extends StatelessWidget {
  final String buttonText;
  final String questionText;
  final String linkText;
  final VoidCallback onButtonPressed;
  final VoidCallback onLinkPressed;

  const AuthFooter({
    required this.buttonText,
    required this.questionText,
    required this.linkText,
    required this.onButtonPressed,
    required this.onLinkPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
            Text(questionText, style: TextStyle(color: Colors.grey[600])),
            TextButton(
              onPressed: onLinkPressed,
              child: Text(
                linkText,
                style: TextStyle(
                  color: primaryColor,
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
