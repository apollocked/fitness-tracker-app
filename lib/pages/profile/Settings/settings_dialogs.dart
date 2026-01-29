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
                updateUser(currentUser!['id'], currentUser!);
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
            onPressed: () async {
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

              // Check if email is already taken by another user
              final emailTaken = users.any((user) =>
                  user['email'].toLowerCase() ==
                      emailController.text.toLowerCase() &&
                  user['id'] != currentUser!['id']);

              if (emailTaken) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Email already taken by another user'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              try {
                currentUser!['username'] = usernameController.text;
                currentUser!['email'] = emailController.text;
                await updateUser(currentUser!['id'], currentUser!);

                Navigator.pop(dialogContext);
                onSave();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error updating profile: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  static void showDeleteAccountDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: getCardColor(),
        title: Text('Delete Account', style: TextStyle(color: getTextColor())),
        content: Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
          style: TextStyle(color: getTextColor()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (currentUser == null) {
                Navigator.pop(dialogContext);
                return;
              }

              final userId = currentUser!['id'];
              final username = currentUser!['username'];

              try {
                // Close confirmation dialog first
                Navigator.pop(dialogContext);

                // Show loading indicator
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext loadingContext) => const AlertDialog(
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16),
                        Text('Deleting account...'),
                      ],
                    ),
                  ),
                );

                // Delete the user
                await deleteUser(userId);
                currentUser = null;
                await saveCurrentUserToStorage();
                for (var i = 0; i < users.length; i++) {
                  if (users[i]['id'] == userId) {
                    users.removeAt(i);
                    break;
                  }
                }
                await saveUsersToStorage();

                // Close loading dialog
                if (context.mounted) {
                  Navigator.pop(context);
                }

                // Show success message
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Account "$username" deleted successfully'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }

                // Navigate to register page
                await Future.delayed(const Duration(milliseconds: 500));

                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                    (route) => false,
                  );
                }
              } catch (e) {
                // Close loading dialog if it's still open
                if (context.mounted) {
                  Navigator.pop(context);
                }

                // Show error message
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete account: $e'),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                    ),
                  );
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
