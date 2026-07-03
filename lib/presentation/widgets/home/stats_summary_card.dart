import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/calculators_viewmodel.dart';
import 'package:fit_tracker/data/model/user_model.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

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
    final categoryRaw = bmi > 0 ? calculator.getBMICategory(bmi) : null;
    final category = categoryRaw != null ? _bmiCategoryLabel(l10n, categoryRaw) : null;

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

String _bmiCategoryLabel(AppLocalizations l10n, String category) {
  switch (category) {
    case 'Underweight': return l10n.bmiUnderweight;
    case 'Normal': return l10n.bmiNormal;
    case 'Overweight': return l10n.bmiOverweight;
    case 'Obese': return l10n.bmiObese;
    default: return category;
  }
}
