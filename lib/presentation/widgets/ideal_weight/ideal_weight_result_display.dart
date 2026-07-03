import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class IdealWeightResultDisplay extends StatelessWidget {
  const IdealWeightResultDisplay({
    super.key,
    required this.idealWeight,
    required this.l10n,
    required this.colors,
  });

  final double idealWeight;
  final AppLocalizations l10n;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: blueColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: blueColor.withOpacity(0.3), width: 2),
      ),
      child: Column(
        children: [
          Text(l10n.idealWeightResult,
              style: TextStyle(
                  fontSize: 14, color: colors.subtitleColor)),
          const SizedBox(height: 8),
          Text('${idealWeight.toStringAsFixed(1)} ${l10n.bodyStatsKg}',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: blueColor)),
        ],
      ),
    );
  }
}
