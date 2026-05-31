import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/logic/porviders/goals_viewmodel.dart';

class GoalsSquareCard extends StatelessWidget {
  final String goalKey;
  const GoalsSquareCard({super.key, required this.goalKey});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final goal = context.watch<GoalsViewModel>().goals[goalKey];
    if (goal == null) return const SizedBox();
    final target = goal['target'];
    final unit = goal['unit'];
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
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cardColor.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: cardColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6)),
                  child: Icon(icon, color: cardColor, size: 16),
                ),
                const SizedBox(width: 8),
                Text(title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colors.textColor)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Daily Goal',
                    style:
                        TextStyle(fontSize: 11, color: colors.subtitleColor)),
                const SizedBox(height: 4),
                Text('${target.toStringAsFixed(0)} $unit',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colors.textColor,
                        height: 1)),
              ],
            ),
            const Row(
              children: [
                Icon(Icons.circle, size: 8, color: Colors.green),
                SizedBox(width: 6),
                Text('Goal Set',
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.green,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
