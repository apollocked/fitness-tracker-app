// lib/pages/Profile/Goals/widgets/goals_square_row.dart
// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:myapp/pages/Profile/Goals/goals_controller.dart';
import 'package:myapp/pages/Profile/Goals/goals_square_card.dart';

class GoalsSquareRow extends StatelessWidget {
  final GoalsController controller;

  const GoalsSquareRow({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasCalorieGoal = controller.goals.containsKey('calories');
    final hasProteinGoal = controller.goals.containsKey('protein');

    if (!hasCalorieGoal && !hasProteinGoal) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (hasCalorieGoal)
            Expanded(
              child:
                  GoalsSquareCard(goalKey: 'calories', controller: controller),
            ),
          if (hasCalorieGoal && hasProteinGoal) const SizedBox(width: 12),
          if (hasProteinGoal)
            Expanded(
              child:
                  GoalsSquareCard(goalKey: 'protein', controller: controller),
            ),
        ],
      ),
    );
  }
}
