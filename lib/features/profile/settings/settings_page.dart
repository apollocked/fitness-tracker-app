import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/features/app/presentation/app_viewmodel.dart';
import 'package:fit_tracker/shared/widgets/custom_appbar.dart';
import 'package:fit_tracker/features/profile/settings/settings_dialogs.dart';
import 'package:fit_tracker/features/profile/settings/settings_section_widget.dart';
import 'package:fit_tracker/config/theme/app_colors.dart';
import 'package:fit_tracker/features/auth/presentation/auth_viewmodel.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  Future<void> _onDarkModeChanged(BuildContext context, bool value) async {
    final appVM = context.read<AppViewModel>();
    final authVM = context.read<AuthViewModel>();
    appVM.setDarkMode(value);
    if (authVM.currentUser != null) {
      final updated = authVM.currentUser!.copyWith(darkMode: value);
      authVM.updateUser(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appVM = context.watch<AppViewModel>();
    return Scaffold(
      appBar: customAppBarr('Settings', primaryColor,
          Theme.of(context).scaffoldBackgroundColor),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle(context, 'Account'),
            buildCardSection(context, [
              buildListTile(
                  context,
                  Icons.lock,
                  'Change Password',
                  'Update your password',
                  () => SettingsDialogs.showChangePasswordDialog(context)),
              const Divider(),
              buildListTile(
                  context,
                  Icons.edit,
                  'Edit Profile',
                  'Update your information',
                  () => SettingsDialogs.showEditProfileDialog(
                      context, () {})),
            ]),
            const SizedBox(height: 24),
            buildSectionTitle(context, 'Notifications'),
            buildCardSection(context, [
              buildSwitchTile(
                  context,
                  Icons.notifications,
                  'All Notifications',
                  'Enable/disable notifications',
                  appVM.notificationsEnabled, (value) {
                appVM.setNotifications(value);
              }),
            ]),
            const SizedBox(height: 24),
            buildSectionTitle(context, 'Appearance'),
            buildCardSection(context, [
              buildSwitchTile(
                  context,
                  Icons.dark_mode,
                  'Dark Mode',
                  'Toggle dark/light theme',
                  appVM.isDarkMode,
                  (value) => _onDarkModeChanged(context, value)),
            ]),
            const SizedBox(height: 24),
            buildSectionTitle(context, 'More'),
            buildCardSection(context, [
              buildListTile(
                  context,
                  Icons.privacy_tip,
                  'Privacy Policy',
                  'Read our privacy terms',
                  () => Navigator.pushNamed(context, '/privacy-policy')),
              const Divider(),
              buildListTile(
                  context,
                  Icons.description,
                  'Terms & Conditions',
                  'Read our terms',
                  () => Navigator.pushNamed(context, '/terms-conditions')),
              const Divider(),
              buildListTile(
                  context,
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
