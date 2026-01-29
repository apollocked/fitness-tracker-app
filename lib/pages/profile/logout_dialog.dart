import 'package:flutter/material.dart';
import 'package:myapp/pages/authentication/login_page.dart';
import 'package:myapp/utils/dark_mode_helper.dart';
import 'package:myapp/utils/user_data.dart'; // Updated

class LogoutDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: getCardColor(),
          title: Text('Logout', style: TextStyle(color: getTextColor())),
          content: Text('Are you sure you want to logout?',
              style: TextStyle(color: getTextColor())),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Clear current user
                await logoutUser();

                // Navigate to login page
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
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
