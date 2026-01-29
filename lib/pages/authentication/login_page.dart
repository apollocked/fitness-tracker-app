import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/pages/LayoutPage/layout_page.dart';
import 'package:myapp/pages/authentication/authWidgets/auth_footer_widget.dart';
import 'package:myapp/pages/authentication/authWidgets/auth_header_widget.dart';
import 'package:myapp/pages/authentication/register_page.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart'; // Updated import

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize data
    _initData();
  }

  Future<void> _initData() async {
    await initUserData(); // Initialize from storage
  }

  Future<void> login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Find user in storage
    final user = findUser(email, password);

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Invalid email or password", textAlign: TextAlign.center),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    // Login user
    await loginUser(user);

    setState(() => _isLoading = false);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LayoutPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
                      CustomTextfeild(
                        controller: _emailController,
                        icon: const Icon(Icons.email_outlined),
                        color: primaryColor,
                        onSaved: (value) {},
                        text: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          if (!value.contains('@')) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                        isObscure: false,
                        keyboard: TextInputType.emailAddress,
                        input: FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@._\-]')),
                      ),
                      const SizedBox(height: 16),
                      CustomTextfeild(
                        controller: _passwordController,
                        icon: const Icon(Icons.lock_outline),
                        color: primaryColor,
                        onSaved: (value) {},
                        text: "Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
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
                  buttonText: _isLoading ? "Logging in..." : "Login",
                  questionText: "Don't have an account? ",
                  linkText: "Sign Up",
                  onButtonPressed:
                      _isLoading ? null : () => login(context), // Now nullable
                  onLinkPressed: _isLoading
                      ? null
                      : () => Navigator.pushReplacement(
                            // Now nullable
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          ),
                ),
                if (_isLoading)
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
