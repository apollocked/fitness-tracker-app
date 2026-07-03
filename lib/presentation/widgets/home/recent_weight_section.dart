import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/progress_viewmodel.dart';
import 'package:fit_tracker/presentation/widgets/home/weight_row.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

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
            ...recent.take(3).map((m) => WeightRow(
                  measurement: m as dynamic,
                  colors: colors,
                )),
        ],
      ),
    );
  }
}
