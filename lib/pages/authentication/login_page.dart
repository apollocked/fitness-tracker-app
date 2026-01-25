import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/pages/authentication/register_page.dart';
import 'package:myapp/pages/HomePage/home_page.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isValid = false;

  void login(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    bool isLogin = false;
    for (var user in users) {
      if (user['email'] == email && user['password'] == password) {
        currentUser = user;
        isLogin = true;
        break;
      }
    }

    if (!isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Invalid email or password",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo/Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // Welcome Text
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Login to continue your fitness journey",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 40),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email Field
                      CustomTextfeild(
                        icon: const Icon(Icons.email_outlined),
                        color: Colors.blue,
                        onSaved: (value) {
                          email = value;
                        },
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

                      // Password Field

                      CustomTextfeild(
                        icon: const Icon(Icons.lock_outline),
                        color: Colors.blue,
                        onSaved: (value) {
                          password = value;
                        },
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
                      const SizedBox(height: 30),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () => login(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Sign Up Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
