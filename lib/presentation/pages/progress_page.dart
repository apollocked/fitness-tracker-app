import 'package:fit_tracker/logic/progress_viewmodel.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppBarr(
          'Progress', primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: measurements.isEmpty
          ? _EmptyState(onAdd: _addMeasurement)
          : _MeasurementList(measurements: measurements),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1), shape: BoxShape.circle),
            child:
                Icon(Icons.show_chart_rounded, size: 64, color: primaryColor),
          ),
          const SizedBox(height: 24),
          Text('No Measurements Yet',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colors.textColor)),
          const SizedBox(height: 8),
          Text('Start logging your weight to track your progress over time.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.subtitleColor)),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: const Text('Log First Measurement'),
          ),
        ]),
      ),
    );
  }
}

class _MeasurementList extends StatelessWidget {
  const _MeasurementList({required this.measurements});
  final List measurements;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      physics: const BouncingScrollPhysics(),
      itemCount: measurements.length,
      itemBuilder: (context, index) {
        final m = measurements[measurements.length - 1 - index];
        final reversedIndex = measurements.length - 1 - index;
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
              icon: const Icon(Icons.delete_outline_rounded,
                  color: Colors.red, size: 20),
              onPressed: () => context
                  .read<ProgressViewModel>()
                  .deleteMeasurement(reversedIndex),
            ),
          ]),
        );
      },
    );
  }
}
