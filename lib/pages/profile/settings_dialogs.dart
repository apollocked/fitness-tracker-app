import 'package:flutter/material.dart';
import 'package:myapp/pages/authentication/register_page.dart';
import 'package:myapp/utils/dark_mode_helper.dart';
import 'package:myapp/utils/user_data.dart';

class SettingsDialogs {
  static void showChangePasswordDialog(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: getCardColor(),
        title: Text('Change Password', style: TextStyle(color: getTextColor())),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPasswordController,
              obscureText: true,
              style: TextStyle(color: getTextColor()),
              decoration: InputDecoration(
                labelText: 'Old Password',
                labelStyle: TextStyle(color: getSubtitleColor()),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: getBackgroundColor(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              style: TextStyle(color: getTextColor()),
              decoration: InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyle(color: getSubtitleColor()),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: getBackgroundColor(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              style: TextStyle(color: getTextColor()),
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: TextStyle(color: getSubtitleColor()),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: getBackgroundColor(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (oldPasswordController.text != currentUser!['password']) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Old password is incorrect'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              if (newPasswordController.text ==
                  confirmPasswordController.text) {
                currentUser!['password'] = newPasswordController.text;
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password changed successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Passwords do not match'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  static void showEditProfileDialog(BuildContext context, Function onSave) {
    final usernameController =
        TextEditingController(text: currentUser?['username']);
    final emailController = TextEditingController(text: currentUser?['email']);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: getCardColor(),
        title: Text('Edit Profile', style: TextStyle(color: getTextColor())),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              style: TextStyle(color: getTextColor()),
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: getSubtitleColor()),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: getBackgroundColor(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              style: TextStyle(color: getTextColor()),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: getSubtitleColor()),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: getBackgroundColor(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(emailController.text)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Enter valid email'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              currentUser!['username'] = usernameController.text;
              currentUser!['email'] = emailController.text;

              final userIndex =
                  users.indexWhere((user) => user['id'] == currentUser!['id']);
              if (userIndex != -1) {
                users[userIndex]['username'] = usernameController.text;
                users[userIndex]['email'] = emailController.text;
              }

              Navigator.pop(dialogContext);
              onSave();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  static void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: getCardColor(),
        title: Text('Delete Account', style: TextStyle(color: getTextColor())),
        content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: TextStyle(color: getTextColor())),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              users.removeWhere(
                  (user) => user['email'] == currentUser!['email']);
              currentUser = null;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
                (route) => false,
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  static void showInfoDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: getCardColor(),
        title: Text(title, style: TextStyle(color: getTextColor())),
        content: Text(content, style: TextStyle(color: getTextColor())),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
