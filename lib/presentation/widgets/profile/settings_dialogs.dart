import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_dialog_text_field.dart';
import 'package:fit_tracker/presentation/pages/auth/register_page.dart';
import 'package:fit_tracker/data/services/storage_service.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';

class SettingsDialogs {
  static void showChangePasswordDialog(BuildContext context) {
    if (context.read<AuthViewModel>().currentUser == null) return;
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: colors.cardColor,
        title:
            Text('Change Password', style: TextStyle(color: colors.textColor)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDialogTextField(
                controller: oldPasswordController,
                text: 'Old Password',
                isPassword: true),
            const SizedBox(height: 12),
            CustomDialogTextField(
                controller: newPasswordController,
                text: 'New Password',
                isPassword: true),
            const SizedBox(height: 12),
            CustomDialogTextField(
                controller: confirmPasswordController,
                text: 'Confirm Password',
                isPassword: true),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              if (newPasswordController.text !=
                  confirmPasswordController.text) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Passwords do not match'),
                    backgroundColor: redColor));
                return;
              }
              final appVM = dialogContext.read<AppViewModel>();
              final success = await appVM.changePassword(
                  oldPasswordController.text, newPasswordController.text);
              if (success) await context.read<AuthViewModel>().reloadUser();
              if (success) Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      appVM.successMessage ?? appVM.settingsError ?? 'Done'),
                  backgroundColor:
                      appVM.successMessage != null ? Colors.green : Colors.red,
                ),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  static void showEditProfileDialog(BuildContext context, Function onSave) {
    final user = context.read<AuthViewModel>().currentUser;
    if (user == null) return;
    final usernameController = TextEditingController(text: user.username);
    final emailController = TextEditingController(text: user.email);
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: colors.cardColor,
        title: Text('Edit Profile', style: TextStyle(color: colors.textColor)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDialogTextField(
                controller: usernameController, text: 'Username'),
            const SizedBox(height: 12),
            CustomDialogTextField(controller: emailController, text: 'Email'),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              if (usernameController.text.isEmpty ||
                  emailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please fill all fields'),
                    backgroundColor: redColor));
                return;
              }
              final appVM = dialogContext.read<AppViewModel>();
              final success = await appVM.updateProfile(
                  usernameController.text, emailController.text);
              if (success) {
                await context.read<AuthViewModel>().reloadUser();
                onSave();
                Navigator.pop(dialogContext);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      appVM.successMessage ?? appVM.settingsError ?? 'Done'),
                  backgroundColor:
                      appVM.successMessage != null ? Colors.green : Colors.red,
                ),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  static void showDeleteAccountDialog(BuildContext context) async {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: colors.cardColor,
        title:
            Text('Delete Account', style: TextStyle(color: colors.textColor)),
        content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: TextStyle(color: colors.textColor)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              if (context.read<AuthViewModel>().currentUser == null) {
                Navigator.pop(dialogContext);
                return;
              }
              try {
                Navigator.pop(dialogContext);
                await context.read<AuthViewModel>().deleteAccount();
                await StorageService.clearAll();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Account deleted successfully'),
                      backgroundColor: greenColor,
                      duration: Duration(seconds: 3)));
                }
                await Future.delayed(const Duration(milliseconds: 1000));
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                      (route) => false);
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to delete account: $e'),
                      backgroundColor: redColor,
                      duration: const Duration(seconds: 3)));
                }
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  static void showInfoDialog(
      BuildContext context, String title, String content) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: colors.cardColor,
        title: Text(title, style: TextStyle(color: colors.textColor)),
        content: Text(content, style: TextStyle(color: colors.textColor)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'))
        ],
      ),
    );
  }
}
