import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/pages/LayoutPage/layout_page.dart';
import 'package:myapp/pages/authentication/authWidgets/auth_footer_widget.dart';
import 'package:myapp/pages/authentication/authWidgets/auth_header_widget.dart';
import 'package:myapp/pages/authentication/register_page.dart';

import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  void login(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    bool isLogin = users
        .any((user) => user['email'] == email && user['password'] == password);

    if (!isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Invalid email or password", textAlign: TextAlign.center),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    currentUser = users.firstWhere((user) => user['email'] == email);
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
                        icon: const Icon(Icons.email_outlined),
                        color: primaryColor,
                        onSaved: (value) => email = value,
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
                        icon: const Icon(Icons.lock_outline),
                        color: primaryColor,
                        onSaved: (value) => password = value,
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
                  buttonText: "Login",
                  questionText: "Don't have an account? ",
                  linkText: "Sign Up",
                  onButtonPressed: () => login(context),
                  onLinkPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
