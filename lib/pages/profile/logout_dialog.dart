import 'package:flutter/material.dart';
import 'package:myapp/pages/authentication/login_page.dart';
import 'package:myapp/utils/app_theme.dart';
import 'package:myapp/utils/user_data.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class LogoutDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final colors = Theme.of(context).extension<AppColorsExtension>()!;
        return AlertDialog(
          backgroundColor: colors.cardColor,
          title: Text('Logout', style: TextStyle(color: colors.textColor)),
          content: Text('Are you sure you want to logout?',
              style: TextStyle(color: colors.textColor)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Clear current user
                await logoutUser();

                // Sync theme (reset to default)
                if (context.mounted) {
                  context.read<ThemeProvider>().syncWithCurrentUser();
                }

                // Navigate to login page
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                }
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
