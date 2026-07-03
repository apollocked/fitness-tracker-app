import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/logic/progress_viewmodel.dart';
import 'package:fit_tracker/logic/calculators_viewmodel.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/presentation/widgets/progress/weight_chart.dart';
import 'package:fit_tracker/presentation/widgets/progress/goal_progress_banner.dart';
import 'package:fit_tracker/presentation/widgets/progress/stats_row.dart';
import 'package:fit_tracker/presentation/widgets/progress/month_selector.dart';
import 'package:fit_tracker/data/model/measurement_model.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class MeasurementList extends StatefulWidget {
  final List measurements;
  final GoalsViewModel goalsVM;
  final AppColorsExtension colors;

  const MeasurementList({
    super.key,
    required this.measurements,
    required this.goalsVM,
    required this.colors,
  });

  @override
  State<MeasurementList> createState() => _MeasurementListState();
}

class _MeasurementListState extends State<MeasurementList> {
  late DateTime _selectedMonth;

  @override
  void initState() {
    super.initState();
    _selectedMonth = _latestMonth();
  }

  @override
  void didUpdateWidget(MeasurementList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.measurements != widget.measurements) {
      final months = _availableMonths();
      if (!months.contains(_selectedMonth) && months.isNotEmpty) {
        _selectedMonth = months.last;
      }
    }
  }

  DateTime _latestMonth() {
    if (widget.measurements.isEmpty) return DateTime.now();
    final latest = widget.measurements
        .cast<Measurement>()
        .map((m) => m.date)
        .reduce((a, b) => a.isAfter(b) ? a : b);
    return DateTime(latest.year, latest.month);
  }

  List<DateTime> _availableMonths() {
    final months = <DateTime>{};
    for (final m in widget.measurements.cast<Measurement>()) {
      months.add(DateTime(m.date.year, m.date.month));
    }
    final sorted = months.toList()..sort();
    return sorted;
  }

  List<Measurement> _chartMeasurements() {
    final filtered = widget.measurements
        .cast<Measurement>()
        .where((m) =>
            m.date.year == _selectedMonth.year &&
            m.date.month == _selectedMonth.month)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    if (filtered.length > 10) {
      return filtered.sublist(filtered.length - 10);
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final calculator = context.read<CalculatorsViewModel>();
    final user = context.read<AuthViewModel>().currentUser;
    final first = widget.measurements.isNotEmpty ? widget.measurements.first as dynamic : null;
    final last = widget.measurements.isNotEmpty ? widget.measurements.last as dynamic : null;
    final weightChange = first != null && last != null
        ? (first.weight - last.weight).toStringAsFixed(1)
        : null;
    final bmi = user != null && user.height > 0 && last != null
        ? calculator.calculateBMI(last.weight, user.height)
        : null;
    final months = _availableMonths();
    final monthIdx = months.indexOf(_selectedMonth);
    final chartMeasurements = _chartMeasurements();
    final monthMeasurements = widget.measurements
        .cast<Measurement>()
        .where((m) =>
            m.date.year == _selectedMonth.year &&
            m.date.month == _selectedMonth.month)
        .toList();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
            child: GoalProgressBanner(goalsVM: widget.goalsVM, colors: widget.colors)),
        if (weightChange != null)
          SliverToBoxAdapter(
            child: StatsRow(
              colors: widget.colors,
              latestWeight: last.weight.toDouble(),
              bmi: bmi,
              weightChange: weightChange,
            ),
          ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              if (months.length > 1)
                MonthSelector(
                  currentMonth: _selectedMonth,
                  canGoBack: monthIdx > 0,
                  canGoForward: monthIdx < months.length - 1,
                  onPrevious: () => setState(() => _selectedMonth = months[monthIdx - 1]),
                  onNext: () => setState(() => _selectedMonth = months[monthIdx + 1]),
                ),
              WeightChart(
                measurements: chartMeasurements,
                colors: widget.colors,
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final m = monthMeasurements[monthMeasurements.length - 1 - index];
                return MeasurementItem(
                  measurement: m,
                  colors: widget.colors,
                );
              },
              childCount: monthMeasurements.length,
            ),
          ),
        ),
      ],
    );
  }
}

class MeasurementItem extends StatelessWidget {
  final Measurement measurement;
  final AppColorsExtension colors;

  const MeasurementItem({
    super.key,
    required this.measurement,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final m = measurement;
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: colors.shadowColor,
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(children: [
        Container(
            width: 5,
            height: 72,
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(16)))),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      DateFormat.yMMMEd().format(m.date),
                      style: TextStyle(
                          fontSize: 13, color: colors.subtitleColor)),
                  const SizedBox(height: 4),
                  Text(
                      l10n.progressWeightValue(m.weight.toString()),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colors.textColor)),
                ]),
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete_outline_rounded,
              color: redColor, size: 20),
          onPressed: () {
            final all = context.read<ProgressViewModel>().measurements;
            final idx = all.indexOf(m);
            if (idx >= 0) {
              context.read<ProgressViewModel>().deleteMeasurement(idx);
            }
          },
        ),
      ]),
    );
  }
}
