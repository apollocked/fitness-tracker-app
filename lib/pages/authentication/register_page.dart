import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/pages/authentication/authWidgets/auth_footer_widget.dart';
import 'package:myapp/pages/authentication/authWidgets/auth_header_widget.dart';
import 'package:myapp/pages/authentication/authWidgets/personal_info_section.dart';
import 'package:myapp/pages/authentication/login_page.dart';
import 'package:myapp/services/registration_validator.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';
import 'package:myapp/utils/app_theme.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String gender = "Male";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize user data
    initUserData();
  }

  Future<void> register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    // Validate all fields using validator service
    if (!RegistrationValidator.validateAll(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      age: _ageController.text,
      weight: _weightController.text,
      height: _heightController.text,
      gender: gender,
    )) {
      _showError("Please fill all fields correctly");
      return;
    }

    // Check if email already exists (from storage)
    if (emailExists(_emailController.text.trim())) {
      _showError("Email already registered");
      return;
    }

    setState(() => _isLoading = true);

    final newUser = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "username": _usernameController.text.trim(),
      "email": _emailController.text.toLowerCase().trim(),
      "password": _passwordController.text,
      "age": int.tryParse(_ageController.text) ?? 0,
      "weight": double.tryParse(_weightController.text) ?? 0.0,
      "height": double.tryParse(_heightController.text) ?? 0.0,
      "gender": gender,
      "isBodybuilder": false,
      "createdAt": DateTime.now().toIso8601String(),
      "darkMode": false,
      "goals": {
        'weight': {
          'target': 0.0,
          'current': double.tryParse(_weightController.text) ?? 0.0,
          'unit': 'kg',
          'active': false,
          'goalType': 'maintain'
        },
        'protein': {'target': 0, 'unit': 'g', 'active': false},
        'calories': {'target': 0, 'unit': 'cal', 'active': false},
      },
    };

    // Save to storage
    await addUser(newUser);

    // Auto login
    await loginUser(newUser);

    // Sync theme with new user preferences (default to false initially in registration)
    if (context.mounted) {
      context.read<ThemeProvider>().syncWithCurrentUser();
    }

    setState(() => _isLoading = false);

    _showSuccess("Account created successfully!");
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  void _showError(String message) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );

  void _showSuccess(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const AuthHeader(
                    title: "Welcome!",
                    subtitle: "Start your fitness journey today"),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colors.textColor),
                  ),
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Username field
                      CustomTextfeild(
                        controller: _usernameController,
                        text: "Username",
                        isObscure: false,
                        color: primaryColor,
                        icon: const Icon(Icons.person_outline),
                        onSaved: (value) {},
                        validator: RegistrationValidator.validateUsername,
                        keyboard: TextInputType.text,
                        input: FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9._\-]')),
                      ),

                      const SizedBox(height: 16),

                      // Email field
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
                          if (emailExists(value.trim())) {
                            return "Email already registered";
                          }
                          return null;
                        },
                        isObscure: false,
                        keyboard: TextInputType.emailAddress,
                        input: FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@._\-]')),
                      ),

                      const SizedBox(height: 16),

                      // Password field
                      CustomTextfeild(
                        controller: _passwordController,
                        icon: const Icon(Icons.lock_outline),
                        color: primaryColor,
                        onSaved: (value) {},
                        text: "Password",
                        validator: RegistrationValidator.validatePassword,
                        isObscure: true,
                        keyboard: TextInputType.visiblePassword,
                        input: FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ),

                      const SizedBox(height: 24),

                      // Personal Info Section
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
                const SizedBox(height: 24),
                _buildRequirementsChecklist(context, colors),
                const SizedBox(height: 24),
                AuthFooter(
                  buttonText: _isLoading ? "Creating Account..." : "Sign Up",
                  questionText: "Already have an account? ",
                  linkText: "Login",
                  onButtonPressed: _isLoading ? null : () => register(context),
                  onLinkPressed: _isLoading
                      ? null
                      : () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
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

  Widget _buildRequirementsChecklist(BuildContext context, AppColorsExtension colors) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? colors.cardColor : Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? colors.subtitleColor : Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Requirements:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDark ? colors.textColor : Colors.blue[900],
            ),
          ),
          const SizedBox(height: 12),
          _buildRequirementItem(context, colors, 'Username (minimum 3 characters)'),
          _buildRequirementItem(context, colors, 'Valid email address'),
          _buildRequirementItem(context, colors, 'Password (minimum 6 characters)'),
          _buildRequirementItem(context, colors, 'Age (older than 12 years)'),
          _buildRequirementItem(context, colors, 'Weight (in kg)'),
          _buildRequirementItem(context, colors, 'Height (in cm)'),
          _buildRequirementItem(context, colors, 'Gender selection'),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(BuildContext context, AppColorsExtension colors, String requirement) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: 18, color: isDark ? colors.textColor : Colors.blue[700]),
          const SizedBox(width: 8),
          Text(
            requirement,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? colors.subtitleColor : Colors.blue[900],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
