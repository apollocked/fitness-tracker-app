import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fit_tracker/data/model/measurement_model.dart';
import 'package:fit_tracker/data/services/weight_chart_data.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class ChartBody extends StatelessWidget {
  final List<Measurement> sorted;
  final AppColorsExtension colors;
  final bool isDark;
  final WeightChartData cd;
  final AppLocalizations l10n;

  const ChartBody({super.key, required this.sorted, required this.colors, required this.isDark, required this.cd, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 200, child: LineChart(
      LineChartData(
        minY: cd.yMin, maxY: cd.yMax,
        gridData: _grid(isDark, cd.yInterval),
        titlesData: _titles(cd, sorted, colors),
        borderData: FlBorderData(show: false),
        lineTouchData: _touch(sorted, l10n),
        lineBarsData: [
          LineChartBarData(
            spots: cd.spots, isCurved: true, curveSmoothness: 0.2,
            color: primaryColor, barWidth: 2.5, isStrokeCapRound: true,
            dotData: FlDotData(show: true, getDotPainter: (s, p, b, i) => FlDotCirclePainter(radius: 4, color: WeightChartData.dotColor(sorted, i), strokeWidth: 0)),
            belowBarData: BarAreaData(show: true, color: primaryColor.withOpacity(0.08)),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 300),
    ));
  }

  FlGridData _grid(bool d, double yi) => FlGridData(show: true, drawVerticalLine: false, horizontalInterval: yi,
      getDrawingHorizontalLine: (v) => FlLine(
          color: d ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.06), strokeWidth: 1));

  FlTitlesData _titles(WeightChartData cd, List<Measurement> s, AppColorsExtension c) {
    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 28, interval: cd.xInterval,
          getTitlesWidget: (v, m) {
            final i = v.toInt();
            if (i < 0 || i >= s.length) return const SizedBox();
            return Padding(padding: const EdgeInsets.only(top: 6),
                child: Text(DateFormat('d/M').format(s[i].date), style: TextStyle(fontSize: 10, color: c.subtitleColor)));
          })),
      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40, interval: cd.yInterval,
          getTitlesWidget: (v, m) => Padding(padding: const EdgeInsets.only(right: 4),
              child: Text('${v.toInt()}', style: TextStyle(fontSize: 10, color: c.subtitleColor))))),
    );
  }

  LineTouchData _touch(List<Measurement> s, AppLocalizations l10n) => LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(getTooltipItems: (t) => t.map((spot) {
            final i = spot.spotIndex;
            final d = i < s.length ? DateFormat.MMMd().format(s[i].date) : '';
            return LineTooltipItem('$d\n${spot.y.toStringAsFixed(1)} ${l10n.weightChartKgLabel}',
                const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12));
          }).toList()));
}
