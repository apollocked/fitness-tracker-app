import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/utils/goal_utils.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GoalSquareProgress extends StatelessWidget {
  final double target;
  final String unit;
  final Color cardColor;

  const GoalSquareProgress({
    super.key,
    required this.target,
    required this.unit,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.goalsDailyGoal,
            style: TextStyle(fontSize: 11, color: colors.subtitleColor)),
        const SizedBox(height: 4),
        Text('${target.toStringAsFixed(0)} ${localizedGoalUnit(l10n, unit)}',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colors.textColor,
                height: 1.1)),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.circle, size: 8, color: greenColor),
            const SizedBox(width: 6),
            Text(l10n.goalsGoalSet,
                style: TextStyle(
                    fontSize: 11,
                    color: greenColor,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
