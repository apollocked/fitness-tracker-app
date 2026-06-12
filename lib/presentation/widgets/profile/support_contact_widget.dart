import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/presentation/widgets/shared/app_card.dart';

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
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return AppCard(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      borderColor: primaryColor.withOpacity(0.3),
      elevation: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.textColor),
          ),
          const SizedBox(height: 12),
          Text(
            'Contact our support team:',
            style: TextStyle(fontSize: 14, color: colors.subtitleColor),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.email_outlined, color: primaryColor, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Support Email',
                      style:
                          TextStyle(fontSize: 12, color: colors.subtitleColor),
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
