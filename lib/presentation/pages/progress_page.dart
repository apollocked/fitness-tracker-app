import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/logic/progress_viewmodel.dart';
import 'package:fit_tracker/logic/calculators_viewmodel.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/pages/calculators/add_measurement_page.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});
  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ProgressViewModel>().loadMeasurements();
    });
  }

  Future<void> _addMeasurement() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const AddMeasurementPage()));
    if (result == true && context.mounted) {
      context.read<ProgressViewModel>().loadMeasurements();
    }
  }

  @override
  Widget build(BuildContext context) {
    final measurements = context.watch<ProgressViewModel>().measurements;
    final goalsVM = context.watch<GoalsViewModel>();
    final theme = Theme.of(context);
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      appBar: customAppBarr(
          'Progress', primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: measurements.isEmpty
          ? _EmptyState(onAdd: _addMeasurement)
          : _MeasurementList(
              measurements: measurements,
              goalsVM: goalsVM,
              colors: colors,
            ),
      floatingActionButton: measurements.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _addMeasurement,
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('Add Measurement',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            )
          : null,
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final goalsVM = context.watch<GoalsViewModel>();
    final hasGoals = goalsVM.goals.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                  color: primaryColor.withOpacity(isDark ? 0.25 : 0.15),
                  width: 2),
            ),
            child: Icon(Icons.show_chart_rounded, size: 64, color: primaryColor),
          ),
          const SizedBox(height: 24),
          Text('No Measurements Yet',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colors.textColor)),
          const SizedBox(height: 8),
          Text(
            hasGoals
                ? 'Start logging your weight to track progress toward your goals.'
                : 'Start logging your weight to track your progress over time.',
            textAlign: TextAlign.center,
            style: TextStyle(color: colors.subtitleColor)),
          const SizedBox(height: 32),
          SizedBox(
            width: 240,
            height: 54,
            child: ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add, size: 20),
              label: const Text('Log Your First Measurement',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                shadowColor: primaryColor.withOpacity(0.4),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _GoalProgressBanner extends StatelessWidget {
  final GoalsViewModel goalsVM;
  final AppColorsExtension colors;

  const _GoalProgressBanner({required this.goalsVM, required this.colors});

  @override
  Widget build(BuildContext context) {
    final weightGoal = goalsVM.goals['weight'];
    if (weightGoal == null || weightGoal['active'] != true) return const SizedBox();

    final current = (weightGoal['current'] as num?)?.toDouble() ?? 0;
    final target = (weightGoal['target'] as num?)?.toDouble() ?? 0;
    final progress = target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            greenColor.withOpacity(isDark ? 0.2 : 0.1),
            greenColor.withOpacity(isDark ? 0.08 : 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: greenColor.withOpacity(isDark ? 0.3 : 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: greenColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.monitor_weight_outlined, color: greenColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weight Goal Progress',
                    style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600, color: colors.textColor)),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.06),
                    color: greenColor,
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Text('${current.toStringAsFixed(1)} / ${target.toStringAsFixed(1)} kg',
                    style: TextStyle(fontSize: 11, color: colors.subtitleColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MeasurementList extends StatelessWidget {
  final List measurements;
  final GoalsViewModel goalsVM;
  final AppColorsExtension colors;

  const _MeasurementList({
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

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: _GoalProgressBanner(goalsVM: goalsVM, colors: colors)),

        if (weightChange != null)
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.cardColor,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: colors.shadowColor, blurRadius: 8, offset: const Offset(0, 2))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _MiniStat(colors: colors,
                    icon: Icons.monitor_weight_outlined,
                    value: '${last.weight.toStringAsFixed(1)} kg',
                    label: 'Current',
                    color: primaryColor,
                  ),
                  if (user != null && user.height > 0)
                    _MiniStat(colors: colors,
                      icon: Icons.calculate_outlined,
                      value: calculator.calculateBMI(last.weight, user.height).toStringAsFixed(1),
                      label: 'BMI',
                      color: blueColor,
                    ),
                  _MiniStat(colors: colors,
                    icon: double.parse(weightChange) <= 0
                        ? Icons.trending_down_rounded
                        : Icons.trending_up_rounded,
                    value: '$weightChange kg',
                    label: 'Change',
                    color: double.parse(weightChange) <= 0 ? greenColor : orangeColor,
                  ),
                ],
              ),
            ),
          ),

        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final m = measurements[measurements.length - 1 - index];
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
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(16)))),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat('EEE, d MMM y').format(m.date),
                                  style: TextStyle(
                                      fontSize: 13, color: colors.subtitleColor)),
                              const SizedBox(height: 4),
                              Text('${m.weight} kg',
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
                      onPressed: () =>
                          context.read<ProgressViewModel>().deleteMeasurement(index),
                    ),
                  ]),
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

class _MiniStat extends StatelessWidget {
  final AppColorsExtension colors;
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _MiniStat({
    required this.colors,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: colors.textColor)),
        Text(label,
            style: TextStyle(fontSize: 11, color: colors.subtitleColor)),
      ],
    );
  }
}
