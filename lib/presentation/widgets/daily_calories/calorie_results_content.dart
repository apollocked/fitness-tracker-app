import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

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
            _buildResultRow(
                l10n.calorieBmrFull,
                '${bmr.toStringAsFixed(0)} ${l10n.calorieCaloriesPerDay}',
                Icons.energy_savings_leaf,
                blueColor,
                colors),
            if (maintenanceCalories != null) ...[
              const SizedBox(height: 12),
              _buildResultRow(
                  l10n.calorieMaintenanceFull,
                  '${maintenanceCalories!.toStringAsFixed(0)} ${l10n.calorieCaloriesPerDay}',
                  Icons.balance,
                  greenColor,
                  colors),
            ],
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getGoalColor(goalType).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: _getGoalColor(goalType).withOpacity(0.3)),
              ),
              child: Row(children: [
                Icon(_getGoalIcon(goalType),
                    color: _getGoalColor(goalType), size: 28),
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
                              color: _getGoalColor(goalType))),
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
            const SizedBox(height: 24),
            Row(children: [
              Expanded(
                  child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: primaryColor),
                ),
                child: Text(l10n.calorieClose,
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.w600)),
              )),
              const SizedBox(width: 12),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  onSetGoal?.call();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                child: Text(l10n.calorieSetAsGoal,
                    style: TextStyle(fontWeight: FontWeight.w600)),
              )),
            ]),
          ]),
    );
  }

  Widget _buildResultRow(String title, String value, IconData icon, Color color,
      AppColorsExtension colors) {
    return Row(children: [
      Icon(icon, color: color, size: 24),
      const SizedBox(width: 12),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: TextStyle(fontSize: 13, color: colors.subtitleColor)),
        Text(value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colors.textColor)),
      ])),
    ]);
  }

  Color _getGoalColor(String gt) => switch (gt) {
        'lose' => greenColor,
        'gain' => orangeColor,
        _ => blueColor
      };
  IconData _getGoalIcon(String gt) => switch (gt) {
        'lose' => Icons.trending_down,
        'gain' => Icons.trending_up,
        _ => Icons.trending_flat
      };
}
