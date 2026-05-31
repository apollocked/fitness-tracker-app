import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

/// Requirements checklist shown on the registration page.
class RequirementsChecklist extends StatelessWidget {
  const RequirementsChecklist({super.key});

  static const _items = [
    'Username (minimum 3 characters)',
    'Valid email address',
    'Password (minimum 6 characters)',
    'Age (older than 12 years)',
    'Weight (in kg)',
    'Height (in cm)',
    'Gender selection',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? colors.cardColor : primaryColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primaryColor.withOpacity(isDark ? 0.3 : 0.2)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Account Requirements',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: primaryColor)),
        const SizedBox(height: 10),
        ..._items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Row(children: [
                Icon(Icons.check_circle_outline_rounded, size: 16, color: primaryColor),
                const SizedBox(width: 8),
                Expanded(child: Text(item, style: TextStyle(fontSize: 12, color: colors.subtitleColor))),
              ]),
            )),
      ]),
    );
  }
}
