// lib/pages/Profile/Goals/goals_tile.dart
// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:myapp/pages/Profile/Goals/edit_goal_dialog.dart';
import 'package:myapp/pages/Profile/Goals/goals_controller.dart';
import 'package:myapp/utils/dark_mode_helper.dart';
import 'package:myapp/utils/colors.dart';

class GoalTile extends StatelessWidget {
  final String goalKey;
  final GoalsController controller;

  const GoalTile({Key? key, required this.goalKey, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final goal = controller.goals[goalKey];
    if (goal == null) return const SizedBox();

    final progress = controller.getProgress(goalKey);
    final percent = (progress * 100).toInt();
    final completed = progress >= 1.0;
    final isActive = goal['active'] == true;
    final hasCurrent = goal['current'] != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: getCardDecoration(),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isActive
                ? controller.getProgressColor(goalKey).withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(GoalsController.getGoalIcon(goalKey),
              color: isActive
                  ? controller.getProgressColor(goalKey)
                  : Colors.grey),
        ),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(GoalsController.capitalize(goalKey),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: getTextColor())),
                  Text(GoalsController.getGoalDescription(goalKey),
                      style:
                          TextStyle(fontSize: 12, color: getSubtitleColor())),
                ],
              ),
            ),
            if (completed)
              _buildBadge('Completed', greenColor, Icons.check)
            else if (!isActive)
              _buildBadge('Inactive', getSubtitleColor(), Icons.pause),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Goal type badge for weight goals only
            if (goalKey == 'weight' && goal['goalType'] != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getGoalTypeColor(goal['goalType']).withOpacity(0.1),
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
                    color: _getGoalTypeColor(goal['goalType']),
                  ),
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
                  style: TextStyle(fontSize: 14, color: getSubtitleColor()),
                ),
                if (hasCurrent && controller.shouldShowPercentage(goalKey))
                  Text('$percent%',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: controller.getProgressColor(goalKey))),
              ],
            ),
            const SizedBox(height: 8),

            // Progress bar for weight goals only
            if (goalKey == 'weight' && hasCurrent)
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.withOpacity(0.3),
                color: isActive
                    ? controller.getProgressColor(goalKey)
                    : Colors.grey,
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
            const SizedBox(height: 8),

            // Status text
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
                        ? controller.getGoalStatus(goalKey)
                        : 'Not tracked',
                    style: TextStyle(
                      fontSize: 12,
                      color: completed
                          ? greenColor
                          : hasCurrent
                              ? getSubtitleColor()
                              : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Edit button - ONLY FOR WEIGHT GOALS
            if (goalKey == 'weight')
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    color: primaryColor,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => EditGoalDialog(
                        goalKey: goalKey,
                        controller: controller,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
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
