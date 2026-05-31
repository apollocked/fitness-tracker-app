import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tracker/app/cubits/theme_cubit.dart';
import 'package:fit_tracker/widgets/custom_appbar.dart';
import 'package:fit_tracker/features/profile/settings/settings_dialogs.dart';
import 'package:fit_tracker/features/profile/settings/settings_section_widget.dart';
import 'package:fit_tracker/core/theme/colors.dart';
import 'package:fit_tracker/app/cubits/auth_cubit.dart';
import 'package:fit_tracker/app/cubits/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  Future<void> _onDarkModeChanged(BuildContext context, bool value) async {
    final themeCubit = context.read<ThemeCubit>();
    final authCubit = context.read<AuthCubit>();
    themeCubit.setDarkMode(value);
    if (authCubit.state.user != null) {
      final updated = authCubit.state.user!.copyWith(darkMode: value);
      authCubit.updateUser(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final settingsCubit = context.watch<SettingsCubit>();
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
                  settingsCubit.state.notificationsEnabled, (value) {
                context.read<SettingsCubit>().setNotifications(value);
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
                  themeCubit.isDarkMode,
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
