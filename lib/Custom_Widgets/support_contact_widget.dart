import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class SupportContactWidget extends StatelessWidget {
  final String email;
  final String title;

  const SupportContactWidget({
    required this.email,
    this.title = 'Need Help?',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            isDarkMode() ? Colors.blue[900]!.withOpacity(0.3) : Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: getTextColor()),
          ),
          const SizedBox(height: 12),
          Text(
            'Contact our support team:',
            style: TextStyle(fontSize: 14, color: getSubtitleColor()),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.email, color: primaryColor, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Support Email',
                      style: TextStyle(fontSize: 12, color: getSubtitleColor()),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
