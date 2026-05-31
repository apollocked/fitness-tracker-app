import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/calc_widgets.dart';
import 'package:fit_tracker/presentation/widgets/ideal_weight/ideal_bw_form.dart';
import 'package:fit_tracker/presentation/widgets/ideal_weight_dialog.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/logic/calculators_viewmodel.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';

class IdealBodyWeightPage extends StatefulWidget {
  final VoidCallback? onGoalsUpdated;
  const IdealBodyWeightPage({super.key, this.onGoalsUpdated});
  @override
  State<IdealBodyWeightPage> createState() => _IdealBodyWeightPageState();
}

class _IdealBodyWeightPageState extends State<IdealBodyWeightPage> {
  final _formKey = GlobalKey<FormState>();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _targetCtrl = TextEditingController();
  String _gender = 'Male';

  @override
  void dispose() {
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _targetCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;
    final height = double.parse(_heightCtrl.text);
    final current = double.parse(_weightCtrl.text);
    double target = _targetCtrl.text.isNotEmpty
        ? double.parse(_targetCtrl.text)
        : (context
                        .read<CalculatorsViewModel>()
                        .calculateIdealWeight(height, _gender) *
                    100)
                .round() /
            100;
    final goalType = target < current
        ? 'lose'
        : target > current
            ? 'gain'
            : 'maintain';
    final diff = ((target - current).abs() * 100).round() / 100;
    context.read<GoalsViewModel>().updateGoal('weight', {
      'target': target,
      'current': current,
      'startWeight': current,
      'goalType': goalType,
      'active': true,
    });
    widget.onGoalsUpdated?.call();
    IdealWeightResultsDialog.showResults(context,
        idealWeight: target,
        currentWeight: current,
        goalType: goalType,
        weightDifference: diff, onSetGoal: () {
      final label = '${goalType[0].toUpperCase()}${goalType.substring(1)}';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$label weight goal saved!'),
          backgroundColor: greenColor));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppBarr(
          'Ideal Body Weight', blueColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          IdealBwForm(
            formKey: _formKey,
            heightController: _heightCtrl,
            weightController: _weightCtrl,
            targetWeightController: _targetCtrl,
            gender: _gender,
            onGenderChanged: (v) => setState(() => _gender = v),
          ),
          const SizedBox(height: 14),
          InfoBox(
            message:
                'Goal type (Lose/Gain/Maintain) is auto-determined from your current vs target weight.',
            accentColor: blueColor,
          ),
          const SizedBox(height: 24),
          CalcButton(
              label: 'Calculate', color: blueColor, onPressed: _calculate),
        ]),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
}
