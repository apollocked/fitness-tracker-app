import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_textfield.dart';
import 'package:fit_tracker/presentation/pages/layout_page.dart';
import 'package:fit_tracker/presentation/widgets/auth/auth_footer_widget.dart';
import 'package:fit_tracker/presentation/widgets/auth/auth_header_widget.dart';
import 'package:fit_tracker/presentation/pages/auth/register_page.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/logic/porviders/auth_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    final authVM = context.read<AuthViewModel>();
    await authVM.login(_emailCtrl.text.trim(), _passCtrl.text);
    if (!context.mounted) return;
    if (authVM.currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid email or password', textAlign: TextAlign.center),
        backgroundColor: Colors.red,
      ));
      return;
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LayoutPage()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLoading = context.watch<AuthViewModel>().isLoading;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              const AuthHeader(
                title: 'Welcome Back!',
                subtitle: 'Login to continue your fitness journey',
              ),
              Form(
                key: _formKey,
                child: Column(children: [
                  CustomTextfield(
                    controller: _emailCtrl,
                    color: primaryColor,
                    icon: const Icon(Icons.email_outlined),
                    text: 'Email',
                    isObscure: false,
                    keyboard: TextInputType.emailAddress,
                    onSaved: (_) {},
                    input: FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9@._\-]')),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Email is required';
                      if (!v.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextfield(
                    controller: _passCtrl,
                    color: primaryColor,
                    icon: const Icon(Icons.lock_outline),
                    text: 'Password',
                    isObscure: true,
                    keyboard: TextInputType.text,
                    onSaved: (_) {},
                    input: FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9@._\-]')),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Password is required';
                      if (v.length < 6) return 'Minimum 6 characters';
                      return null;
                    },
                  ),
                ]),
              ),
              AuthFooter(
                buttonText: isLoading ? 'Logging in...' : 'Login',
                questionText: "Don't have an account? ",
                linkText: 'Sign Up',
                onButtonPressed: isLoading ? null : _login,
                onLinkPressed: isLoading
                    ? null
                    : () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterPage())),
              ),
              if (isLoading) ...[
                const SizedBox(height: 16),
                CircularProgressIndicator(color: primaryColor),
              ],
            ]),
          ),
        ),
      ),
    );
  }
}
