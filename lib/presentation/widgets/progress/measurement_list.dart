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
import 'package:fit_tracker/data/model/measurement_model.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class MeasurementList extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final calculator = context.read<CalculatorsViewModel>();
    final user = context.read<AuthViewModel>().currentUser;
    final first = measurements.isNotEmpty ? measurements.first as dynamic : null;
    final last = measurements.isNotEmpty ? measurements.last as dynamic : null;
    final weightChange = first != null && last != null
        ? (first.weight - last.weight).toStringAsFixed(1)
        : null;
    final bmi = user != null && user.height > 0 && last != null
        ? calculator.calculateBMI(last.weight, user.height)
        : null;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
            child: GoalProgressBanner(goalsVM: goalsVM, colors: colors)),
        if (weightChange != null)
          SliverToBoxAdapter(
            child: StatsRow(
              colors: colors,
              latestWeight: last.weight.toDouble(),
              bmi: bmi,
              weightChange: weightChange,
            ),
          ),
        SliverToBoxAdapter(
          child: WeightChart(
            measurements: measurements.cast<Measurement>(),
            colors: colors,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final m = measurements[measurements.length - 1 - index];
                return MeasurementItem(
                  measurement: m as Measurement,
                  index: index,
                  colors: colors,
                );
              },
              childCount: measurements.length,
            ),
          ),
        ),
      ],
    );
  }
}

class MeasurementItem extends StatelessWidget {
  final Measurement measurement;
  final int index;
  final AppColorsExtension colors;

  const MeasurementItem({
    super.key,
    required this.measurement,
    required this.index,
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
          onPressed: () => context
              .read<ProgressViewModel>()
              .deleteMeasurement(index),
        ),
      ]),
    );
  }
}
