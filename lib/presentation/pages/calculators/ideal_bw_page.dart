import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/calc_widgets.dart';
import 'package:fit_tracker/presentation/widgets/ideal_weight/ideal_bw_form.dart';
import 'package:fit_tracker/presentation/widgets/ideal_weight_dialog.dart';
import 'package:fit_tracker/data/model/measurement_model.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/logic/progress_viewmodel.dart';
import 'package:fit_tracker/logic/calculators_viewmodel.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class IdealBodyWeightPage extends StatefulWidget {
  const IdealBodyWeightPage({super.key});
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
  void initState() {
    super.initState();
    final user = context.read<AuthViewModel>().currentUser;
    if (user != null) {
      _gender = user.gender;
      if (user.weight > 0) _weightCtrl.text = user.weight.toString();
      if (user.height > 0) _heightCtrl.text = user.height.toString();
      final wg = user.goals['weight'];
      if (wg?['target'] != null) _targetCtrl.text = wg!['target'].toString();
    }
  }

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
    IdealWeightResultsDialog.showResults(context,
        idealWeight: target,
        currentWeight: current,
        goalType: goalType,
        weightDifference: diff, onSetGoal: () {
      context.read<GoalsViewModel>().updateGoal('weight', {
        'target': target,
        'current': current,
        'startWeight': current,
        'goalType': goalType,
        'active': true,
        'unit': 'kg',
      });
      context
          .read<ProgressViewModel>()
          .addMeasurement(Measurement(weight: current, date: DateTime.now()));
      final authVM = context.read<AuthViewModel>();
      final user = authVM.currentUser;
      if (user != null) {
        authVM.updateUser(
            user.copyWith(weight: current, height: height, gender: _gender));
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.bmiUpdated),
          backgroundColor: greenColor));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: customAppBarr(
          l10n.bmiTitle, blueColor, theme.scaffoldBackgroundColor),
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
            message: l10n.bmiDescription,
            accentColor: blueColor,
          ),
          const SizedBox(height: 24),
          CalcButton(
              label: l10n.bmiResult, color: blueColor, onPressed: _calculate),
        ]),
      ),
    );
  }
}
