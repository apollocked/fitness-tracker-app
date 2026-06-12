import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/presentation/pages/auth/register_page.dart';
import 'package:fit_tracker/presentation/pages/layout_page.dart';
import 'package:fit_tracker/presentation/pages/onboarding_page.dart';
import 'package:fit_tracker/presentation/widgets/shared/calc_widgets.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passkeyCtrl = TextEditingController();

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passkeyCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    await context.read<AuthViewModel>().login(
      _usernameCtrl.text.trim(),
      _passkeyCtrl.text.trim(),
    );
    if (context.mounted && context.read<AuthViewModel>().currentUser != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LayoutPage()),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();
    final theme = Theme.of(context);
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.fitness_center_rounded,
                        size: 56, color: primaryColor),
                  ),
                  const SizedBox(height: 24),
                  Text('Welcome Back',
                      style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textColor)),
                  const SizedBox(height: 8),
                  Text('Enter your details to continue',
                      style: TextStyle(color: colors.subtitleColor)),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _usernameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    textCapitalization: TextCapitalization.none,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passkeyCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Passkey (4 digits)',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 4,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Enter your passkey';
                      }
                      if (v.trim().length != 4) return 'Must be 4 digits';
                      if (int.tryParse(v.trim()) == null) return 'Digits only';
                      return null;
                    },
                  ),
                  if (authVM.error != null) ...[
                    const SizedBox(height: 12),
                    Text(authVM.error!,
                        style: const TextStyle(color: redColor, fontSize: 13)),
                  ],
                  const SizedBox(height: 24),
                  CalcButton(
                    label: 'Login',
                    color: primaryColor,
                    onPressed: _login,
                    isLoading: authVM.isLoading,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                            color: theme.dividerColor.withOpacity(0.4)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('or',
                            style: TextStyle(
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.4))),
                      ),
                      Expanded(
                        child: Divider(
                            color: theme.dividerColor.withOpacity(0.4)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    icon: const Icon(Icons.person_add_outlined),
                    label: const Text('Create New Account'),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RegisterPage()),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    icon: const Icon(Icons.explore_outlined),
                    label: const Text('Continue as Guest'),
                    onPressed: () async {
                      await context
                          .read<AuthViewModel>()
                          .loginAsGuest();
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LayoutPage()),
                          (_) => false,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const OnboardingPage()),
                    ),
                    child: Text('View Onboarding',
                        style: TextStyle(
                            color: colors.subtitleColor)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
