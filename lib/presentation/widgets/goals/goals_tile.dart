import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/goals/edit_goal_dialog.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/logic/porviders/goals_viewmodel.dart';

class GoalTile extends StatelessWidget {
  final String goalKey;
  const GoalTile({super.key, required this.goalKey});
  @override
  Widget build(BuildContext context) {
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
        decoration: BoxDecoration(
          boxShadow: colors.cardDecoration.boxShadow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Material(
          color: colors.cardColor,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.hardEdge,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isActive
                    ? cubit.getProgressColor(goalKey).withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(GoalsViewModel.getGoalIcon(goalKey),
                  color:
                      isActive ? cubit.getProgressColor(goalKey) : Colors.grey),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(goalKey[0].toUpperCase() + goalKey.substring(1),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: colors.textColor)),
                      Text(GoalsViewModel.getGoalDescription(goalKey),
                          style: TextStyle(
                              fontSize: 12, color: colors.subtitleColor)),
                    ],
                  ),
                ),
                if (completed)
                  _buildBadge('Completed', greenColor, Icons.check)
                else if (!isActive)
                  _buildBadge('Inactive', colors.subtitleColor, Icons.pause),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                if (goalKey == 'weight' && goal['goalType'] != null) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          _getGoalTypeColor(goal['goalType']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      goal['goalType'] == 'lose'
                          ? 'Lose Weight'
                          : goal['goalType'] == 'gain'
                              ? 'Gain Weight'
                              : 'Maintain',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _getGoalTypeColor(goal['goalType'])),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hasCurrent
                          ? '${goal['current']} / ${goal['target']} ${goal['unit']}'
                          : 'Target: ${goal['target']} ${goal['unit']}',
                      style:
                          TextStyle(fontSize: 14, color: colors.subtitleColor),
                    ),
                    if (hasCurrent && cubit.shouldShowPercentage(goalKey))
                      Text('$percent%',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: cubit.getProgressColor(goalKey))),
                  ],
                ),
                const SizedBox(height: 8),
                if (goalKey == 'weight' && hasCurrent)
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    color: isActive
                        ? cubit.getProgressColor(goalKey)
                        : Colors.grey,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        completed
                            ? Icons.check_circle
                            : hasCurrent
                                ? Icons.radio_button_checked
                                : Icons.remove_circle_outline,
                        size: 16,
                        color: completed
                            ? greenColor
                            : hasCurrent
                                ? greenColor
                                : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        hasCurrent
                            ? cubit.getGoalStatus(goalKey)
                            : 'Not tracked',
                        style: TextStyle(
                            fontSize: 12,
                            color: completed
                                ? greenColor
                                : hasCurrent
                                    ? colors.subtitleColor
                                    : Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                if (goalKey == 'weight')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        color: primaryColor,
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => EditGoalDialog(goalKey: goalKey),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ));
  }

  Widget _buildBadge(String text, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(text,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }

  Color _getGoalTypeColor(String? goalType) {
    switch (goalType) {
      case 'lose':
        return greenColor;
      case 'gain':
        return orangeColor;
      default:
        return blueColor;
    }
  }
}
