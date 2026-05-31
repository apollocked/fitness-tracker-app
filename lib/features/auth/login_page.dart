import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tracker/widgets/custom_textfield.dart';
import 'package:fit_tracker/features/navigation/layout_page.dart';
import 'package:fit_tracker/features/auth/widgets/auth_footer_widget.dart';
import 'package:fit_tracker/features/auth/widgets/auth_header_widget.dart';
import 'package:fit_tracker/features/auth/register_page.dart';
import 'package:fit_tracker/core/theme/colors.dart';
import 'package:fit_tracker/app/cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    await context.read<AuthCubit>().login(email, password);
    if (!context.mounted) return;
    final state = context.read<AuthCubit>().state;
    if (state.user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Invalid email or password", textAlign: TextAlign.center),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (context.mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LayoutPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLoading = context.watch<AuthCubit>().state.isLoading;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthHeader(
                    title: "Welcome Back!",
                    subtitle: "Login to continue your fitness journey"),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        controller: _emailController,
                        icon: const Icon(Icons.email_outlined),
                        color: primaryColor,
                        onSaved: (value) {},
                        text: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Email is required";
                          if (!value.contains('@'))
                            return "Enter a valid email";
                          return null;
                        },
                        isObscure: false,
                        keyboard: TextInputType.emailAddress,
                        input: FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@._\-]')),
                      ),
                      const SizedBox(height: 16),
                      CustomTextfield(
                        controller: _passwordController,
                        icon: const Icon(Icons.lock_outline),
                        color: primaryColor,
                        onSaved: (value) {},
                        text: "Password",
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Password is required";
                          if (value.length < 6)
                            return "Password must be at least 6 characters";
                          return null;
                        },
                        isObscure: true,
                        keyboard: TextInputType.text,
                        input: FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@._\-]')),
                      ),
                    ],
                  ),
                ),
                AuthFooter(
                  buttonText: isLoading ? "Logging in..." : "Login",
                  questionText: "Don't have an account? ",
                  linkText: "Sign Up",
                  onButtonPressed: isLoading ? null : () => login(context),
                  onLinkPressed: isLoading
                      ? null
                      : () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          ),
                ),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

