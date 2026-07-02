import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/goals/goal_status.dart';
import 'package:fit_tracker/presentation/widgets/goals/goals_list.dart';
import 'package:fit_tracker/presentation/widgets/goals/goals_square_row.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/core/l10n/app_localizations.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    final goalsVM = context.watch<GoalsViewModel>();
    final l10n = AppLocalizations.of(context)!;
    final hasAnyGoal = goalsVM.goals.isNotEmpty;
    final hasWeightGoal = goalsVM.goals.containsKey('weight');

    return Scaffold(
      appBar: customAppBarr(
          l10n.goalsTitle, primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const GoalsStats(),
          if (hasAnyGoal) ...[
            const SizedBox(height: 16),
            const GoalsSquareRow(),
          ],
          if (hasWeightGoal) ...[
            const SizedBox(height: 16),
            Expanded(child: _goalsContent(goalsVM, colors, context)),
          ],
          if (!hasWeightGoal)
            Expanded(child: _emptyState(colors, context, hasAnyGoal)),
        ],
      ),
    );
  }

  Widget _goalsContent(
      GoalsViewModel goalsVM, AppColorsExtension colors, BuildContext context) {
    return Column(
      children: [
        const Expanded(child: GoalsList()),
        if (!goalsVM.goals.containsKey('calories') ||
            !goalsVM.goals.containsKey('protein'))
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: _CalcPromptCard(colors: colors),
          ),
      ],
    );
  }

  Widget _emptyState(
      AppColorsExtension colors, BuildContext context, bool hasOtherGoals) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(hasOtherGoals ? Icons.flag_outlined : Icons.flag_rounded,
                size: 64, color: primaryColor.withOpacity(0.4)),
            const SizedBox(height: 20),
            Text(
              l10n.goalsNoGoalsYet,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colors.textColor),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.goalsStartCalculating,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14, color: colors.subtitleColor, height: 1.4),
            ),
            const SizedBox(height: 24),
            if (!hasOtherGoals) ...[
              _CalcOption(
                icon: Icons.monitor_weight_outlined,
                label: 'Ideal Body Weight',
                color: blueColor,
                isDark: isDark,
                onTap: () => Navigator.pushNamed(context, '/ideal-weight'),
              ),
              const SizedBox(height: 10),
              _CalcOption(
                icon: Icons.local_fire_department_outlined,
                label: l10n.goalsDailyCalories,
                color: redColor,
                isDark: isDark,
                onTap: () => Navigator.pushNamed(context, '/daily-calories'),
              ),
              const SizedBox(height: 10),
              _CalcOption(
                icon: Icons.restaurant_outlined,
                label: l10n.goalsDailyProtein,
                color: orangeColor,
                isDark: isDark,
                onTap: () => Navigator.pushNamed(context, '/protein-intake'),
              ),
            ] else
              _CalcOption(
                icon: Icons.monitor_weight_outlined,
                label: l10n.goalsWeightTarget,
                color: blueColor,
                isDark: isDark,
                onTap: () => Navigator.pushNamed(context, '/ideal-weight'),
              ),
          ],
        ),
      ),
    );
  }
}

class _CalcOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _CalcOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(isDark ? 0.12 : 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(isDark ? 0.25 : 0.15)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 12),
            Text(label,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: (isDark ? Colors.white : Colors.black87))),
            const Spacer(),
            Icon(Icons.chevron_right, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}

class _CalcPromptCard extends StatelessWidget {
  final AppColorsExtension colors;

  const _CalcPromptCard({required this.colors});

  @override
  Widget build(BuildContext context) {
    final goalsVM = context.watch<GoalsViewModel>();
    final hasCalories = goalsVM.goals.containsKey('calories');
    final hasProtein = goalsVM.goals.containsKey('protein');
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(isDark ? 0.1 : 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_fix_high_rounded, size: 20, color: primaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              !hasCalories && !hasProtein
                  ? 'Use the calculators to set calorie and protein goals.'
                  : !hasCalories
                      ? 'Set a daily calorie goal from the calculator.'
                      : 'Set a protein intake goal from the calculator.',
              style:
                  TextStyle(fontSize: 12, color: colors.textColor, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
