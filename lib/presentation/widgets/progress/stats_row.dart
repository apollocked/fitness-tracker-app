import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/progress/mini_stat.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class StatsRow extends StatelessWidget {
  final AppColorsExtension colors;
  final double latestWeight;
  final double? bmi;
  final String weightChange;

  const StatsRow({
    super.key,
    required this.colors,
    required this.latestWeight,
    this.bmi,
    required this.weightChange,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: colors.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MiniStat(
            colors: colors,
            icon: Icons.monitor_weight_outlined,
            value: '${latestWeight.toStringAsFixed(1)} ${l10n.progressKg}',
            label: l10n.progressCurrent,
            color: primaryColor,
          ),
          if (bmi != null)
            MiniStat(
              colors: colors,
              icon: Icons.calculate_outlined,
              value: bmi!.toStringAsFixed(1),
              label: l10n.progressBmi,
              color: blueColor,
            ),
          MiniStat(
            colors: colors,
            icon: double.parse(weightChange) <= 0
                ? Icons.trending_down_rounded
                : Icons.trending_up_rounded,
            value: '$weightChange ${l10n.progressKg}',
            label: l10n.progressWeightChange,
            color: double.parse(weightChange) <= 0
                ? greenColor
                : orangeColor,
          ),
        ],
      ),
    );
  }
}
