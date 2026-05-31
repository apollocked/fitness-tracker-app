// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_elevated_button.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_textfield.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/porviders/auth_viewmodel.dart';

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
    _loadCurrentWeight();
  }

  void _loadCurrentWeight() {
    final user = context.read<AuthViewModel>().currentUser;
    if (user != null) {
      _weightController.text = user.weight.toString();
    }
  }

  Future<void> _saveMeasurement() async {
    if (_formKey.currentState!.validate()) {
      if (_weightController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please enter your weight'),
              backgroundColor: Colors.red),
        );
        return;
      }

      setState(() => _isLoading = true);

      try {
        final newWeight = double.parse(_weightController.text);

        // Add measurement

        // Update user weight
        final authVM = context.read<AuthViewModel>();
        final user = authVM.currentUser;
        if (user != null) {
          user.weight = newWeight;
          authVM.updateUser(user);
        }

        setState(() => _isLoading = false);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Measurement saved successfully!'),
                backgroundColor: Colors.green),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        setState(() => _isLoading = false);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Error saving measurement: $e'),
                backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppBarr(
          'Add Measurement', greenColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
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
                            color: colors.textColor)),
                    const SizedBox(height: 8),
                    Text(
                        'This will update your weight goal progress automatically',
                        style: TextStyle(color: colors.subtitleColor)),
                    const SizedBox(height: 24),
                    CustomTextfield(
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
                                color: colors.textColor,
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
