// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:myapp/providers/loading_proveder.dart';
import 'package:provider/provider.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/pages/Profile/Settings/settings_dialogs.dart';
import 'package:myapp/pages/Profile/Settings/settings_section_widget.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:myapp/providers/notification_provider.dart';
import 'package:myapp/utils/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _onDarkModeChanged(BuildContext context, bool value) async {
    context.read<LoadingProvider>().setLoading(true);
    await context.read<ThemeProvider>().setTheme(value);
    await Future.delayed(const Duration(milliseconds: 500));
    context.read<LoadingProvider>().setLoading(false);
  }

  void _onNotificationsChanged(BuildContext context, bool value) {
    context.read<NotificationProvider>().setNotifications(value);
  }

  @override
  Widget build(BuildContext context) {
    final loadingProvider = context.watch<LoadingProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final notificationProvider = context.watch<NotificationProvider>();

    return Stack(
      children: [
        Scaffold(
          appBar: customAppBarr('Settings', primaryColor, Theme.of(context).scaffoldBackgroundColor),
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
                      notificationProvider.notificationsEnabled,
                      (value) => _onNotificationsChanged(context, value)),
                ]),
                const SizedBox(height: 24),
                buildSectionTitle(context, 'Appearance'),
                buildCardSection(context, [
                  buildSwitchTile(
                      context,
                      Icons.dark_mode,
                      'Dark Mode',
                      'Toggle dark/light theme',
                      themeProvider.isDarkMode,
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
                    () => Navigator.pushNamed(context, '/privacy-policy'),
                  ),
                  const Divider(),
                  buildListTile(
                    context,
                    Icons.description,
                    'Terms & Conditions',
                    'Read our terms',
                    () => Navigator.pushNamed(context, '/terms-conditions'),
                  ),
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
        ),
        // Loading overlay
        if (loadingProvider.isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
          ),
      ],
    );
  }
}
