import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/utils/goal_utils.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class DashboardGoalsSection extends StatelessWidget {
  final VoidCallback? onViewAll;

  const DashboardGoalsSection({super.key, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final goalsVM = context.watch<GoalsViewModel>();
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final goals = goalsVM.goals;

    if (goals.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: primaryColor.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
                color: colors.shadowColor,
                blurRadius: 12,
                offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.flag_outlined,
                  size: 24, color: primaryColor.withOpacity(0.5)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.homeNoGoalsSet,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: colors.textColor)),
                  const SizedBox(height: 2),
                  Text(l10n.homeNoGoalsSubtitle,
                      style:
                          TextStyle(fontSize: 12, color: colors.subtitleColor)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 36,
              child: ElevatedButton.icon(
                onPressed: onViewAll,
                icon: const Icon(Icons.add, size: 16),
                label: Text(l10n.homeSetGoal,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final activeGoalKeys = goals.entries
        .where((e) => e.value['active'] == true)
        .map((e) => e.key)
        .toList();
    final displayKeys = activeGoalKeys.isNotEmpty
        ? activeGoalKeys
        : goals.keys.take(2).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: colors.shadowColor,
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flag_rounded, size: 18, color: primaryColor),
              const SizedBox(width: 6),
              Text(l10n.homeYourGoals,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.textColor)),
              const Spacer(),
              GestureDetector(
                onTap: onViewAll,
                child: Text(l10n.homeViewAll,
                    style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...displayKeys.map((k) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _GoalProgressTile(goalKey: k, goal: goals[k]!),
              )),
        ],
      ),
    );
  }
}

class _GoalProgressTile extends StatelessWidget {
  final String goalKey;
  final dynamic goal;

  const _GoalProgressTile({required this.goalKey, required this.goal});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final goalsVM = context.watch<GoalsViewModel>();
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final progress = goalsVM.getProgress(goalKey);
    final status = goalsVM.getGoalStatus(goalKey, unit: localizedGoalUnit(l10n, goal['unit']));
    final icon = GoalsViewModel.getGoalIcon(goalKey);
    final progressColor = goalsVM.getProgressColor(goalKey);
    final active = goal['active'] == true;

    if (!active) return const SizedBox();

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: progressColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: progressColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_goalLabel(l10n, goalKey),
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: colors.textColor)),
                  Text(status,
                      style:
                          TextStyle(fontSize: 11, color: colors.subtitleColor)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: isDark
                      ? Colors.white.withOpacity(0.08)
                      : Colors.black.withOpacity(0.06),
                  color: progressColor,
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String _goalLabel(AppLocalizations l10n, String key) {
  switch (key) {
    case 'calories': return l10n.goalsCalories;
    case 'protein': return l10n.goalsProtein;
    case 'weight': return l10n.goalsWeight;
    default: return key[0].toUpperCase() + key.substring(1);
  }
}
