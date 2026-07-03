import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class ChartHeader extends StatelessWidget {
  const ChartHeader({
    super.key,
    required this.l10n,
    required this.colors,
  });

  final AppLocalizations l10n;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Row(children: [
        Icon(Icons.timeline_rounded, size: 18, color: primaryColor),
        const SizedBox(width: 6),
        Text(l10n.weightChartTitle,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: colors.textColor)),
      ]),
    );
  }
}
