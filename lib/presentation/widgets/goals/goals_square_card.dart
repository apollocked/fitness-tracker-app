import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';

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
        cardColor = redColor;
        icon = Icons.local_fire_department;
        title = 'Calories';
        break;
      case 'protein':
        cardColor = orangeColor;
        icon = Icons.restaurant;
        title = 'Protein';
        break;
      default:
        cardColor = primaryColor;
        icon = Icons.flag;
        title = goalKey;
    }
    return Container(
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardColor.withOpacity(0.25), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: colors.shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
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
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                      color: cardColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: cardColor, size: 18),
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
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: colors.textColor,
                        height: 1.1)),
              ],
            ),
              Row(
                children: [
                  Icon(Icons.circle, size: 8, color: greenColor),
                  SizedBox(width: 6),
                  Text('Goal Set',
                      style: TextStyle(
                          fontSize: 11,
                          color: greenColor,
                          fontWeight: FontWeight.w600)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
