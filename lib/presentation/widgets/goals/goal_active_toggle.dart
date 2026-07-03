import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GoalActiveToggle extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const GoalActiveToggle({
    super.key,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.subtitleColor.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(l10n.goalEditActiveGoal,
              style: TextStyle(fontSize: 16, color: colors.textColor)),
          Switch(
              value: isActive,
              activeColor: primaryColor,
              onChanged: onChanged),
        ],
      ),
    );
  }
}
