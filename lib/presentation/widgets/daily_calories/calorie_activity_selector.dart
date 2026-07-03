import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class CalorieActivitySelector extends StatelessWidget {
  final String activityLevel;
  final ValueChanged<String> onActivityChanged;

  const CalorieActivitySelector({
    super.key,
    required this.activityLevel,
    required this.onActivityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.calorieActivityLevel,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colors.textColor)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: colors.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.subtitleColor.withOpacity(0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: activityLevel,
              dropdownColor: colors.cardColor,
              style: TextStyle(
                  color: colors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              isExpanded: true,
              items: [
                DropdownMenuItem(
                    value: 'Sedentary',
                    child: Text(l10n.calorieActivitySedentaryFull)),
                DropdownMenuItem(
                    value: 'Lightly Active',
                    child: Text(l10n.calorieActivityLightFull)),
                DropdownMenuItem(
                    value: 'Moderately Active',
                    child: Text(l10n.calorieActivityModerateFull)),
                DropdownMenuItem(
                    value: 'Very Active',
                    child: Text(l10n.calorieActivityActiveFull)),
                DropdownMenuItem(
                    value: 'Extra Active',
                    child: Text(l10n.calorieActivityExtraFull)),
              ],
              onChanged: (value) => onActivityChanged(value!),
            ),
          ),
        ),
      ],
    );
  }
}
