import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_dialog_text_field.dart';
import 'package:fit_tracker/presentation/pages/auth/register_page.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class SettingsDialogs {
  static void showEditProfileDialog(BuildContext context, Function onSave) {
    final user = context.read<AuthViewModel>().currentUser;
    if (user == null) return;
    final usernameController = TextEditingController(text: user.username);
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: colors.cardColor,
        title: Text(l10n.settingsEditProfile, style: TextStyle(color: colors.textColor)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDialogTextField(
                controller: usernameController, text: l10n.profileUsername),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.commonCancel)),
          TextButton(
            onPressed: () async {
              if (usernameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please fill all fields'),
                    backgroundColor: redColor));
                return;
              }
              final appVM = dialogContext.read<AppViewModel>();
              final success = await appVM.updateProfile(
                  usernameController.text, l10n);
              if (success) {
                await context.read<AuthViewModel>().reloadUser();
                onSave();
                Navigator.pop(dialogContext);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      appVM.successMessage ?? appVM.settingsError ?? l10n.commonDone),
                  backgroundColor:
                      appVM.successMessage != null ? greenColor : redColor,
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
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: colors.cardColor,
        title:
            Text(l10n.settingsDeleteAccount, style: TextStyle(color: colors.textColor)),
        content: Text(
            '${l10n.settingsDeleteAccountConfirm}\n${l10n.settingsDeleteAccountWarning}',
            style: TextStyle(color: colors.textColor)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.commonCancel)),
          TextButton(
            onPressed: () async {
              if (context.read<AuthViewModel>().currentUser == null) {
                Navigator.pop(dialogContext);
                return;
              }
              try {
                Navigator.pop(dialogContext);
                await context.read<AuthViewModel>().deleteAccount();
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
            child: Text(l10n.commonDelete, style: TextStyle(color: redColor)),
          ),
        ],
      ),
    );
  }
}
