import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/custom_elevated_button.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/models/measurement_model.dart'; // Updated
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';
import 'package:myapp/utils/user_data.dart'; // Updated

class AddMeasurementPage extends StatefulWidget {
  const AddMeasurementPage({super.key});

  @override
  State<AddMeasurementPage> createState() => _AddMeasurementPageState();
}

class _AddMeasurementPageState extends State<AddMeasurementPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill with current weight if available
    if (currentUser != null && currentUser!['weight'] != null) {
      _weightController.text = currentUser!['weight'].toString();
    }
  }

  Future<void> _saveMeasurement() async {
    if (_formKey.currentState!.validate()) {
      // Check if weight field is filled
      if (_weightController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please enter your weight'),
              backgroundColor: Colors.red),
        );
        return;
      }

      setState(() => _isLoading = true);

      // Create and add measurement
      final measurement = Measurement(
        date: DateTime.now(),
        weight: double.parse(_weightController.text),
      );

      await addMeasurement(measurement);

      // Update user data and weight goal
      final newWeight = double.parse(_weightController.text);

      if (currentUser != null) {
        currentUser!['weight'] = newWeight;
        await updateUser(currentUser!['id'], currentUser!);

        // Update weight goal automatically
        _updateWeightGoal(newWeight);
      }

      setState(() {
        _isLoading = false;
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Measurement saved successfully!'),
              backgroundColor: Colors.green),
        );
        Navigator.pop(context, true);
      }
    }
  }

  Future<void> _updateWeightGoal(double newWeight) async {
    if (currentUser != null &&
        currentUser!['goals'] != null &&
        currentUser!['goals']['weight'] != null) {
      final weightGoal =
          Map<String, dynamic>.from(currentUser!['goals']['weight']);

      // Update only the current value
      weightGoal['current'] = newWeight;

      // Update user goals
      currentUser!['goals']['weight'] = weightGoal;
      await updateUser(currentUser!['id'], currentUser!);

      // Show notification about goal update
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Weight goal updated with new measurement!'),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBarr('Add Measurement', greenColor, getBackgroundColor()),
      backgroundColor: getBackgroundColor(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Update Your Weight',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: getTextColor())),
                    const SizedBox(height: 8),
                    Text(
                        'This will update your weight goal progress automatically',
                        style: TextStyle(color: getSubtitleColor())),
                    const SizedBox(height: 24),
                    CustomTextfeild(
                      controller: _weightController,
                      icon: const Icon(Icons.monitor_weight),
                      color: greenColor,
                      onSaved: (value) {},
                      text: 'Current Weight (kg)',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      isObscure: false,
                      keyboard: TextInputType.number,
                      input: FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*')),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: blueColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: blueColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: blueColor, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Your weight goal will be automatically updated with this measurement',
                              style: TextStyle(
                                fontSize: 12,
                                color: getTextColor(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CustomElevatedButton(
                        onpressed: _saveMeasurement,
                        text: 'Save Weight Measurement',
                        color: greenColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }
}
