import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/goals/goal_status.dart';
import 'package:fit_tracker/presentation/widgets/goals/goals_list.dart';
import 'package:fit_tracker/presentation/widgets/goals/goals_square_row.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/porviders/goals_viewmodel.dart';
import 'package:fit_tracker/presentation/widgets/shared/calc_widgets.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    final goalsVM = context.watch<GoalsViewModel>();
    return Scaffold(
      appBar: customAppBarr('My Goals', primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const GoalsStats(),
          const SizedBox(height: 16),
          const GoalsSquareRow(),
          const SizedBox(height: 16),
          Expanded(
            child: goalsVM.goals.containsKey('weight')
                ? const GoalsList()
                : _buildNoWeightGoalState(colors, context),
          ),
        ],
      ),
    );
  }

  Widget _buildNoWeightGoalState(AppColorsExtension colors, BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(Icons.monitor_weight_outlined, size: 64, color: primaryColor),
            ),
            const SizedBox(height: 24),
            Text('No Weight Goal Yet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colors.textColor)),
            const SizedBox(height: 10),
            Text(
              'Use the Ideal Body Weight Calculator to set your primary weight goal and start tracking progress.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: colors.subtitleColor, height: 1.4),
            ),
            const SizedBox(height: 32),
            CalcButton(
              label: 'Set Weight Goal',
              color: primaryColor,
              onPressed: () => Navigator.pushNamed(context, '/ideal-weight'),
            ),
          ],
        ),
      ),
    );
  }
}
