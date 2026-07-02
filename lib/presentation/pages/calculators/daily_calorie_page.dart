import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/data/model/measurement_model.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/calc_widgets.dart';
import 'package:fit_tracker/presentation/widgets/daily_calories/daily_calorie_input_section.dart';
import 'package:fit_tracker/presentation/widgets/daily_calories/daily_calories_dialog.dart';
import 'package:fit_tracker/presentation/widgets/daily_calories/calorie_goal_option.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/logic/progress_viewmodel.dart';
import 'package:fit_tracker/logic/calculators_viewmodel.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class DailyCaloriePage extends StatefulWidget {
  const DailyCaloriePage({super.key});
  @override
  State<DailyCaloriePage> createState() => _DailyCaloriePageState();
}

class _DailyCaloriePageState extends State<DailyCaloriePage> {
  final _formKey = GlobalKey<FormState>();
  final _ageCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  String _activityLevel = 'Sedentary';
  String _gender = 'Male';
  String _goalType = 'maintain';
  double _weeklyGoal = 0.5;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthViewModel>().currentUser;
    if (user != null) {
      _gender = user.gender;
      if (user.weight > 0) _weightCtrl.text = user.weight.toString();
      if (user.height > 0) _heightCtrl.text = user.height.toString();
      if (user.age > 0) _ageCtrl.text = user.age.toString();
      final wg = user.goals['weight'];
      if (wg?['goalType'] != null) _goalType = wg!['goalType'];
    }
  }

  @override
  void dispose() {
    _ageCtrl.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;
    final calcVM = context.read<CalculatorsViewModel>();
    final weight = double.parse(_weightCtrl.text);
    final height = double.parse(_heightCtrl.text);
    final age = int.parse(_ageCtrl.text);
    final bmr = calcVM.calculateBMR(weight, height, age, _gender);
    final maintenance = calcVM.calculateTDEE(bmr, _activityLevel);
    final adj = calcVM.getCalorieAdjustment(_goalType, _weeklyGoal);
    final daily = ((maintenance + adj) / 10).round() * 10.0;
    final desc = _goalType == 'maintain'
        ? l10n.calorieMaintenance
        : _goalType == 'lose'
            ? l10n.calorieGoalDescLose(_weeklyGoal.toStringAsFixed(1))
            : l10n.calorieGoalDescGain(_weeklyGoal.toStringAsFixed(1));
    DailyCaloriesResultsDialog.showResults(context,
        bmr: bmr,
        maintenanceCalories: maintenance,
        dailyCalories: daily,
        goalType: _goalType,
        weeklyGoal: _weeklyGoal,
        goalDescription: desc, onSetGoal: () {
      context.read<GoalsViewModel>().updateGoal(
          'calories', {'target': daily, 'active': true, 'unit': 'cal'});
      context
          .read<ProgressViewModel>()
          .addMeasurement(Measurement(weight: weight, date: DateTime.now()));
      final authVM = context.read<AuthViewModel>();
      final user = authVM.currentUser;
      if (user != null) {
        authVM.updateUser(
            user.copyWith(weight: weight, height: height, age: age));
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.calorieUpdated), backgroundColor: greenColor));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: customAppBarr(
          l10n.calorieTitle, redColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(l10n.calorieTitle, style: theme.textTheme.titleLarge),
              const SizedBox(height: 6),
              Text(l10n.calorieDescription,
                  style: TextStyle(color: colors.subtitleColor, fontSize: 13)),
              const SizedBox(height: 20),
              DailyCalorieInputSection(
                  ageController: _ageCtrl,
                  weightController: _weightCtrl,
                  heightController: _heightCtrl,
                  activityLevel: _activityLevel,
                  gender: _gender,
                  onActivityChanged: (v) => setState(() => _activityLevel = v),
                  onGenderChanged: (v) => setState(() => _gender = v)),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: colors.cardColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: redColor.withOpacity(0.25))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.calorieGoal,
                          style: theme.textTheme.titleMedium),
                      const SizedBox(height: 12),
                      Row(children: [
                        Expanded(
                            child: CalorieGoalOption(
                                label: l10n.calorieGoalLose,
                                value: 'lose',
                                selectedValue: _goalType,
                                onTap: () =>
                                    setState(() => _goalType = 'lose'))),
                        const SizedBox(width: 8),
                        Expanded(
                            child: CalorieGoalOption(
                                label: l10n.calorieGoalMaintain,
                                value: 'maintain',
                                selectedValue: _goalType,
                                onTap: () =>
                                    setState(() => _goalType = 'maintain'))),
                        const SizedBox(width: 8),
                        Expanded(
                            child: CalorieGoalOption(
                                label: l10n.calorieGoalGain,
                                value: 'gain',
                                selectedValue: _goalType,
                                onTap: () =>
                                    setState(() => _goalType = 'gain'))),
                      ]),
                      if (_goalType != 'maintain') ...[
                        const SizedBox(height: 14),
                        Text(l10n.calorieGoalLabel(_weeklyGoal.toStringAsFixed(1)),
                            style: TextStyle(
                                fontSize: 13, color: colors.textColor)),
                        Slider(
                            value: _weeklyGoal,
                            min: 0.1,
                            max: 1.0,
                            divisions: 9,
                            activeColor: redColor,
                            inactiveColor: redColor.withOpacity(0.2),
                            label: l10n.calorieSliderLabel(_weeklyGoal.toStringAsFixed(1)),
                            onChanged: (v) => setState(() => _weeklyGoal =
                                double.parse(v.toStringAsFixed(1)))),
                      ],
                    ]),
              ),
              const SizedBox(height: 24),
              CalcButton(
                  label: l10n.calorieCalculate, color: redColor, onPressed: _calculate),
              const SizedBox(height: 32),
            ])),
      ),
    );
  }
}
