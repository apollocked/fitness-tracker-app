import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/custom_elevated_button.dart';
import 'package:myapp/models/measurement_model.dart'; // Updated
import 'package:myapp/pages/Cards/add_measurement_page.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  List<Measurement> _measurements = [];

  @override
  void initState() {
    super.initState();
    _loadMeasurements();
  }

  void _loadMeasurements() {
    setState(() {
      _measurements = getMeasurements();
    });
  }

  void _navigateToAddMeasurement() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddMeasurementPage()),
    );
    
    if (result == true) {
      _loadMeasurements();
    }
  }

  Future<void> _deleteMeasurement(int index) async {
    await deleteMeasurement(_measurements.length - 1 - index);
    _loadMeasurements();
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
          Text('Add your weight measurements to track your progress over time.',
              style: TextStyle(color: getSubtitleColor())),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _navigateToAddMeasurement,
            icon: const Icon(Icons.add),
            label: const Text('Add weight measurement'),
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
      itemCount: _measurements.length,
      itemBuilder: (context, index) {
        final m = _measurements[_measurements.length - 1 - index];
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
                              color: getTextColor(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteMeasurement(index),
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
                              TextStyle(fontSize: 14, color: getTextColor())),
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
    return Scaffold(
      appBar: customAppBarr('Progress', primaryColor, getBackgroundColor()),
      backgroundColor: getBackgroundColor(),
      body: _measurements.isEmpty ? _buildEmptyState() : _buildMeasurementsList(),
      floatingActionButton: _measurements.isNotEmpty
          ? CustomElevatedButton(
              onpressed: _navigateToAddMeasurement,
              text: 'Add Measurement',
              color: primaryColor,
            )
          : null,
    );
  }
}