import 'package:flutter/material.dart';
import 'package:fit_tracker/data/model/measurement_model.dart';
import 'package:fit_tracker/data/services/weight_chart_data.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';
import 'chart_header.dart';
import 'chart_body.dart';

class WeightChart extends StatelessWidget {
  final List<Measurement> measurements;
  final AppColorsExtension colors;

  const WeightChart({
    super.key,
    required this.measurements,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sorted = List<Measurement>.from(measurements)
      ..sort((a, b) => a.date.compareTo(b.date));
    final l10n = AppLocalizations.of(context)!;

    if (sorted.length < 2) {
      return _card(
          colors,
          Center(
            child: Text(l10n.weightChartNeedMore,
                style: TextStyle(color: colors.subtitleColor)),
          ));
    }

    final cd = WeightChartData.fromMeasurements(sorted);

    return _card(
        colors,
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ChartHeader(l10n: l10n, colors: colors),
          ChartBody(
            sorted: sorted,
            colors: colors,
            isDark: isDark,
            cd: cd,
            l10n: l10n,
          ),
        ]));
  }

  Widget _card(AppColorsExtension c, Widget child) => Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
        decoration: BoxDecoration(
            color: c.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: c.shadowColor,
                  blurRadius: 10,
                  offset: const Offset(0, 3))
            ]),
        child: child,
      );
}
