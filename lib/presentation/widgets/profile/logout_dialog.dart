import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/pages/auth/login_page.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class LogoutDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final colors = Theme.of(context).extension<AppColorsExtension>()!;
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          backgroundColor: colors.cardColor,
          title: Text(l10n.logoutTitle, style: TextStyle(color: colors.textColor)),
          content: Text(l10n.logoutMessage,
              style: TextStyle(color: colors.textColor)),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.commonCancel)),
            TextButton(
              onPressed: () async {
                await context.read<AuthViewModel>().logout();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                }
              },
              child: Text(l10n.logoutTitle, style: TextStyle(color: redColor)),
            ),
          ],
        );
      },
    );
  }
}
