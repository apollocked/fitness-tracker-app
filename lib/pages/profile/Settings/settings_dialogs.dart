// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_dialog_text_field.dart';
import 'package:myapp/pages/authentication/register_page.dart';
import 'package:myapp/services/storage_service.dart';
import 'package:myapp/utils/app_theme.dart';
import 'package:myapp/utils/user_data.dart';

class SettingsDialogs {
  static void showChangePasswordDialog(BuildContext context) {
    if (currentUser == null) return;
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
              isPassword: true,
            ),
            const SizedBox(height: 12),
            CustomDialogTextField(
              controller: newPasswordController,
              text: 'New Password',
              isPassword: true,
            ),
            const SizedBox(height: 12),
            CustomDialogTextField(
              controller: confirmPasswordController,
              text: 'Confirm Password',
              isPassword: true,
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
    if (currentUser == null) return;

    final usernameController =
        TextEditingController(text: currentUser!['username']);
    final emailController = TextEditingController(text: currentUser!['email']);
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
              controller: usernameController,
              text: 'Username',
            ),
            const SizedBox(height: 12),
            CustomDialogTextField(
              controller: emailController,
              text: 'Email',
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
              if (usernameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty) {
                currentUser!['username'] = usernameController.text;
                currentUser!['email'] = emailController.text;
                updateUser(currentUser!['id'], currentUser!);
                onSave();
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all fields'),
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
          style: TextStyle(color: colors.textColor),
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
              final email = currentUser!['email'];

              print('Attempting to delete account:');
              print('User ID: $userId');
              print('Username: $username');
              print('Email: $email');
              print('Current users before deletion: ${users.length}');

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

                // Verify deletion
                print('Current users after deletion: ${users.length}');
                print(
                    'User still exists? ${users.any((user) => user['id'] == userId)}');

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

                await StorageService.clearAll();

                // Reload users from storage to verify
                await initUserData();
                print('Reloaded users after deletion: ${users.length}');

                // Navigate to register page
                await Future.delayed(const Duration(milliseconds: 1000));

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
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
