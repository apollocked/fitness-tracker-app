import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/data/model/user_model.dart';
import 'package:fit_tracker/data/services/registration_validator.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/calc_widgets.dart';
import 'package:fit_tracker/presentation/pages/layout_page.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passkeyCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  String _selectedGender = 'Male';
  bool _obscurePasskey = true;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passkeyCtrl.dispose();
    _ageCtrl.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    final authVM = context.read<AuthViewModel>();
    final username = _usernameCtrl.text.trim();
    if (authVM.usernameExists(username)) {
      _snack('Username already taken', redColor);
      return;
    }
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: username,
      passkey: _passkeyCtrl.text.trim(),
      age: int.parse(_ageCtrl.text.trim()),
      weight: double.parse(_weightCtrl.text.trim()),
      height: double.parse(_heightCtrl.text.trim()),
      gender: _selectedGender,
    );
    await authVM.register(user);
    if (authVM.currentUser != null && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LayoutPage()),
        (_) => false,
      );
    }
  }

  void _snack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthViewModel>().isLoading;
    final theme = Theme.of(context);
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final l10n = AppLocalizations.of(context)!;
    final validator = RegistrationValidator(l10n);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: customAppBarr(l10n.authRegisterTitle, primaryColor, theme.scaffoldBackgroundColor),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(children: [
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person_add_outlined,
                  size: 48, color: primaryColor),
            ),
            const SizedBox(height: 24),
            Text(l10n.authCreateAccount,
                style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold, color: colors.textColor)),
            const SizedBox(height: 24),
            TextFormField(
              controller: _usernameCtrl,
              decoration: InputDecoration(
                labelText: l10n.profileUsername,
                prefixIcon: const Icon(Icons.person_outline),
              ),
              textCapitalization: TextCapitalization.none,
              validator: (v) => validator.validateUsername(v),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passkeyCtrl,
              decoration: InputDecoration(
                labelText: l10n.validatorPasskeyRequired,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePasskey ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                  onPressed: () => setState(() => _obscurePasskey = !_obscurePasskey),
                ),
              ),
              obscureText: _obscurePasskey,
              validator: (v) => validator.validatePasskey(v),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ageCtrl,
              decoration: InputDecoration(
                labelText: l10n.bodyStatsAge,
                prefixIcon: const Icon(Icons.numbers),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) => validator.validateAge(v),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _weightCtrl,
              decoration: InputDecoration(
                labelText: '${l10n.bodyStatsWeight} (${l10n.bodyStatsKg})',
                prefixIcon: const Icon(Icons.monitor_weight_outlined),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
              ],
              validator: (v) => validator.validateWeight(v),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _heightCtrl,
              decoration: InputDecoration(
                labelText: '${l10n.bodyStatsHeight} (${l10n.bodyStatsCm})',
                prefixIcon: const Icon(Icons.height),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
              ],
              validator: (v) => validator.validateHeight(v),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: InputDecoration(
                labelText: l10n.bodyStatsGender,
                prefixIcon: const Icon(Icons.wc),
              ),
              items: [
                DropdownMenuItem(value: 'Male', child: Text(l10n.bodyStatsMale)),
                DropdownMenuItem(value: 'Female', child: Text(l10n.bodyStatsFemale)),
              ],
              onChanged: (v) => setState(() => _selectedGender = v!),
            ),
            const SizedBox(height: 32),
            CalcButton(
              label: l10n.authCreateAccount,
              color: primaryColor,
              onPressed: _register,
              isLoading: isLoading,
            ),
            const SizedBox(height: 24),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('${l10n.authAlreadyHaveAccount} ',
                  style: TextStyle(color: colors.subtitleColor)),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.authLogin,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
