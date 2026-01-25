import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/custom_elevated_button.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart'
    show CustomTextfeild;
import 'package:myapp/Custom_Widgets/select_gender_radio.dart';
import 'package:myapp/utils/colors.dart';

class DailyCaloriePage extends StatefulWidget {
  const DailyCaloriePage({super.key});

  @override
  State<DailyCaloriePage> createState() => _DailyCaloriePageState();
}

class _DailyCaloriePageState extends State<DailyCaloriePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  // ignore: prefer_final_fields
  String _gender = 'Male';
  String _activityLevel = 'Sedentary';
  double? _bmr;
  double? _dailyCalories;

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateCalories() {
    if (_formKey.currentState!.validate()) {
      final age = int.parse(_ageController.text);
      final weight = double.parse(_weightController.text);
      final height = double.parse(_heightController.text);

      // Calculate BMR using Mifflin-St Jeor Equation
      double bmr;
      if (_gender == 'Male') {
        bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
      } else {
        bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
      }

      // Apply activity multiplier
      double activityMultiplier;
      switch (_activityLevel) {
        case 'Sedentary':
          activityMultiplier = 1.2;
          break;
        case 'Lightly Active':
          activityMultiplier = 1.375;
          break;
        case 'Moderately Active':
          activityMultiplier = 1.55;
          break;
        case 'Very Active':
          activityMultiplier = 1.725;
          break;
        case 'Extra Active':
          activityMultiplier = 1.9;
          break;
        default:
          activityMultiplier = 1.2;
      }

      setState(() {
        _bmr = bmr;
        _dailyCalories = bmr * activityMultiplier;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBarr("Daily Calorie Calculator", redColor, backgroundColor),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Calculate Your Daily Calorie Needs',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your details to calculate your daily calorie requirements',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),

              // Gender Selection
              const Text(
                'Gender',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              CustomGenderRatio(color: redColor),

              // Age Input
              CustomTextfeild(
                icon: const Icon(Icons.cake),
                color: redColor,
                onSaved: (value) {},
                text: 'Age (years)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Weight Input
              CustomTextfeild(
                icon: const Icon(Icons.monitor_weight),
                color: redColor,
                onSaved: (value) {},
                text: 'Weight (kg)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextfeild(
                icon: const Icon(Icons.height),
                color: redColor,
                text: 'Height (cm)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              const SizedBox(height: 16),

              // Activity Level
              const Text(
                'Activity Level',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: secondColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _activityLevel,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'Sedentary',
                        child: Text('Sedentary (little or no exercise)'),
                      ),
                      DropdownMenuItem(
                        value: 'Lightly Active',
                        child: Text('Lightly Active (1-3 days/week)'),
                      ),
                      DropdownMenuItem(
                        value: 'Moderately Active',
                        child: Text('Moderately Active (3-5 days/week)'),
                      ),
                      DropdownMenuItem(
                        value: 'Very Active',
                        child: Text('Very Active (6-7 days/week)'),
                      ),
                      DropdownMenuItem(
                        value: 'Extra Active',
                        child: Text('Extra Active (athlete/physical job)'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _activityLevel = value!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Calculate Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomElevatedButton(
                  onpressed: _calculateCalories,
                  text: "Calculate",
                  color: redColor,
                ),
              ),
              const SizedBox(height: 32),

              // Results
              if (_dailyCalories != null) ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        size: 50,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Your Results',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildResultRow('BMR (Basal Metabolic Rate)',
                          '${_bmr!.toStringAsFixed(0)} cal/day'),
                      const Divider(height: 24),
                      _buildResultRow('Daily Calorie Needs',
                          '${_dailyCalories!.toStringAsFixed(0)} cal/day',
                          isMain: true),
                      const SizedBox(height: 16),
                      Text(
                        'This is the number of calories you need to maintain your current weight',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'For Weight Goals:',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '• Weight Loss: ${(_dailyCalories! - 500).toStringAsFixed(0)} cal/day',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              '• Weight Gain: ${(_dailyCalories! + 500).toStringAsFixed(0)} cal/day',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, {bool isMain = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isMain ? 18 : 16,
            fontWeight: isMain ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isMain ? 24 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
