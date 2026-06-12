import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/data/model/user_model.dart';
import 'package:fit_tracker/data/services/registration_validator.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/calc_widgets.dart';
import 'package:fit_tracker/presentation/pages/layout_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passkeyCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  String _selectedGender = 'Male';
  bool _obscurePasskey = true;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passkeyCtrl.dispose();
    _ageCtrl.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    final authVM = context.read<AuthViewModel>();
    final username = _usernameCtrl.text.trim();
    if (authVM.usernameExists(username)) {
      _snack('Username already taken', redColor);
      return;
    }
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: username,
      passkey: _passkeyCtrl.text.trim(),
      age: int.parse(_ageCtrl.text.trim()),
      weight: double.parse(_weightCtrl.text.trim()),
      height: double.parse(_heightCtrl.text.trim()),
      gender: _selectedGender,
    );
    await authVM.register(user);
    if (authVM.currentUser != null && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LayoutPage()),
        (_) => false,
      );
    }
  }

  void _snack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthViewModel>().isLoading;
    final theme = Theme.of(context);
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: customAppBarr('Create Profile', primaryColor, theme.scaffoldBackgroundColor),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(children: [
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person_add_outlined,
                  size: 48, color: primaryColor),
            ),
            const SizedBox(height: 24),
            Text('Create Your Profile',
                style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold, color: colors.textColor)),
            const SizedBox(height: 24),
            TextFormField(
              controller: _usernameCtrl,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person_outline),
              ),
              textCapitalization: TextCapitalization.none,
              validator: RegistrationValidator.validateUsername,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passkeyCtrl,
              decoration: InputDecoration(
                labelText: 'Passkey (min 6 chars)',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePasskey ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                  onPressed: () => setState(() => _obscurePasskey = !_obscurePasskey),
                ),
              ),
              obscureText: _obscurePasskey,
              validator: RegistrationValidator.validatePasskey,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ageCtrl,
              decoration: const InputDecoration(
                labelText: 'Age',
                prefixIcon: Icon(Icons.numbers),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: RegistrationValidator.validateAge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _weightCtrl,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                prefixIcon: Icon(Icons.monitor_weight_outlined),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
              ],
              validator: RegistrationValidator.validateWeight,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _heightCtrl,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                prefixIcon: Icon(Icons.height),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
              ],
              validator: RegistrationValidator.validateHeight,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: const InputDecoration(
                labelText: 'Gender',
                prefixIcon: Icon(Icons.wc),
              ),
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
              ],
              onChanged: (v) => setState(() => _selectedGender = v!),
            ),
            const SizedBox(height: 32),
            CalcButton(
              label: 'Create Profile',
              color: primaryColor,
              onPressed: _register,
              isLoading: isLoading,
            ),
            const SizedBox(height: 24),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Already have a profile? ',
                  style: TextStyle(color: colors.subtitleColor)),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Login',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
