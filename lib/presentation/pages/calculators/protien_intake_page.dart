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
import 'package:fit_tracker/data/model/measurement_model.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/logic/progress_viewmodel.dart';
import 'package:fit_tracker/logic/calculators_viewmodel.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class ProtienIntakePage extends StatefulWidget {
  const ProtienIntakePage({super.key});
  @override
  State<ProtienIntakePage> createState() => _ProtienIntakePageState();
}

class _ProtienIntakePageState extends State<ProtienIntakePage> {
  final _formKey = GlobalKey<FormState>();
  final _weightCtrl = TextEditingController();
  bool _isBodybuilder = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthViewModel>().currentUser;
    if (user != null) {
      if (user.weight > 0) _weightCtrl.text = user.weight.toString();
      _isBodybuilder = user.isBodybuilder;
    }
  }

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
    ProteinResultsDialog.showResults(context,
        isBodybuilder: _isBodybuilder,
        normalProtein: vals.normal,
        minProtein: vals.min,
        maxProtein: vals.max, onSetGoal: () {
      context.read<GoalsViewModel>().updateGoal(
          'protein', {'target': target, 'active': true, 'unit': 'g'});
      context
          .read<ProgressViewModel>()
          .addMeasurement(Measurement(weight: weight, date: DateTime.now()));
      final authVM = context.read<AuthViewModel>();
      final user = authVM.currentUser;
      if (user != null) {
        authVM.updateUser(
            user.copyWith(weight: weight, isBodybuilder: _isBodybuilder));
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.proteinUpdated),
          backgroundColor: greenColor));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: customAppBarr(
          l10n.proteinTitle, orangeColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Form(
            key: _formKey,
            child: Column(children: [
              Text(l10n.proteinIntake,
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
                text: l10n.proteinGPerDay,
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
                  label: l10n.proteinResult,
                  color: orangeColor,
                  onPressed: _calculate),
            ])),
      ),
    );
  }
}
