import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_textfield.dart';
import 'package:fit_tracker/presentation/widgets/shared/calc_widgets.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/porviders/auth_viewmodel.dart';
import 'package:fit_tracker/logic/porviders/progress_viewmodel.dart';
import 'package:fit_tracker/data/model/measurement_model.dart';

class AddMeasurementPage extends StatefulWidget {
  const AddMeasurementPage({super.key});
  @override
  State<AddMeasurementPage> createState() => _AddMeasurementPageState();
}

class _AddMeasurementPageState extends State<AddMeasurementPage> {
  final _formKey = GlobalKey<FormState>();
  final _weightCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthViewModel>().currentUser;
    if (user != null) _weightCtrl.text = user.weight.toString();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final newWeight = double.parse(_weightCtrl.text);
      final authVM = context.read<AuthViewModel>();
      final user = authVM.currentUser;
      if (user != null) {
        user.weight = newWeight;
        authVM.updateUser(user);
      }
      final progressVM = context.read<ProgressViewModel>();
      progressVM
          .addMeasurement(Measurement(weight: newWeight, date: DateTime.now()));
      setState(() => _isLoading = false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Measurement saved!'),
            backgroundColor: Colors.green));
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
      }
    }
  }

  @override
  void dispose() {
    _weightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppBarr(
          'Add Measurement', greenColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: primaryColor))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Update Your Weight',
                          style: theme.textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text('Updates your weight goal progress automatically',
                          style: TextStyle(
                              color: colors.subtitleColor, fontSize: 13)),
                      const SizedBox(height: 24),
                      CustomTextfield(
                        controller: _weightCtrl,
                        icon: const Icon(Icons.monitor_weight_outlined),
                        color: greenColor,
                        onSaved: (_) {},
                        text: 'Current Weight (kg)',
                        isObscure: false,
                        keyboard: TextInputType.number,
                        input: FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*')),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          if (double.tryParse(v) == null) {
                            return 'Invalid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      InfoBox(
                          message:
                              'Your weight goal will be automatically updated with this measurement.',
                          accentColor: greenColor),
                      const SizedBox(height: 28),
                      CalcButton(
                          label: 'Save Measurement',
                          color: greenColor,
                          onPressed: _save),
                    ]),
              ),
            ),
    );
  }
}
