import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/goals/goals_square_card.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';

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
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (hasCalorieGoal)
              const Expanded(child: GoalsSquareCard(goalKey: 'calories')),
            if (hasCalorieGoal && hasProteinGoal) const SizedBox(width: 14),
            if (hasProteinGoal)
              const Expanded(child: GoalsSquareCard(goalKey: 'protein')),
          ],
        ),
      ),
    );
  }
}
