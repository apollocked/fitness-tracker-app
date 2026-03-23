import 'package:flutter/material.dart';
import 'package:myapp/pages/Profile/Goals/goals_controller.dart';
import 'package:myapp/utils/app_theme.dart';
import 'package:myapp/utils/colors.dart';

class GoalsStats extends StatelessWidget {
  final GoalsController controller;

  // ignore: use_super_parameters
  const GoalsStats({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    // Count only active goals
    final activeGoals =
        controller.goals.values.where((g) => g['active'] == true).length;
    final completedGoals = controller.completedCount;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: colors.cardDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(colors,
              'Total', controller.goals.length.toString(), Icons.list),
          _buildStatItem(colors, 'Active', activeGoals.toString(), Icons.flag),
          _buildStatItem(colors,
              'Completed', completedGoals.toString(), Icons.check_circle),
        ],
      ),
    );
  }

  Widget _buildStatItem(AppColorsExtension colors, String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: primaryColor),
        ),
        const SizedBox(height: 8),
        Text(value,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.textColor)),
        Text(title, style: TextStyle(fontSize: 12, color: colors.subtitleColor)),
      ],
    );
  }
}
