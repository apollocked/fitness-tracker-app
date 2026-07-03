import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/goals/goal_status.dart';
import 'package:fit_tracker/presentation/widgets/goals/goals_list.dart';
import 'package:fit_tracker/presentation/widgets/goals/goals_square_row.dart';
import 'package:fit_tracker/presentation/widgets/goals/calc_option.dart';
import 'package:fit_tracker/presentation/widgets/goals/calc_prompt_card.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

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
            Expanded(child: _goalsContent(goalsVM, colors)),
          ],
          if (!hasWeightGoal)
            Expanded(child: _emptyState(colors, hasAnyGoal)),
        ],
      ),
    );
  }

  Widget _goalsContent(GoalsViewModel goalsVM, AppColorsExtension colors) {
    return Column(
      children: [
        const Expanded(child: GoalsList()),
        if (!goalsVM.goals.containsKey('calories') ||
            !goalsVM.goals.containsKey('protein'))
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: CalcPromptCard(),
          ),
      ],
    );
  }

  Widget _emptyState(AppColorsExtension colors, bool hasOtherGoals) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(hasOtherGoals ? Icons.flag_outlined : Icons.flag_rounded,
                size: 64, color: primaryColor.withOpacity(0.4)),
            const SizedBox(height: 20),
            GoalsEmptyText(colors: colors, hasOtherGoals: hasOtherGoals),
            if (!hasOtherGoals) ...[
              const SizedBox(height: 24),
              GoalsCalcOptions(),
            ] else ...[
              const SizedBox(height: 24),
              GoalsWeightOption(),
            ],
          ],
        ),
      ),
    );
  }
}

class GoalsEmptyText extends StatelessWidget {
  final AppColorsExtension colors;
  final bool hasOtherGoals;
  const GoalsEmptyText({super.key, required this.colors, required this.hasOtherGoals});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
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
      ],
    );
  }
}

class GoalsCalcOptions extends StatelessWidget {
  const GoalsCalcOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        CalcOption(
          icon: Icons.monitor_weight_outlined,
          label: l10n.homeIdealBodyWeight,
          color: blueColor,
          isDark: isDark,
          onTap: () => Navigator.pushNamed(context, '/ideal-weight'),
        ),
        const SizedBox(height: 10),
        CalcOption(
          icon: Icons.local_fire_department_outlined,
          label: l10n.goalsDailyCalories,
          color: redColor,
          isDark: isDark,
          onTap: () => Navigator.pushNamed(context, '/daily-calories'),
        ),
        const SizedBox(height: 10),
        CalcOption(
          icon: Icons.restaurant_outlined,
          label: l10n.goalsDailyProtein,
          color: orangeColor,
          isDark: isDark,
          onTap: () => Navigator.pushNamed(context, '/protein-intake'),
        ),
      ],
    );
  }
}

class GoalsWeightOption extends StatelessWidget {
  const GoalsWeightOption({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    return CalcOption(
      icon: Icons.monitor_weight_outlined,
      label: l10n.goalsWeightTarget,
      color: blueColor,
      isDark: isDark,
      onTap: () => Navigator.pushNamed(context, '/ideal-weight'),
    );
  }
}
