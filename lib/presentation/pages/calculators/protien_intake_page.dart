import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/calc_widgets.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_textfield.dart';
import 'package:fit_tracker/presentation/widgets/select_workout_type.dart';
import 'package:fit_tracker/presentation/widgets/protien_intake/protein_dialog.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/logic/calculators_viewmodel.dart';

class ProtienIntakePage extends StatefulWidget {
  final VoidCallback? onGoalsUpdated;
  const ProtienIntakePage({super.key, this.onGoalsUpdated});
  @override
  State<ProtienIntakePage> createState() => _ProtienIntakePageState();
}

class _ProtienIntakePageState extends State<ProtienIntakePage> {
  final _formKey = GlobalKey<FormState>();
  final _weightCtrl = TextEditingController();
  bool _isBodybuilder = false;

  @override
  void dispose() {
    _weightCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;
    final weight = double.parse(_weightCtrl.text);
    final vals = context
        .read<CalculatorsViewModel>()
        .calculateProteinValues(weight, _isBodybuilder);
    final target = _isBodybuilder ? vals.max : vals.normal;
    context
        .read<GoalsViewModel>()
        .updateGoal('protein', {'target': target, 'active': true});
    widget.onGoalsUpdated?.call();
    ProteinResultsDialog.showResults(context,
        isBodybuilder: _isBodybuilder,
        normalProtein: vals.normal,
        minProtein: vals.min,
        maxProtein: vals.max, onSetGoal: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Protein goal saved!'),
          backgroundColor: greenColor));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppBarr(
          'Protein Intake', orangeColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Form(
            key: _formKey,
            child: Column(children: [
              Text('Are You a Bodybuilder?',
                  style: TextStyle(
                      fontSize: 15,
                      color: colors.textColor,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              CustomBodyTypeRatio(
                  isBodybuilder: _isBodybuilder,
                  onChanged: (v) => setState(() => _isBodybuilder = v)),
              const SizedBox(height: 20),
              CustomTextfield(
                controller: _weightCtrl,
                isObscure: false,
                keyboard: TextInputType.number,
                color: orangeColor,
                onSaved: (_) {},
                text: 'Weight (kg)',
                icon: const Icon(Icons.monitor_weight_outlined),
                input: FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter your weight';
                  if (double.tryParse(v) == null) return 'Invalid number';
                  return null;
                },
              ),
              const SizedBox(height: 28),
              CalcButton(
                  label: 'Calculate',
                  color: orangeColor,
                  onPressed: _calculate),
            ])),
      ),
    );
  }
}
