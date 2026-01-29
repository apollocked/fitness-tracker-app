// lib/pages/Profile/Goals/widgets/goals_square_card.dart
// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:myapp/pages/Profile/Goals/goals_controller.dart';
import 'package:myapp/utils/dark_mode_helper.dart';
import 'package:myapp/utils/colors.dart';

class GoalsSquareCard extends StatelessWidget {
  final String goalKey;
  final GoalsController controller;

  const GoalsSquareCard({
    Key? key,
    required this.goalKey,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final goal = controller.goals[goalKey];
    if (goal == null) return const SizedBox();

    final target = goal['target'];
    final unit = goal['unit'];

    // Card styling
    Color cardColor;
    IconData icon;
    String title;

    switch (goalKey) {
      case 'calories':
        cardColor = Colors.red;
        icon = Icons.local_fire_department;
        title = 'Calories';
        break;
      case 'protein':
        cardColor = Colors.orange;
        icon = Icons.restaurant;
        title = 'Protein';
        break;
      default:
        cardColor = primaryColor;
        icon = Icons.flag;
        title = goalKey;
    }

    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: getCardColor(),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cardColor.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon and title
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: cardColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(icon, color: cardColor, size: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: getTextColor(),
                  ),
                ),
              ],
            ),

            // Target value
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Goal',
                  style: TextStyle(
                    fontSize: 11,
                    color: getSubtitleColor(),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${target.toStringAsFixed(0)} $unit',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: getTextColor(),
                    height: 1,
                  ),
                ),
              ],
            ),

            // Simple status - NO EDIT BUTTON
            const Row(
              children: [
                Icon(Icons.circle, size: 8, color: Colors.green),
                SizedBox(width: 6),
                Text(
                  'Goal Set',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
