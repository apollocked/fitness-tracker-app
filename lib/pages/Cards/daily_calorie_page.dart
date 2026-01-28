import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/custom_elevated_button.dart';
import 'package:myapp/Custom_Widgets/daily_calorie_input_section.dart';
import 'package:myapp/Custom_Widgets/daily_calories_dialog.dart';
import 'package:myapp/services/goals_service.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';
import 'package:myapp/utils/user_data.dart';

class DailyCaloriePage extends StatefulWidget {
  final VoidCallback? onGoalsUpdated;

  const DailyCaloriePage({super.key, this.onGoalsUpdated});

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
  String _goalType = 'maintain'; // 'lose', 'maintain', 'gain'
  double _weeklyGoal = 0.5; // kg per week

  @override
  void initState() {
    super.initState();
    // Initialize with current user's gender if available
    if (currentUser != null && currentUser!["gender"] != null) {
      _gender = currentUser!["gender"];
    }

    // Check if user has weight goal
    if (currentUser != null &&
        currentUser!['goals'] != null &&
        currentUser!['goals']['weight'] != null) {
      final weightGoal = currentUser!['goals']['weight'];
      if (weightGoal['goalType'] != null) {
        _goalType = weightGoal['goalType'];
      }
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

      // Calculate BMR
      double bmr = _gender == 'Male'
          ? (10 * weight) + (6.25 * height) - (5 * age) + 5
          : (10 * weight) + (6.25 * height) - (5 * age) - 161;

      // Activity multiplier
      double activityMultiplier = switch (_activityLevel) {
        'Sedentary' => 1.2,
        'Lightly Active' => 1.375,
        'Moderately Active' => 1.55,
        'Very Active' => 1.725,
        'Extra Active' => 1.9,
        _ => 1.2,
      };

      // Calculate maintenance calories
      double maintenanceCalories = bmr * activityMultiplier;

      // Adjust for weight goal
      double calorieAdjustment = 0;
      String goalDescription = "Maintenance";

      if (_goalType == 'lose') {
        // 1 kg fat = 7700 calories, weekly goal adjustment
        calorieAdjustment = -(_weeklyGoal * 7700 / 7);
        goalDescription = "Weight Loss ($_weeklyGoal kg/week)";
      } else if (_goalType == 'gain') {
        calorieAdjustment = (_weeklyGoal * 7700 / 7);
        goalDescription = "Weight Gain ($_weeklyGoal kg/week)";
      }

      double dailyCalories = maintenanceCalories + calorieAdjustment;

      // Round to nearest 10
      dailyCalories = (dailyCalories / 10).round() * 10;

      // Save as goal
      GoalsService.updateGoalFromCalculator(
        'calories',
        0.0, // Start with 0 current
        dailyCalories,
      );

      // Notify parent if callback exists
      widget.onGoalsUpdated?.call();

      // FIXED: Make sure the dialog shows
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DailyCaloriesResultsDialog.showResults(
          context,
          bmr: bmr,
          maintenanceCalories: maintenanceCalories,
          dailyCalories: dailyCalories,
          goalType: _goalType,
          weeklyGoal: _weeklyGoal,
          goalDescription: goalDescription,
          onSetGoal: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$goalDescription calorie goal saved!'),
                backgroundColor: greenColor,
              ),
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(
          "Daily Calorie Calculator", redColor, getBackgroundColor()),
      backgroundColor: getBackgroundColor(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Calculate Your Daily Calorie Needs',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: getTextColor())),
              const SizedBox(height: 8),
              Text('Enter your details to calculate daily calorie requirements',
                  style: TextStyle(color: getSubtitleColor())),
              const SizedBox(height: 24),

              // Basic inputs
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

              const SizedBox(height: 20),

              // Weight goal section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: getCardColor(),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: redColor.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Weight Goal',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: getTextColor())),
                    const SizedBox(height: 12),

                    // Goal type selection
                    Row(
                      children: [
                        Expanded(
                          child: _buildCalorieGoalOption('Lose Weight', 'lose'),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child:
                              _buildCalorieGoalOption('Maintain', 'maintain'),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildCalorieGoalOption('Gain Weight', 'gain'),
                        ),
                      ],
                    ),

                    if (_goalType != 'maintain') ...[
                      const SizedBox(height: 16),
                      Text('Weekly Goal: $_weeklyGoal kg per week',
                          style:
                              TextStyle(fontSize: 14, color: getTextColor())),
                      const SizedBox(height: 8),
                      Slider(
                        value: _weeklyGoal,
                        min: 0.1,
                        max: 1.0,
                        divisions: 9,
                        label: '$_weeklyGoal kg/week',
                        activeColor: redColor,
                        inactiveColor: redColor.withOpacity(0.3),
                        onChanged: (value) {
                          setState(() {
                            _weeklyGoal =
                                double.parse(value.toStringAsFixed(1));
                          });
                        },
                      ),
                    ],
                  ],
                ),
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

  Widget _buildCalorieGoalOption(String text, String value) {
    final isSelected = _goalType == value;
    return GestureDetector(
      onTap: () => setState(() => _goalType = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? redColor.withOpacity(0.2) : getCardColor(),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? redColor : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              value == 'lose'
                  ? Icons.trending_down
                  : value == 'gain'
                      ? Icons.trending_up
                      : Icons.trending_flat,
              color: isSelected ? redColor : getSubtitleColor(),
            ),
            const SizedBox(height: 4),
            Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? redColor : getTextColor(),
                )),
          ],
        ),
      ),
    );
  }
}
