import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/custom_elevated_button.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
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
      setState(() {
        _isLoading = true;
      });

      // Simulate saving (you can implement your own storage later)
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _isLoading = false;
      });

      if (context.mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Measurement saved successfully!')),
        );
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(
        'Add Measurement',
        greenColor,
        backgroundColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter your measurements',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fill in at least one field',
                      style: TextStyle(color: secondColor),
                    ),
                    const SizedBox(height: 24),
                    CustomTextfeild(
                      icon: const Icon(Icons.monitor_weight),
                      color: blackColor,
                      onSaved: (value) {},
                      text: 'Weight (kg)',
                      validator: (value) {
                        return null;
                      },
                      isObscure: false,
                      keyboard: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    CustomTextfeild(
                      isObscure: false,
                      keyboard: TextInputType.number,
                      icon: const Icon(Icons.straighten),
                      color: blackColor,
                      onSaved: (value) {},
                      text: 'Waist Circumference (cm)',
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 50),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomElevatedButton(
                            onpressed: _saveMeasurement,
                            text: 'Save Measurement',
                            color: greenColor)),
                  ],
                ),
              ),
            ),
    );
  }
}
