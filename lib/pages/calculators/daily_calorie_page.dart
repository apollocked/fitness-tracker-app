import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/custom_elevated_button.dart';
import 'package:myapp/Custom_Widgets/daily_calories_dialog.dart';
import 'package:myapp/Custom_Widgets/daily_calorie_input_section.dart';

import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

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

  String _activityLevel = 'Sedentary';
  String _gender = 'Male';

  @override
  void initState() {
    super.initState();
    // Initialize with current user's gender if available
    if (currentUser != null && currentUser!["gender"] != null) {
      _gender = currentUser!["gender"];
    }
  }

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

      double bmr = _gender == 'Male'
          ? (10 * weight) + (6.25 * height) - (5 * age) + 5
          : (10 * weight) + (6.25 * height) - (5 * age) - 161;

      double activityMultiplier = switch (_activityLevel) {
        'Sedentary' => 1.2,
        'Lightly Active' => 1.375,
        'Moderately Active' => 1.55,
        'Very Active' => 1.725,
        'Extra Active' => 1.9,
        _ => 1.2,
      };

      double dailyCalories = bmr * activityMultiplier;

      DailyCaloriesResultsDialog.showResults(
        context,
        bmr: bmr,
        dailyCalories: dailyCalories,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBarr("Daily Calorie Calculator", redColor, backgroundColor),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Calculate Your Daily Calorie Needs',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Enter your details to calculate daily calorie requirements',
                  style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 24),
              DailyCalorieInputSection(
                ageController: _ageController,
                weightController: _weightController,
                heightController: _heightController,
                activityLevel: _activityLevel,
                gender: _gender,
                onActivityChanged: (value) =>
                    setState(() => _activityLevel = value),
                onGenderChanged: (value) => setState(() => _gender = value),
              ),
              const SizedBox(height: 32),
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
            ],
          ),
        ),
      ),
    );
  }
}
