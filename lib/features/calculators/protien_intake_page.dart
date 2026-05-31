import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fit_tracker/widgets/custom_appbar.dart';
import 'package:fit_tracker/widgets/custom_elevated_button.dart';
import 'package:fit_tracker/widgets/custom_textfield.dart';
import 'package:fit_tracker/widgets/protein_dialog.dart';
import 'package:fit_tracker/widgets/select_workout_type.dart';
import 'package:fit_tracker/app/services/goals_service.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/theme/colors.dart';

class ProtienIntakePage extends StatefulWidget {
  final VoidCallback? onGoalsUpdated;

  const ProtienIntakePage({super.key, this.onGoalsUpdated});

  @override
  State<ProtienIntakePage> createState() => _ProtienIntakePageState();
}

class _ProtienIntakePageState extends State<ProtienIntakePage> {
  final GlobalKey<FormState> _form2 = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  bool _isBodybuilder = false;

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  void _calculateProtein() {
    if (_form2.currentState!.validate()) {
      final weight = double.parse(_weightController.text);

      double normalProteins = 0.0;
      double minProteins = 0.0;
      double maxProteins = 0.0;

      if (!_isBodybuilder) {
        normalProteins = 0.8 * weight;
      } else {
        maxProteins = 2.0 * weight;
        minProteins = 1.2 * weight;
      }

      normalProteins = (normalProteins * 100).round() / 100;
      maxProteins = (maxProteins * 100).round() / 100;
      minProteins = (minProteins * 100).round() / 100;

      // For non-bodybuilders, use normalProteins as target
      // For bodybuilders, use maxProteins as target
      final targetProtein = !_isBodybuilder ? normalProteins : maxProteins;

      // Save protein goal WITHOUT current value (only target)
      GoalsService.updateGoalFromCalculator('protein', targetProtein);

      // Notify parent if callback exists
      widget.onGoalsUpdated?.call();

      ProteinResultsDialog.showResults(
        context,
        isBodybuilder: _isBodybuilder,
        normalProtein: normalProteins,
        minProtein: minProteins,
        maxProtein: maxProteins,
        onSetGoal: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Protein goal saved successfully!'),
              backgroundColor: greenColor,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: customAppBarr("Protein Intake Calculator", orangeColor,
          theme.scaffoldBackgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _form2,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Are You a BodyBuilder ?',
                        style:
                            TextStyle(fontSize: 16, color: colors.textColor)),
                    CustomBodyTypeRatio(
                      isBodybuilder: _isBodybuilder,
                      onChanged: (value) {
                        setState(() => _isBodybuilder = value);
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextfield(
                      controller: _weightController,
                      isObscure: false,
                      keyboard: TextInputType.number,
                      color: orangeColor,
                      onSaved: (value) {},
                      text: "Weight (kg)",
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
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CustomElevatedButton(
                        onpressed: _calculateProtein,
                        text: "Calculate",
                        color: orangeColor,
                      ),
                    ),
                    const SizedBox(height: 35),
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
