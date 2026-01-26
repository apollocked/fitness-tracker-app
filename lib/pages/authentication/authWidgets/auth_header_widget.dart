import 'package:flutter/material.dart';
import 'package:myapp/utils/assets.dart';
import 'package:myapp/utils/colors.dart';

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
    return Column(
      children: [
        logoWidget,
        const SizedBox(height: 30),
        Text(
          title,
          style: TextStyle(
            fontSize: title.length > 15 ? 24 : 32,
            fontWeight: FontWeight.bold,
            color: title.length > 15 ? primaryColor : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
