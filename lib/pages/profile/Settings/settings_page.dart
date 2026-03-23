import 'package:flutter/material.dart';
import 'package:myapp/providers/loading_proveder.dart';
import 'package:provider/provider.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/pages/Profile/Settings/settings_dialogs.dart';
import 'package:myapp/pages/Profile/Settings/settings_section_widget.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:myapp/providers/notification_provider.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _onDarkModeChanged(BuildContext context, bool value) async {
    context.read<LoadingProvider>().setLoading(true);
    await context.read<ThemeProvider>().setTheme(value);
    context.read<LoadingProvider>().setLoading(false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return SettingsPage();
    }));
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
                          context, () {})),
                ]),
                const SizedBox(height: 24),
                buildSectionTitle('Notifications'),
                buildCardSection([
                  buildSwitchTile(
                      Icons.notifications,
                      'All Notifications',
                      'Enable/disable notifications',
                      notificationProvider.notificationsEnabled,
                      (value) => _onNotificationsChanged(context, value)),
                ]),
                const SizedBox(height: 24),
                buildSectionTitle('Appearance'),
                buildCardSection([
                  buildSwitchTile(
                      Icons.dark_mode,
                      'Dark Mode',
                      'Toggle dark/light theme',
                      themeProvider.isDarkMode,
                      (value) => _onDarkModeChanged(context, value)),
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
