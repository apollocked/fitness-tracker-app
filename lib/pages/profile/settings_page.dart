import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/pages/Profile/settings_dialogs.dart';
import 'package:myapp/pages/Profile/settings_section_widget.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';
import 'package:myapp/utils/user_data.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    if (currentUser != null && currentUser!['darkMode'] != null) {
      // Dark mode will be applied at app level
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr('Settings', primaryColor, getBackgroundColor()),
      backgroundColor: getBackgroundColor(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle('Account'),
            buildCardSection([
              buildListTile(
                  Icons.lock,
                  'Change Password',
                  'Update your password',
                  () => SettingsDialogs.showChangePasswordDialog(context)),
              const Divider(),
              buildListTile(
                  Icons.edit,
                  'Edit Profile',
                  'Update your information',
                  () => SettingsDialogs.showEditProfileDialog(
                      context, () => setState(() {}))),
            ]),
            const SizedBox(height: 24),
            buildSectionTitle('Notifications'),
            buildCardSection([
              buildSwitchTile(
                  Icons.notifications,
                  'All Notifications',
                  'Enable/disable notifications',
                  _notificationsEnabled,
                  (value) => setState(() => _notificationsEnabled = value)),
            ]),
            const SizedBox(height: 24),
            buildSectionTitle('Appearance'),
            buildCardSection([
              buildSwitchTile(
                  Icons.dark_mode,
                  'Dark Mode',
                  'Toggle dark/light theme',
                  currentUser!['darkMode'] ?? false, (value) {
                setState(() {
                  currentUser!['darkMode'] = value;
                  // Update in users list
                  final userIndex = users
                      .indexWhere((user) => user['id'] == currentUser!['id']);
                  if (userIndex != -1) {
                    users[userIndex]['darkMode'] = value;
                  }
                });
                // Rebuild the entire app to apply theme change
                Future.delayed(const Duration(milliseconds: 100), () {
                  if (mounted) {
                    setState(() {});
                  }
                });
              }),
            ]),
            const SizedBox(height: 24),
            buildSectionTitle('More'),
            buildCardSection([
              buildListTile(
                  Icons.privacy_tip,
                  'Privacy Policy',
                  'Read our privacy terms',
                  () => SettingsDialogs.showInfoDialog(
                      context, 'Privacy Policy', 'Your data is safe with us.')),
              const Divider(),
              buildListTile(
                  Icons.description,
                  'Terms & Conditions',
                  'Read our terms',
                  () => SettingsDialogs.showInfoDialog(
                      context,
                      'Terms & Conditions',
                      'By using this app, you agree to our terms.')),
              const Divider(),
              buildListTile(
                  Icons.delete_forever,
                  'Delete Account',
                  'Permanently delete your account',
                  () => SettingsDialogs.showDeleteAccountDialog(context),
                  isDanger: true),
            ]),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
