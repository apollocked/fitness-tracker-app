import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class CalcPromptCard extends StatelessWidget {
  const CalcPromptCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final goalsVM = context.watch<GoalsViewModel>();
    final hasCalories = goalsVM.goals.containsKey('calories');
    final hasProtein = goalsVM.goals.containsKey('protein');
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(isDark ? 0.1 : 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_fix_high_rounded, size: 20, color: primaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              !hasCalories && !hasProtein
                  ? l10n.goalsPromptBothMissing
                  : !hasCalories
                      ? l10n.goalsPromptCaloriesMissing
                      : l10n.goalsPromptProteinMissing,
              style: TextStyle(fontSize: 12, color: colors.textColor, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
