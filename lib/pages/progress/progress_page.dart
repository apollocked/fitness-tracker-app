import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/custom_elevated_button.dart';
import 'package:myapp/models/measurement_model.dart';
import 'package:myapp/pages/Calculators/add_measurement_page.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr('Progress', primaryColor, getBackgroundColor()),
      backgroundColor: getBackgroundColor(),
      body:
          measurements.isEmpty ? _buildEmptyState() : _buildMeasurementsList(),
      floatingActionButton: measurements.isNotEmpty
          ? CustomElevatedButton(
              onpressed: _navigateToAddMeasurement,
              text: 'Add Measurement',
              color: blueColor,
            )
          : null,
    );
  }

  void _navigateToAddMeasurement() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddMeasurementPage()),
    );
    if (result == true) {
      setState(() {});
    }
  }

  Widget _buildEmptyState() {
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
                  color: getTextColor())),
          const SizedBox(height: 8),
          Text('Add your first measurement to see progress',
              style: TextStyle(color: getSubtitleColor())),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _navigateToAddMeasurement,
            icon: const Icon(Icons.add),
            label: const Text('Add Measurement'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              iconColor: getBackgroundColor(),
              foregroundColor: getBackgroundColor(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: measurements.length,
      itemBuilder: (context, index) {
        final m = measurements[measurements.length - 1 - index];
        return Card(
          color: getCardColor(),
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${m.date.day}/${m.date.month}/${m.date.year}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: getTextColor()),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteMeasurement(index),
                    ),
                  ],
                ),
                const Divider(),
                if (m.weight != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Weight:',
                            style:
                                TextStyle(fontSize: 14, color: getTextColor())),
                        Text('${m.weight} kg',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ],
                    ),
                  ),
                if (m.waist != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Waist:',
                          style:
                              TextStyle(fontSize: 14, color: getTextColor())),
                      Text('${m.waist} cm',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteMeasurement(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: getCardColor(),
        title: Text('Delete Measurement?',
            style: TextStyle(color: getTextColor())),
        content: Text('Are you sure you want to delete this measurement?',
            style: TextStyle(color: getTextColor())),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(
                  () => measurements.removeAt(measurements.length - 1 - index));
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
