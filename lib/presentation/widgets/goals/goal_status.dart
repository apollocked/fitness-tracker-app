import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GoalsStats extends StatelessWidget {
  const GoalsStats({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final cubit = context.watch<GoalsViewModel>();
    final activeGoals =
        cubit.goals.values.where((g) => g['active'] == true).length;
    final completedGoals = cubit.completedCount;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: colors.cardDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
              colors, l10n.goalsTotal, cubit.goals.length.toString(), Icons.list),
          _buildStatItem(colors, l10n.goalsActive, activeGoals.toString(), Icons.flag),
          _buildStatItem(colors, l10n.goalsCompleted, completedGoals.toString(),
              Icons.check_circle),
        ],
      ),
    );
  }

  Widget _buildStatItem(
      AppColorsExtension colors, String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icon, color: primaryColor),
        ),
        const SizedBox(height: 8),
        Text(value,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.textColor)),
        Text(title,
            style: TextStyle(fontSize: 12, color: colors.subtitleColor)),
      ],
    );
  }
}
