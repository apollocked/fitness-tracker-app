import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_textfield.dart';
import 'package:fit_tracker/presentation/widgets/auth/auth_footer_widget.dart';
import 'package:fit_tracker/presentation/widgets/auth/auth_header_widget.dart';
import 'package:fit_tracker/presentation/widgets/auth/requirements_checklist.dart';
import 'package:fit_tracker/presentation/widgets/profile/personal_info_section.dart';
import 'package:fit_tracker/presentation/pages/auth/login_page.dart';
import 'package:fit_tracker/presentation/pages/layout_page.dart';
import 'package:fit_tracker/data/services/registration_validator.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/data/model/user_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _ageCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String _gender = 'Male';

  @override
  void dispose() {
    for (final c in [
      _ageCtrl,
      _weightCtrl,
      _heightCtrl,
      _usernameCtrl,
      _emailCtrl,
      _passCtrl
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _snack(String msg, Color color) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg),
          backgroundColor: color,
          duration: const Duration(seconds: 2)));

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    final authVM = context.read<AuthViewModel>();
    if (authVM.emailExists(_emailCtrl.text.trim())) {
      _snack('Email already registered', Colors.red);
      return;
    }
    if (!RegistrationValidator.validateAll(
        username: _usernameCtrl.text,
        email: _emailCtrl.text,
        password: _passCtrl.text,
        age: _ageCtrl.text,
        weight: _weightCtrl.text,
        height: _heightCtrl.text,
        gender: _gender)) {
      _snack('Please fill all fields correctly', Colors.red);
      return;
    }
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: _usernameCtrl.text.trim(),
      email: _emailCtrl.text.toLowerCase().trim(),
      password: _passCtrl.text,
      age: int.tryParse(_ageCtrl.text) ?? 0,
      weight: double.tryParse(_weightCtrl.text) ?? 0.0,
      height: double.tryParse(_heightCtrl.text) ?? 0.0,
      gender: _gender,
      goals: {
        'weight': {
          'target': 0.0,
          'current': double.tryParse(_weightCtrl.text) ?? 0.0,
          'unit': 'kg',
          'active': false,
          'goalType': 'maintain'
        },
        'protein': {'target': 0, 'unit': 'g', 'active': false},
        'calories': {'target': 0, 'unit': 'cal', 'active': false},
      },
    );
    await authVM.register(user);
    if (!context.mounted) return;
    if (authVM.currentUser != null) {
      _snack('Account created successfully!', greenColor);
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        // Navigate to main app directly (works for both guest upgrade and fresh register)
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LayoutPage()),
          (_) => false,
        );
      }
    } else {
      _snack('Registration failed', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthViewModel>().isLoading;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            const AuthHeader(
                title: 'Welcome!',
                subtitle: 'Start your fitness journey today'),
            Form(
              key: _formKey,
              child: Column(children: [
                CustomTextfield(
                    controller: _usernameCtrl,
                    text: 'Username',
                    isObscure: false,
                    color: primaryColor,
                    icon: const Icon(Icons.person_outline),
                    onSaved: (_) {},
                    validator: RegistrationValidator.validateUsername,
                    keyboard: TextInputType.text,
                    input: FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9._\-]'))),
                const SizedBox(height: 14),
                CustomTextfield(
                    controller: _emailCtrl,
                    text: 'Email',
                    isObscure: false,
                    color: primaryColor,
                    icon: const Icon(Icons.email_outlined),
                    onSaved: (_) {},
                    keyboard: TextInputType.emailAddress,
                    input: FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9@._\-]')),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      if (!v.contains('@')) return 'Invalid email';
                      return null;
                    }),
                const SizedBox(height: 14),
                CustomTextfield(
                    controller: _passCtrl,
                    text: 'Password',
                    isObscure: true,
                    color: primaryColor,
                    icon: const Icon(Icons.lock_outline),
                    onSaved: (_) {},
                    keyboard: TextInputType.visiblePassword,
                    input: FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    validator: RegistrationValidator.validatePassword),
                const SizedBox(height: 20),
                PersonalInfoSection(
                    ageController: _ageCtrl,
                    weightController: _weightCtrl,
                    heightController: _heightCtrl,
                    gender: _gender,
                    onGenderChanged: (v) => setState(() => _gender = v)),
              ]),
            ),
            const SizedBox(height: 20),
            const RequirementsChecklist(),
            AuthFooter(
              buttonText: isLoading ? 'Creating...' : 'Sign Up',
              questionText: 'Already have an account? ',
              linkText: 'Login',
              onButtonPressed: isLoading ? null : _register,
              onLinkPressed: isLoading
                  ? null
                  : () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const LoginPage())),
            ),
            if (isLoading) ...[
              const SizedBox(height: 16),
              CircularProgressIndicator(color: primaryColor)
            ],
          ]),
        ),
      ),
    );
  }
}
