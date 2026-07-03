import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class CalorieGoalCard extends StatelessWidget {
  final String goalType;
  final double dailyCalories;
  final double weeklyGoal;
  final String goalDescription;

  const CalorieGoalCard({
    super.key,
    required this.goalType,
    required this.dailyCalories,
    this.weeklyGoal = 0.5,
    this.goalDescription = '',
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _goalColor(goalType).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _goalColor(goalType).withOpacity(0.3)),
          ),
          child: Row(children: [
            Icon(_goalIcon(goalType),
                color: _goalColor(goalType), size: 28),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(goalDescription,
                      style: TextStyle(
                          fontSize: 14, color: colors.subtitleColor)),
                  Text(
                      '${dailyCalories.toStringAsFixed(0)} ${l10n.calorieCaloriesPerDay}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _goalColor(goalType))),
                ])),
          ]),
        ),
        if (goalType != 'maintain') ...[
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.cardColor,
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: colors.subtitleColor.withOpacity(0.3)),
            ),
            child: Row(children: [
              Icon(Icons.info, color: orangeColor, size: 20),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(
                      goalType == 'lose'
                          ? l10n.calorieToLoseInfo(
                              weeklyGoal.toStringAsFixed(1),
                              dailyCalories.toStringAsFixed(0))
                          : l10n.calorieToGainInfo(
                              weeklyGoal.toStringAsFixed(1),
                              dailyCalories.toStringAsFixed(0)),
                      style: TextStyle(
                          fontSize: 13, color: colors.subtitleColor))),
            ]),
          ),
        ],
      ],
    );
  }

  Color _goalColor(String gt) => switch (gt) {
        'lose' => greenColor,
        'gain' => orangeColor,
        _ => blueColor
      };
  IconData _goalIcon(String gt) => switch (gt) {
        'lose' => Icons.trending_down,
        'gain' => Icons.trending_up,
        _ => Icons.trending_flat
      };
}
