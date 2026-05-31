import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tracker/widgets/custom_appbar.dart';
import 'package:fit_tracker/features/profile/goals/goal_status.dart';
import 'package:fit_tracker/features/profile/goals/goals_list.dart';
import 'package:fit_tracker/features/profile/goals/goals_square_row.dart';
import 'package:fit_tracker/core/theme/colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/app/cubits/goals_cubit.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final goalsState = context.watch<GoalsCubit>().state;
    return Scaffold(
      appBar: customAppBarr(
          'My Goals', primaryColor, Theme.of(context).scaffoldBackgroundColor),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          const GoalsStats(),
          const SizedBox(height: 16),
          const GoalsSquareRow(),
          const SizedBox(height: 16),
          Expanded(
            child: goalsState.goals.containsKey('weight')
                ? const GoalsList()
                : _buildNoWeightGoalState(colors, context),
          ),
        ],
      ),
    );
  }

  Widget _buildNoWeightGoalState(AppColorsExtension colors, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.monitor_weight_outlined, size: 80, color: primaryColor),
          const SizedBox(height: 16),
          Text('No Weight Goal Yet',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colors.textColor)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Use the Ideal Body Weight Calculator to set your weight goal',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: colors.subtitleColor),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/ideal-weight'),
            icon: Icon(Icons.calculate,
                color: Theme.of(context).scaffoldBackgroundColor),
            label: Text('Set Weight Goal',
                style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor)),
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
          ),
        ],
      ),
    );
  }
}


