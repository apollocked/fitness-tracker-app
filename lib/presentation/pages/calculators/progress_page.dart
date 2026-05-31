import 'package:fit_tracker/logic/porviders/progress_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_elevated_button.dart';
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
    context.read<ProgressViewModel>().loadMeasurements();
  }

  void _navigateToAddMeasurement() async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddMeasurementPage()));
    if (result == true && context.mounted) {
      context.read<ProgressViewModel>().loadMeasurements();
    }
  }

  Widget _buildEmptyState() {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.show_chart, size: 80, color: primaryColor),
          const SizedBox(height: 16),
          Text('No measurements yet',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: colors.textColor)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
                'Add your weight measurements to track your progress over time.',
                style: TextStyle(color: colors.subtitleColor)),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _navigateToAddMeasurement,
            icon: const Icon(Icons.add),
            label: const Text('Add weight measurement'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              iconColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementsList(List measurements) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: measurements.length,
      itemBuilder: (context, index) {
        final m = measurements[measurements.length - 1 - index];
        return Card(
          color: colors.cardColor,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 280,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('EEEE, d/M/y, h:m:s a').format(m.date),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: colors.textColor),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => context
                          .read<ProgressViewModel>()
                          .deleteMeasurement(index),
                    ),
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Weight:',
                          style:
                              TextStyle(fontSize: 14, color: colors.textColor)),
                      Text('${m.weight} kg',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final measurements = context.watch<ProgressViewModel>().measurements;
    return Scaffold(
      appBar: customAppBarr(
          'Progress', primaryColor, Theme.of(context).scaffoldBackgroundColor),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: measurements.isEmpty
          ? _buildEmptyState()
          : _buildMeasurementsList(measurements),
      floatingActionButton: measurements.isNotEmpty
          ? CustomElevatedButton(
              onpressed: _navigateToAddMeasurement,
              text: 'Add Measurement',
              color: primaryColor)
          : null,
    );
  }
}
