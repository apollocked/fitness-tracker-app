import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fit_tracker/data/model/measurement_model.dart';
import 'package:fit_tracker/data/services/weight_chart_data.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:fit_tracker/core/l10n/app_localizations.dart';

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
          _header(l10n),
          SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  minY: cd.yMin,
                  maxY: cd.yMax,
                  gridData: _grid(isDark, cd.yInterval),
                  titlesData: _titles(cd, sorted, colors),
                  borderData: FlBorderData(show: false),
                  lineTouchData: _touch(sorted, l10n),
                  lineBarsData: [
                    LineChartBarData(
                      spots: cd.spots,
                      isCurved: true,
                      curveSmoothness: 0.2,
                      color: primaryColor,
                      barWidth: 2.5,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                          show: true,
                          getDotPainter: (s, p, b, i) => FlDotCirclePainter(
                              radius: 4,
                              color: WeightChartData.dotColor(sorted, i),
                              strokeWidth: 0)),
                      belowBarData: BarAreaData(
                          show: true, color: primaryColor.withOpacity(0.08)),
                    ),
                  ],
                ),
                duration: const Duration(milliseconds: 300),
              )),
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

  Widget _header(AppLocalizations l10n) => Padding(
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

  FlGridData _grid(bool d, double yi) => FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: yi,
      getDrawingHorizontalLine: (v) => FlLine(
          color: d
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.06),
          strokeWidth: 1));

  FlTitlesData _titles(
      WeightChartData cd, List<Measurement> s, AppColorsExtension c) {
    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: cd.xInterval,
              getTitlesWidget: (v, m) {
                final i = v.toInt();
                if (i < 0 || i >= s.length) return const SizedBox();
                return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(DateFormat('d/M').format(s[i].date),
                        style:
                            TextStyle(fontSize: 10, color: c.subtitleColor)));
              })),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: cd.yInterval,
              getTitlesWidget: (v, m) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Text('${v.toInt()}',
                      style:
                          TextStyle(fontSize: 10, color: c.subtitleColor))))),
    );
  }

  LineTouchData _touch(List<Measurement> s, AppLocalizations l10n) =>
      LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (t) => t.map((spot) {
                    final i = spot.spotIndex;
                    final d = i < s.length
                        ? DateFormat('d MMM').format(s[i].date)
                        : '';
                    return LineTooltipItem(
                        '$d\n${spot.y.toStringAsFixed(1)} ${l10n.weightChartKgLabel}',
                        const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12));
                  }).toList()));
}
