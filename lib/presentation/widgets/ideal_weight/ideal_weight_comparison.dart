import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class IdealWeightComparison extends StatelessWidget {
  const IdealWeightComparison({
    super.key,
    required this.currentWeight,
    required this.weightDifference,
    required this.isOverweight,
    required this.isDark,
    required this.l10n,
    required this.colors,
  });

  final double currentWeight;
  final double weightDifference;
  final bool isOverweight;
  final bool isDark;
  final AppLocalizations l10n;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: colors.cardColor.withOpacity(isDark ? 0.8 : 0.5),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(l10n.idealWeightCurrentWeight,
                  style: TextStyle(
                      fontSize: 12, color: colors.subtitleColor)),
              const SizedBox(height: 8),
              Text('${currentWeight.toStringAsFixed(1)} ${l10n.bodyStatsKg}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors.textColor)),
            ],
          ),
          Container(
              width: 2,
              height: 60,
              color: colors.subtitleColor.withOpacity(0.3)),
          Column(
            children: [
              Text(isOverweight ? l10n.idealWeightToLose : l10n.idealWeightToGain,
                  style: TextStyle(
                      fontSize: 12,
                      color: isOverweight
                          ? redColor
                          : greenColor)),
              const SizedBox(height: 8),
              Text('${weightDifference.toStringAsFixed(1)} ${l10n.bodyStatsKg}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isOverweight ? redColor : greenColor,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
