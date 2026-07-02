import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/goals/edit_goal_dialog.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

String _goalLabel(AppLocalizations l10n, String key) {
  switch (key) {
    case 'calories': return l10n.goalsCalories;
    case 'protein': return l10n.goalsProtein;
    case 'weight': return l10n.goalsWeight;
    default: return key[0].toUpperCase() + key.substring(1);
  }
}

String _goalDescription(AppLocalizations l10n, String key) {
  switch (key) {
    case 'calories': return l10n.goalsDescriptionCalorie;
    case 'protein': return l10n.goalsDescriptionProtein;
    case 'weight': return l10n.goalsDescriptionWeight;
    default: return '';
  }
}

class GoalTile extends StatelessWidget {
  final String goalKey;
  const GoalTile({super.key, required this.goalKey});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final cubit = context.watch<GoalsViewModel>();
    final goal = cubit.goals[goalKey];
    if (goal == null) return const SizedBox();
    final progress = cubit.getProgress(goalKey);
    final percent = (progress * 100).toInt();
    final completed = progress >= 1.0;
    final isActive = goal['active'] == true;
    final hasCurrent = goal['current'] != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(boxShadow: colors.cardDecoration.boxShadow, borderRadius: BorderRadius.circular(16)),
      child: Material(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.hardEdge,
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              color: isActive ? cubit.getProgressColor(goalKey).withOpacity(0.1) : colors.subtitleColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(GoalsViewModel.getGoalIcon(goalKey),
                color: isActive ? cubit.getProgressColor(goalKey) : colors.subtitleColor),
          ),
          title: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(goal['label'] ?? _goalLabel(l10n, goalKey), style: TextStyle(fontWeight: FontWeight.bold, color: colors.textColor))),
                Text(cubit.getGoalStatus(goalKey), style: TextStyle(fontSize: 12, color: colors.subtitleColor)),
              ]),
              const SizedBox(height: 4),
              Text(_goalDescription(l10n, goalKey), style: TextStyle(fontSize: 12, color: colors.subtitleColor)),
              if (hasCurrent) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    backgroundColor: colors.subtitleColor.withOpacity(0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(
                        completed ? greenColor : cubit.getProgressColor(goalKey)),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Text('$percent%', style: TextStyle(fontSize: 11, color: colors.subtitleColor)),
              ],
              if (cubit.shouldShowPercentage(goalKey)) ...[
                const SizedBox(height: 4),
                Text('${goal['target']} ${goal['unit'] ?? ''}',
                    style: TextStyle(fontSize: 11, color: colors.subtitleColor)),
              ],
            ])),
          ]),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            if (completed)
              const Icon(Icons.check_circle, color: greenColor, size: 22),
            if (!completed && isActive)
              IconButton(
                icon: Icon(Icons.edit_outlined, color: colors.subtitleColor, size: 20),
                onPressed: () => showDialog(context: context, builder: (_) => EditGoalDialog(goalKey: goalKey)),
              ),
            if (!isActive)
              IconButton(
                icon: const Icon(Icons.replay_outlined, size: 20),
                color: primaryColor,
                onPressed: () => cubit.updateGoal(goalKey, {...goal, 'active': true}),
              ),
          ]),
        ),
      ),
    );
  }
}
