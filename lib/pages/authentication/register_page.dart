import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/Custom_Widgets/select_gender_radio.dart';
import 'package:myapp/pages/authentication/login_page.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username;
  String? email;
  String? password;
  String? age;
  String? weight;
  String? height;
  String gender = "Male";
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  void register(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    // Check if email already exists
    bool emailExists = users.any((user) => user['email'] == email);
    if (emailExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("This email is already registered"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create new user
    final newUser = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "username": username,
      "email": email,
      "password": password,
      "age": int.tryParse(age ?? "0"),
      "weight": double.tryParse(weight ?? "0"),
      "height": double.tryParse(height ?? "0"),
      "gender": gender,
      "createdAt": DateTime.now().toIso8601String(),
      "isBodybuilder": false,
      "caloriesGoal": 2000,
    };

    users.add(newUser);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Account created successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
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
                Text(
                  "Welcome!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 2),
                Text(
                  "Start your fitness journey today",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Username
                      CustomTextfeild(
                        text: "Username",
                        isObscure: false,
                        color: primaryColor,
                        icon: const Icon(Icons.person_outline),
                        onSaved: (value) => username = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username is required";
                          }
                          return null;
                        },
                        keyboard: TextInputType.text,
                        input: FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9._\-]')),
                      ),
                      const SizedBox(height: 16),

                      // Email
                      CustomTextfeild(
                        icon: const Icon(Icons.email_outlined),
                        color: primaryColor,
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

                      // Password
                      CustomTextfeild(
                        icon: const Icon(Icons.lock_outline),
                        color: primaryColor,
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
                        keyboard: TextInputType.visiblePassword,
                        input: FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ),
                      const SizedBox(height: 24),

                      // Personal Info Section
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Age, Weight, Height Row
                      Row(
                        children: [
                          Expanded(
                            child: // Age Input
                                CustomTextfeild(
                              controller: _ageController,
                              isObscure: false,
                              keyboard: TextInputType.number,
                              icon: const Icon(Icons.cake),
                              color: redColor,
                              onSaved: (value) {},
                              text: 'Age (years)',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your age';
                                }
                                if (int.tryParse(value) == null) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                              input: FilteringTextInputFormatter.digitsOnly,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child:

                                // Weight Input
                                CustomTextfeild(
                              controller: _weightController,
                              isObscure: false,
                              keyboard: TextInputType.number,
                              icon: const Icon(Icons.monitor_weight),
                              color: redColor,
                              onSaved: (value) {},
                              text: 'Weight (kg)',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your weight';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                              input: FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*')),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextfeild(
                              controller: _heightController,
                              isObscure: false,
                              keyboard: TextInputType.number,
                              icon: const Icon(Icons.height),
                              color: redColor,
                              text: 'Height (cm)',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your height';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                              onSaved: (value) {},
                              input: FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*')),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextfeild(
                          text: "Height (cm)",
                          isObscure: false,
                          color: primaryColor,
                          icon: const Icon(Icons.height_outlined),
                          onSaved: (value) => height = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Height is required";
                            }
                            if (double.tryParse(value) == null ||
                                double.parse(value) <= 0) {
                              return "Enter a valid height";
                            }
                            return null;
                          },
                          keyboard: TextInputType.number,
                          input: FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'))),
                      const SizedBox(height: 16),

                      // Gender Selection
                      const Text(
                        "Gender",
                        style: TextStyle(fontSize: 14),
                      ),

                      SizedBox(
                        child: CustomGenderRatio(
                          color: primaryColor,
                          initialGender: "Male",
                          onGenderChanged: (value) {
                            gender = value;
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () => register(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
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
