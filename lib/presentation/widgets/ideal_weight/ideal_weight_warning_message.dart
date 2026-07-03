import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class IdealWeightWarningMessage extends StatelessWidget {
  const IdealWeightWarningMessage({
    super.key,
    required this.isOverweight,
    required this.weightDifference,
    required this.isDark,
    required this.l10n,
    required this.colors,
  });

  final bool isOverweight;
  final double weightDifference;
  final bool isDark;
  final AppLocalizations l10n;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isOverweight
            ? redColor.withOpacity(isDark ? 0.3 : 0.08)
            : greenColor.withOpacity(isDark ? 0.3 : 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isOverweight
                ? Icons.warning_rounded
                : Icons.check_circle_rounded,
            size: 16,
            color: isOverweight
                ? redColor
                : greenColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              isOverweight
                  ? l10n.idealWeightNeedToLose(weightDifference.toStringAsFixed(1))
                  : l10n.idealWeightNeedToGain(weightDifference.toStringAsFixed(1)),
              style: TextStyle(
                  fontSize: 12,
                  color: isOverweight
                      ? redColor
                      : greenColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
