import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/profile/settings_dialogs.dart';
import 'package:fit_tracker/presentation/widgets/profile/settings_section_widget.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _onDarkModeChanged(BuildContext context, bool value) async {
    final appVM = context.read<AppViewModel>();
    final authVM = context.read<AuthViewModel>();
    appVM.setDarkMode(value);
    if (authVM.currentUser != null) {
      authVM.updateUser(authVM.currentUser!.copyWith(darkMode: value));
    }
  }

  @override
  Widget build(BuildContext context) {
    final appVM = context.watch<AppViewModel>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppBarr(
          'Settings', primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          buildSectionTitle(context, 'Account'),
          buildCardSection(context, [
            buildListTile(
                context,
                Icons.lock_outline_rounded,
                'Change Password',
                'Update your password',
                () => SettingsDialogs.showChangePasswordDialog(context)),
            const Divider(height: 1, indent: 56),
            buildListTile(
                context,
                Icons.edit_outlined,
                'Edit Profile',
                'Update your information',
                () => SettingsDialogs.showEditProfileDialog(context, () {})),
          ]),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Notifications'),
          buildCardSection(context, [
            buildSwitchTile(
                context,
                Icons.notifications_outlined,
                'All Notifications',
                'Enable/disable notifications',
                appVM.notificationsEnabled,
                (v) => appVM.setNotifications(v)),
          ]),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Appearance'),
          buildCardSection(context, [
            buildSwitchTile(
                context,
                Icons.dark_mode_outlined,
                'Dark Mode',
                'Toggle dark/light theme',
                appVM.isDarkMode,
                (v) => _onDarkModeChanged(context, v)),
          ]),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'More'),
          buildCardSection(context, [
            buildListTile(
                context,
                Icons.privacy_tip_outlined,
                'Privacy Policy',
                'Read our privacy terms',
                () => Navigator.pushNamed(context, '/privacy-policy')),
            const Divider(height: 1, indent: 56),
            buildListTile(
                context,
                Icons.description_outlined,
                'Terms & Conditions',
                'Read our terms',
                () => Navigator.pushNamed(context, '/terms-conditions')),
            const Divider(height: 1, indent: 56),
            buildListTile(
                context,
                Icons.delete_forever_outlined,
                'Delete Account',
                'Permanently delete your account',
                () => SettingsDialogs.showDeleteAccountDialog(context),
                isDanger: true),
          ]),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}
