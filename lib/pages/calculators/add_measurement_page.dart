import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/custom_elevated_button.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/models/measurement_model.dart';
import 'package:myapp/utils/colors.dart';

class AddMeasurementPage extends StatefulWidget {
  const AddMeasurementPage({super.key});

  @override
  State<AddMeasurementPage> createState() => _AddMeasurementPageState();
}

class _AddMeasurementPageState extends State<AddMeasurementPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _weightController.dispose();
    _waistController.dispose();
    super.dispose();
  }

  Future<void> _saveMeasurement() async {
    if (_formKey.currentState!.validate()) {
      // Check if at least one field is filled
      if (_weightController.text.isEmpty && _waistController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Fill at least one field'),
              backgroundColor: Colors.red),
        );
        return;
      }

      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 1));

      // Create and add measurement
      final measurement = Measurement(
        date: DateTime.now(),
        weight: _weightController.text.isEmpty
            ? null
            : double.parse(_weightController.text),
        waist: _waistController.text.isEmpty
            ? null
            : double.parse(_waistController.text),
      );

      measurements.add(measurement);

      setState(() => _isLoading = false);

      if (context.mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Measurement saved successfully!'),
              backgroundColor: Colors.green),
        );
        // ignore: use_build_context_synchronously
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr('Add Measurement', greenColor, backgroundColor),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Enter your measurements',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Fill in at least one field',
                        style: TextStyle(color: secondColor)),
                    const SizedBox(height: 24),
                    CustomTextfeild(
                      controller: _weightController,
                      icon: const Icon(Icons.monitor_weight),
                      color: greenColor,
                      onSaved: (value) {},
                      text: 'Weight (kg)',
                      validator: (value) => null,
                      isObscure: false,
                      keyboard: TextInputType.number,
                      input: FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*')),
                    ),
                    const SizedBox(height: 16),
                    CustomTextfeild(
                      controller: _waistController,
                      icon: const Icon(Icons.straighten),
                      color: greenColor,
                      onSaved: (value) {},
                      text: 'Waist Circumference (cm)',
                      validator: (value) => null,
                      isObscure: false,
                      keyboard: TextInputType.number,
                      input: FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*')),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CustomElevatedButton(
                        onpressed: _saveMeasurement,
                        text: 'Save Measurement',
                        color: greenColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
