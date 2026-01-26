import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/pages/authentication/authWidgets/auth_footer_widget.dart';
import 'package:myapp/pages/authentication/authWidgets/auth_header_widget.dart';
import 'package:myapp/pages/authentication/authWidgets/personal_info_section.dart';
import 'package:myapp/pages/authentication/login_page.dart';

import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String? username, email, password;
  String gender = "Male";
  bool _isLoading = false;

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    // Prevent multiple submissions
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState!.save();

    // Case-insensitive email check
    if (users.any((user) =>
        user['email'].toString().toLowerCase() == email!.toLowerCase())) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Email already registered"),
            backgroundColor: Colors.red),
      );
      return;
    }

    final newUser = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "username": username,
      "email": email?.toLowerCase(),
      "password": password,
      "age": int.tryParse(_ageController.text) ?? 0,
      "weight": double.tryParse(_weightController.text) ?? 0.0,
      "height": double.tryParse(_heightController.text) ?? 0.0,
      "gender": gender,
      "waist": 0.0,
      "createdAt": DateTime.now().toIso8601String(),
      "isBodybuilder": false,
      "caloriesGoal": 2000,
    };

    users.add(newUser);
    currentUser = newUser;

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text("Account created successfully!"),
          backgroundColor: Colors.green),
    );

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
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
                    title: "Welcome!",
                    subtitle: "Start your fitness journey today"),
                const Text("Create Account",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextfeild(
                        text: "Username",
                        isObscure: false,
                        color: primaryColor,
                        icon: const Icon(Icons.person_outline),
                        onSaved: (value) => username = value?.trim(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username required";
                          }
                          if (value.trim().length < 3) {
                            return "Username must be at least 3 characters";
                          }
                          return null;
                        },
                        keyboard: TextInputType.text,
                        input: FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9._\-]')),
                      ),
                      const SizedBox(height: 16),
                      CustomTextfeild(
                        icon: const Icon(Icons.email_outlined),
                        color: primaryColor,
                        onSaved: (value) => email = value?.trim(),
                        text: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email required";
                          }
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return "Enter valid email";
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
                            return "Password required";
                          }
                          if (value.length < 6) return "Min 6 characters";
                          return null;
                        },
                        isObscure: true,
                        keyboard: TextInputType.visiblePassword,
                        input: FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ),
                      const SizedBox(height: 24),
                      PersonalInfoSection(
                        ageController: _ageController,
                        weightController: _weightController,
                        heightController: _heightController,
                        gender: gender,
                        onGenderChanged: (value) =>
                            setState(() => gender = value),
                      ),
                    ],
                  ),
                ),
                AuthFooter(
                  buttonText: _isLoading ? "Creating Account..." : "Sign Up",
                  questionText: "Already have an account? ",
                  linkText: "Login",
                  onButtonPressed: () {
                    if (!_isLoading) register(context);
                  },
                  onLinkPressed: () {
                    if (!_isLoading) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }
                  },
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
}
