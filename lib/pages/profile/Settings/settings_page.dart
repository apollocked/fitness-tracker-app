import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/pages/Profile/Settings/settings_dialogs.dart';
import 'package:myapp/pages/Profile/Settings/settings_section_widget.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';
import 'package:myapp/utils/user_data.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback onThemeChanged;

  const SettingsPage({super.key, required this.onThemeChanged});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeValue = false;

  @override
  void initState() {
    super.initState();
    // Initialize with current theme value
    _darkModeValue = currentUser!['darkMode'] ?? false;
  }

  void _updateDarkMode(bool value) {
    setState(() {
      _darkModeValue = value;
    });

    // Update user data
    currentUser!['darkMode'] = value;
    final userIndex =
        users.indexWhere((user) => user['id'] == currentUser!['id']);
    if (userIndex != -1) {
      users[userIndex]['darkMode'] = value;
    }

    // Notify theme change
    widget.onThemeChanged();
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
              buildSwitchTile(Icons.dark_mode, 'Dark Mode',
                  'Toggle dark/light theme', _darkModeValue, _updateDarkMode),
            ]),
            const SizedBox(height: 24),
            buildSectionTitle('More'),
            buildCardSection([
              buildListTile(
                Icons.privacy_tip,
                'Privacy Policy',
                'Read our privacy terms',
                () => Navigator.pushNamed(context, '/privacy-policy'),
              ),
              const Divider(),
              buildListTile(
                Icons.description,
                'Terms & Conditions',
                'Read our terms',
                () => Navigator.pushNamed(context, '/terms-conditions'),
              ),
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
