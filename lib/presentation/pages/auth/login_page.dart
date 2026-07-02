import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/presentation/pages/auth/register_page.dart';
import 'package:fit_tracker/presentation/pages/layout_page.dart';
import 'package:fit_tracker/presentation/pages/onboarding_page.dart';
import 'package:fit_tracker/presentation/widgets/shared/calc_widgets.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passkeyCtrl = TextEditingController();
  bool _obscurePasskey = true;

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
    final l10n = AppLocalizations.of(context)!;
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
                  Text(l10n.authLoginTitle,
                      style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textColor)),
                  const SizedBox(height: 8),
                  Text(l10n.authLoginDesc,
                      style: TextStyle(color: colors.subtitleColor)),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _usernameCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.profileUsername,
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                    textCapitalization: TextCapitalization.none,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return l10n.validatorUsernameRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passkeyCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.validatorPasskeyRequired,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePasskey
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: () =>
                            setState(() => _obscurePasskey = !_obscurePasskey),
                      ),
                    ),
                    obscureText: _obscurePasskey,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return l10n.validatorPasskeyRequired;
                      }
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
                    label: l10n.commonContinue,
                    color: primaryColor,
                    onPressed: _login,
                    isLoading: authVM.isLoading,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child:
                            Divider(color: theme.dividerColor.withOpacity(0.4)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('or',
                            style: TextStyle(
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.4))),
                      ),
                      Expanded(
                        child:
                            Divider(color: theme.dividerColor.withOpacity(0.4)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    icon: const Icon(Icons.person_add_outlined),
                    label: Text(l10n.guestLoginTitle),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    icon: const Icon(Icons.explore_outlined),
                    label: Text(l10n.guestLoginButton),
                    onPressed: () async {
                      await context.read<AuthViewModel>().loginAsGuest();
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LayoutPage()),
                          (_) => false,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OnboardingPage()),
                    ),
                    child: Text('View Onboarding',
                        style: TextStyle(color: colors.subtitleColor)),
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
