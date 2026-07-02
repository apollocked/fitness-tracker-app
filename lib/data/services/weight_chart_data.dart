import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/painting.dart';
import 'package:fit_tracker/data/model/measurement_model.dart';

class WeightChartData {
  final List<FlSpot> spots;
  final double yMin;
  final double yMax;
  final double yInterval;
  final double xInterval;
  final int count;

  WeightChartData({
    required this.spots,
    required this.yMin,
    required this.yMax,
    required this.yInterval,
    required this.xInterval,
    required this.count,
  });

  static WeightChartData fromMeasurements(List<Measurement> measurements) {
    final sorted = List<Measurement>.from(measurements)
      ..sort((a, b) => a.date.compareTo(b.date));

    final spots = sorted.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.weight);
    }).toList();

    final weights = sorted.map((m) => m.weight).toList();
    final minY = weights.reduce((a, b) => a < b ? a : b);
    final maxY = weights.reduce((a, b) => a > b ? a : b);
    final yPadding = ((maxY - minY) * 0.2).clamp(1.0, double.infinity);
    final yMin = (minY - yPadding).floorToDouble();
    final yMax = (maxY + yPadding).ceilToDouble();

    return WeightChartData(
      spots: spots,
      yMin: yMin,
      yMax: yMax,
      yInterval: _niceInterval(minY, maxY),
      xInterval: _xInterval(sorted.length),
      count: sorted.length,
    );
  }

  static Color dotColor(List<Measurement> sorted, int index) {
    if (index == 0) return const Color(0xFFD4AF37);
    final prev = sorted[index - 1].weight;
    final curr = sorted[index].weight;
    if (curr < prev) return const Color(0xFF4CAF50);
    if (curr > prev) return const Color(0xFFFF7043);
    return const Color(0xFFD4AF37);
  }

  static double _niceInterval(double min, double max) {
    final range = max - min;
    if (range <= 2) return 0.5;
    if (range <= 5) return 1;
    if (range <= 10) return 2;
    if (range <= 20) return 5;
    return (range / 4).roundToDouble();
  }

  static double _xInterval(int count) {
    if (count <= 5) return 1;
    if (count <= 10) return 2;
    if (count <= 20) return 3;
    return (count / 5).ceilToDouble();
  }
}
