import 'package:flutter/material.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GoalProgressBanner extends StatelessWidget {
  final GoalsViewModel goalsVM;
  final AppColorsExtension colors;

  const GoalProgressBanner({
    super.key,
    required this.goalsVM,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final weightGoal = goalsVM.goals['weight'];
    if (weightGoal == null || weightGoal['active'] != true) {
      return const SizedBox();
    }

    final current = (weightGoal['current'] as num?)?.toDouble() ?? 0;
    final target = (weightGoal['target'] as num?)?.toDouble() ?? 0;
    final progress = target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            greenColor.withOpacity(isDark ? 0.2 : 0.1),
            greenColor.withOpacity(isDark ? 0.08 : 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: greenColor.withOpacity(isDark ? 0.3 : 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: greenColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.monitor_weight_outlined,
                color: greenColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.progressGoalProgress,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: colors.textColor)),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: isDark
                        ? Colors.white.withOpacity(0.08)
                        : Colors.black.withOpacity(0.06),
                    color: greenColor,
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                    l10n.progressGoalForValue(
                        '${current.toStringAsFixed(1)} / ${target.toStringAsFixed(1)} ${l10n.progressKg}'),
                    style:
                        TextStyle(fontSize: 11, color: colors.subtitleColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
