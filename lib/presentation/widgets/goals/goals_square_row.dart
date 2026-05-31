import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/goals/goals_square_card.dart';
import 'package:fit_tracker/logic/porviders/goals_viewmodel.dart';

class GoalsSquareRow extends StatelessWidget {
  const GoalsSquareRow({super.key});
  @override
  Widget build(BuildContext context) {
    final goals = context.watch<GoalsViewModel>().goals;
    final hasCalorieGoal = goals.containsKey('calories');
    final hasProteinGoal = goals.containsKey('protein');
    if (!hasCalorieGoal && !hasProteinGoal) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (hasCalorieGoal)
            Expanded(child: GoalsSquareCard(goalKey: 'calories')),
          if (hasCalorieGoal && hasProteinGoal) const SizedBox(width: 12),
          if (hasProteinGoal)
            Expanded(child: GoalsSquareCard(goalKey: 'protein')),
        ],
      ),
    );
  }
}
