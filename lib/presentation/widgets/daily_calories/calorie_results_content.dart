import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';
import 'package:fit_tracker/presentation/widgets/daily_calories/calorie_result_row.dart';
import 'package:fit_tracker/presentation/widgets/daily_calories/calorie_goal_card.dart';
import 'package:fit_tracker/presentation/widgets/daily_calories/calorie_result_actions.dart';

class CalorieResultsContent extends StatelessWidget {
  final double bmr;
  final double dailyCalories;
  final double? maintenanceCalories;
  final String goalType;
  final double weeklyGoal;
  final String goalDescription;
  final VoidCallback? onSetGoal;

  const CalorieResultsContent({
    super.key,
    required this.bmr,
    required this.dailyCalories,
    this.maintenanceCalories,
    this.goalType = 'maintain',
    this.weeklyGoal = 0.5,
    this.goalDescription = '',
    this.onSetGoal,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.local_fire_department, color: redColor, size: 32),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(l10n.calorieResultsTitle,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: colors.textColor))),
            ]),
            const SizedBox(height: 16),
            Divider(color: colors.subtitleColor.withOpacity(0.3)),
            const SizedBox(height: 16),
            CalorieResultRow(
                title: l10n.calorieBmrFull,
                value: '${bmr.toStringAsFixed(0)} ${l10n.calorieCaloriesPerDay}',
                icon: Icons.energy_savings_leaf,
                color: blueColor),
            if (maintenanceCalories != null) ...[
              const SizedBox(height: 12),
              CalorieResultRow(
                  title: l10n.calorieMaintenanceFull,
                  value: '${maintenanceCalories!.toStringAsFixed(0)} ${l10n.calorieCaloriesPerDay}',
                  icon: Icons.balance,
                  color: greenColor),
            ],
            const SizedBox(height: 12),
            CalorieGoalCard(
              goalType: goalType,
              dailyCalories: dailyCalories,
              weeklyGoal: weeklyGoal,
              goalDescription: goalDescription,
            ),
            const SizedBox(height: 24),
            CalorieResultActions(onSetGoal: onSetGoal),
          ]),
    );
  }
}
