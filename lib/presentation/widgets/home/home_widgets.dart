import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/logic/progress_viewmodel.dart';
import 'package:fit_tracker/logic/calculators_viewmodel.dart';
import 'package:fit_tracker/data/model/user_model.dart';
import 'package:fit_tracker/data/model/measurement_model.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GreetingBanner extends StatelessWidget {
  const GreetingBanner({super.key, this.username});
  final String? username;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(isDark ? 0.25 : 0.15),
            primaryColor.withOpacity(isDark ? 0.08 : 0.04)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor.withOpacity(isDark ? 0.3 : 0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text.rich(TextSpan(
                text: '${l10n.greetingGeneric}, ',
                style: TextStyle(fontSize: 16, color: colors.subtitleColor),
                children: [
                  TextSpan(
                    text: '${username ?? 'Athlete'}!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colors.textColor,
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 4),
              Text('Your fitness journey at a glance',
                  style: TextStyle(fontSize: 13, color: colors.subtitleColor)),
            ]),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.15), shape: BoxShape.circle),
            child: Icon(Icons.fitness_center, color: primaryColor, size: 24),
          ),
        ],
      ),
    );
  }
}

class StatsSummaryCard extends StatelessWidget {
  final UserModel user;
  final double? latestWeight;

  const StatsSummaryCard({
    super.key,
    required this.user,
    this.latestWeight,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final calculator = context.read<CalculatorsViewModel>();
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final weight = latestWeight ?? user.weight;
    final bmi = weight > 0 && user.height > 0
        ? calculator.calculateBMI(weight, user.height)
        : 0.0;
    final category = bmi > 0 ? calculator.getBMICategory(bmi) : null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: colors.shadowColor,
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.speed_rounded, size: 18, color: primaryColor),
              const SizedBox(width: 6),
              Text(l10n.homeMyStats,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.textColor)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _StatTile(
                icon: Icons.monitor_weight_outlined,
                value: l10n.progressWeightValue(weight.toStringAsFixed(1)),
                label: l10n.homeWeight,
                color: primaryColor,
              ),
              if (user.height > 0) ...[
                _StatTile(
                  icon: Icons.height_outlined,
                  value:
                      '${user.height.toStringAsFixed(0)} ${l10n.bodyStatsUnitCm}',
                  label: l10n.bodyStatsHeight,
                  color: blueColor,
                ),
              ],
              if (category != null)
                _StatTile(
                  icon: bmi < 25 && bmi >= 18.5
                      ? Icons.check_circle_outline
                      : Icons.info_outline_rounded,
                  value: bmi.toStringAsFixed(1),
                  label: category,
                  color: bmi < 25 && bmi >= 18.5 ? greenColor : orangeColor,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatTile({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colors.textColor)),
          Text(label,
              style: TextStyle(fontSize: 11, color: colors.subtitleColor)),
        ],
      ),
    );
  }
}

class DashboardGoalsSection extends StatelessWidget {
  final VoidCallback? onViewAll;

  const DashboardGoalsSection({super.key, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final goalsVM = context.watch<GoalsViewModel>();
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final goals = goalsVM.goals;

    if (goals.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: primaryColor.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
                color: colors.shadowColor,
                blurRadius: 12,
                offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.flag_outlined,
                  size: 24, color: primaryColor.withOpacity(0.5)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.homeNoGoalsSet,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: colors.textColor)),
                  const SizedBox(height: 2),
                  Text('Set fitness goals to track your progress',
                      style:
                          TextStyle(fontSize: 12, color: colors.subtitleColor)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 36,
              child: ElevatedButton.icon(
                onPressed: onViewAll,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Set Goal',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final activeGoalKeys = goals.entries
        .where((e) => e.value['active'] == true)
        .map((e) => e.key)
        .toList();
    final displayKeys = activeGoalKeys.isNotEmpty
        ? activeGoalKeys
        : goals.keys.take(2).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: colors.shadowColor,
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flag_rounded, size: 18, color: primaryColor),
              const SizedBox(width: 6),
              Text(l10n.homeYourGoals,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.textColor)),
              const Spacer(),
              GestureDetector(
                onTap: onViewAll,
                child: Text('View All',
                    style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...displayKeys.map((k) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _GoalProgressTile(goalKey: k, goal: goals[k]!),
              )),
        ],
      ),
    );
  }
}

