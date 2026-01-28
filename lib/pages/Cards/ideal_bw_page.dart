import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/custom_elevated_button.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/Custom_Widgets/select_gender_radio.dart';
import 'package:myapp/Custom_Widgets/ideal_weight_dialog.dart';
import 'package:myapp/services/goals_service.dart';
import 'package:myapp/utils/dark_mode_helper.dart';
import 'package:myapp/utils/colors.dart';

class IdealBodyWeightPage extends StatefulWidget {
  final VoidCallback? onGoalsUpdated;

  const IdealBodyWeightPage({super.key, this.onGoalsUpdated});

  @override
  State<IdealBodyWeightPage> createState() => _IdealBodyWeightPageState();
}

class _IdealBodyWeightPageState extends State<IdealBodyWeightPage> {
  final GlobalKey<FormState> _form1 = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _targetWeightController = TextEditingController();

  String _gender = "Male";

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _targetWeightController.dispose();
    super.dispose();
  }

  void _calculateIdealWeight() {
    if (_form1.currentState!.validate()) {
      final height = double.parse(_heightController.text);
      final currentWeight = double.parse(_weightController.text);

      // If target weight is provided, use it. Otherwise calculate ideal weight
      double targetWeight;

      if (_targetWeightController.text.isNotEmpty) {
        targetWeight = double.parse(_targetWeightController.text);
      } else {
        targetWeight = _gender == "Male"
            ? 50 + (0.91 * (height - 152.4))
            : 45.5 + (0.91 * (height - 152.4));
        targetWeight = (targetWeight * 100).round() / 100;
      }

      // Automatically determine goal type based on comparison
      String goalType;
      if (targetWeight < currentWeight) {
        goalType = "lose";
      } else if (targetWeight > currentWeight) {
        goalType = "gain";
      } else {
        goalType = "maintain";
      }

      // Calculate weight difference
      double weightDifference = (targetWeight - currentWeight).abs();
      weightDifference = (weightDifference * 100).round() / 100;

      // Save as goal with automatically determined goal type
      GoalsService.updateWeightGoalWithTarget(
        currentWeight,
        targetWeight,
        goalType,
      );

      // Notify parent if callback exists
      widget.onGoalsUpdated?.call();

      // Show the dialog
      IdealWeightResultsDialog.showResults(
        context,
        idealWeight: targetWeight,
        currentWeight: currentWeight,
        goalType: goalType,
        weightDifference: weightDifference,
        onSetGoal: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${goalType.capitalize()} weight goal saved!'),
              backgroundColor: greenColor,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      appBar: customAppBarr(
          "Ideal Body Weight Calculator", blueColor, getBackgroundColor()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _form1,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Select Your Gender',
                        style:
                            TextStyle(color: getSubtitleColor(), fontSize: 16)),
                    CustomGenderRatio(
                      color: blueColor,
                      initialGender: "Male",
                      onGenderChanged: (value) {
                        setState(() => _gender = value);
                      },
                    ),
                    const SizedBox(height: 15),

                    // Height input
                    CustomTextfeild(
                      controller: _heightController,
                      isObscure: false,
                      keyboard: TextInputType.number,
                      color: blueColor,
                      onSaved: (value) {},
                      text: "Height (cm)",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your height please";
                        }
                        if (double.tryParse(value) == null) {
                          return "Enter a valid number";
                        }
                        return null;
                      },
                      icon: const Icon(Icons.height),
                      input: FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*')),
                    ),
                    const SizedBox(height: 15),

                    // Current weight input
                    CustomTextfeild(
                      controller: _weightController,
                      isObscure: false,
                      keyboard: TextInputType.number,
                      color: blueColor,
                      onSaved: (value) {},
                      text: "Current Weight (kg)",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your weight please";
                        }
                        if (double.tryParse(value) == null) {
                          return "Enter a valid number";
                        }
                        return null;
                      },
                      icon: const Icon(Icons.monitor_weight),
                      input: FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*')),
                    ),
                    const SizedBox(height: 15),

                    // Target weight input (optional)
                    CustomTextfeild(
                      controller: _targetWeightController,
                      isObscure: false,
                      keyboard: TextInputType.number,
                      color: blueColor,
                      onSaved: (value) {},
                      text: "Target Weight (kg) - Optional",
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            double.tryParse(value) == null) {
                          return "Enter a valid number";
                        }
                        return null;
                      },
                      icon: const Icon(Icons.flag),
                      input: FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*')),
                    ),
                    const SizedBox(height: 10),

                    // Information text
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
                              'Goal type (Lose/Gain/Maintain) will be automatically determined based on your current vs target weight',
                              style: TextStyle(
                                fontSize: 12,
                                color: getTextColor(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CustomElevatedButton(
                        onpressed: _calculateIdealWeight,
                        text: "Calculate",
                        color: blueColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper extension for string capitalization
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
