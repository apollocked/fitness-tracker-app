import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GoalTypeSelector extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const GoalTypeSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: l10n.goalEditGoalType,
        labelStyle: TextStyle(color: colors.subtitleColor),
        filled: true,
        fillColor: colors.cardColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: colors.subtitleColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dropdownColor: colors.cardColor,
      items: [
        DropdownMenuItem(
            value: 'lose',
            child: Text(l10n.goalEditLoseWeight,
                style: TextStyle(color: colors.textColor))),
        DropdownMenuItem(
            value: 'gain',
            child: Text(l10n.goalEditGainWeight,
                style: TextStyle(color: colors.textColor))),
        DropdownMenuItem(
            value: 'maintain',
            child: Text(l10n.goalEditMaintainWeight,
                style: TextStyle(color: colors.textColor))),
      ],
      onChanged: onChanged,
    );
  }
}