class _GoalProgressTile extends StatelessWidget {
  final String goalKey;
  final dynamic goal;

  const _GoalProgressTile({required this.goalKey, required this.goal});

  @override
  Widget build(BuildContext context) {
    final goalsVM = context.watch<GoalsViewModel>();
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final progress = goalsVM.getProgress(goalKey);
    final status = goalsVM.getGoalStatus(goalKey);
    final icon = GoalsViewModel.getGoalIcon(goalKey);
    final progressColor = goalsVM.getProgressColor(goalKey);
    final active = goal['active'] == true;

    if (!active) return const SizedBox();

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: progressColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: progressColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(goalKey[0].toUpperCase() + goalKey.substring(1),
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: colors.textColor)),
                  Text(status,
                      style:
                          TextStyle(fontSize: 11, color: colors.subtitleColor)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: isDark
                      ? Colors.white.withOpacity(0.08)
                      : Colors.black.withOpacity(0.06),
                  color: progressColor,
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RecentWeightSection extends StatelessWidget {
  final VoidCallback? onAdd;

  const RecentWeightSection({super.key, this.onAdd});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final measurements = context.watch<ProgressViewModel>().measurements;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    final recent = measurements.length >= 3
        ? measurements.sublist(measurements.length - 3).reversed.toList()
        : measurements.reversed.toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: colors.shadowColor,
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up_rounded, size: 18, color: primaryColor),
              const SizedBox(width: 6),
              Text(l10n.homeRecentWeight,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.textColor)),
              const Spacer(),
              if (onAdd != null)
                GestureDetector(
                  onTap: onAdd,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 14, color: primaryColor),
                        const SizedBox(width: 4),
                        Text(l10n.homeWeight,
                            style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          if (recent.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.scale_outlined,
                        size: 36, color: colors.subtitleColor.withOpacity(0.4)),
                    const SizedBox(height: 8),
                    Text(l10n.homeNoMeasurementsYet,
                        style: TextStyle(
                            fontSize: 13, color: colors.subtitleColor)),
                    const SizedBox(height: 4),
                    Text(l10n.progressLogFirstWeight,
                        style: TextStyle(
                            fontSize: 12,
                            color: colors.subtitleColor.withOpacity(0.7))),
                  ],
                ),
              ),
            )
          else
            ...recent.take(3).map((m) => _weightRow(m, colors, l10n)),
        ],
      ),
    );
  }

  Widget _weightRow(
      Measurement m, AppColorsExtension colors, AppLocalizations l10n) {
    final dateStr = '${m.date.day}/${m.date.month}/${m.date.year}';
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(dateStr.split('/')[0],
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: primaryColor)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(dateStr,
                style: TextStyle(fontSize: 13, color: colors.subtitleColor)),
          ),
          Text(l10n.progressWeightValue(m.weight.toStringAsFixed(1)),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: colors.textColor)),
        ],
      ),
    );
  }
}

class QuickActionRow extends StatelessWidget {
  final VoidCallback? onCalculators;
  final VoidCallback? onGoals;
  final VoidCallback? onProgress;

  const QuickActionRow({
    super.key,
    this.onCalculators,
    this.onGoals,
    this.onProgress,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
            child: _ActionChip(
          icon: Icons.calculate_outlined,
          label: l10n.homeCalculators,
          color: primaryColor,
          isDark: isDark,
          onTap: onCalculators,
        )),
        const SizedBox(width: 10),
        Expanded(
            child: _ActionChip(
          icon: Icons.flag_outlined,
          label: l10n.homeYourGoals,
          color: greenColor,
          isDark: isDark,
          onTap: onGoals,
        )),
        const SizedBox(width: 10),
        Expanded(
            child: _ActionChip(
          icon: Icons.show_chart_rounded,
          label: l10n.navProgress,
          color: blueColor,
          isDark: isDark,
          onTap: onProgress,
        )),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isDark;
  final VoidCallback? onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(isDark ? 0.12 : 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(isDark ? 0.25 : 0.15)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colors.textColor)),
          ],
        ),
      ),
    );
  }
}
