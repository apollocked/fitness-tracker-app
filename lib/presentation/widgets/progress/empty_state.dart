import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class ProgressEmptyState extends StatelessWidget {
  const ProgressEmptyState({super.key, required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final goalsVM = context.watch<GoalsViewModel>();
    final hasGoals = goalsVM.goals.isNotEmpty;
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Spacer(flex: 2),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                  color: primaryColor.withOpacity(isDark ? 0.25 : 0.15),
                  width: 2),
            ),
            child:
                Icon(Icons.show_chart_rounded, size: 64, color: primaryColor),
          ),
          const SizedBox(height: 24),
          Text(l10n.progressNoMeasurements,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colors.textColor)),
          const SizedBox(height: 8),
          Text(
              hasGoals
                  ? l10n.progressSetGoalFirst
                  : l10n.progressLogFirstWeight,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.subtitleColor)),
          const Spacer(flex: 2),
          Icon(Icons.arrow_downward_rounded, size: 50, color: primaryColor),
          const SizedBox(height: 12),
          Text(
            l10n.progressTapButton,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: colors.subtitleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}
