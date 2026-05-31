import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/shared/widgets/custom_appbar.dart';
import 'package:fit_tracker/features/profile/about_page.dart';
import 'package:fit_tracker/features/profile/goals/goals_page.dart';
import 'package:fit_tracker/features/profile/features_page.dart';
import 'package:fit_tracker/features/profile/help_support_page.dart';
import 'package:fit_tracker/features/profile/logout_dialog.dart';
import 'package:fit_tracker/features/profile/personal_info_page.dart';
import 'package:fit_tracker/features/profile/settings/settings_page.dart';
import 'package:fit_tracker/config/theme/app_colors.dart';
import 'package:fit_tracker/config/theme/app_theme.dart';
import 'package:fit_tracker/features/auth/presentation/auth_viewmodel.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    final user = context.watch<AuthViewModel>().currentUser;
    if (user == null) {
      return Scaffold(
        appBar: customAppBarr(
            'Profile', primaryColor, theme.scaffoldBackgroundColor),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Center(
            child: Text('No user logged in',
                style: TextStyle(color: colors.textColor))),
      );
    }
    return Scaffold(
      appBar:
          customAppBarr('Profile', primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: primaryColor,
              child: Icon(Icons.person,
                  size: 60, color: theme.scaffoldBackgroundColor),
            ),
            const SizedBox(height: 10),
            Text(user.username,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colors.textColor)),
            Text(user.email,
                style: TextStyle(fontSize: 14, color: colors.subtitleColor)),
            const SizedBox(height: 20),
            _buildProfileCard(context, [
              _buildListTile(
                  context, Icons.person, 'Personal Info', 'View your info', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PersonalInfoPage()));
              }),
              _buildListTile(
                  context, Icons.flag, 'Goals', 'Set your fitness goals', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const GoalsPage()));
              }),
            ]),
            const SizedBox(height: 5),
            _buildProfileCard(context, [
              _buildListTile(
                  context, Icons.settings, 'Settings', 'App preferences', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              }),
              _buildListTile(context, Icons.help_outline, 'Help & Support',
                  'Get assistance', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HelpAndSupportPage()));
              }),
              _buildListTile(context, Icons.auto_fix_high, 'App Features',
                  'Explore all features', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FeaturesPage()));
              }),
              _buildListTile(
                  context, Icons.info_outline, 'About', 'App information', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutPage()));
              }),
            ]),
            const SizedBox(height: 5),
            _buildProfileCard(context, [
              _buildListTile(
                  context, Icons.logout, 'Logout', 'Sign out from your account',
                  () {
                LogoutDialog.show(context);
              }, isLogout: true),
            ]),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, List<Widget> children) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<AppColorsExtension>()!.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title,
      String subtitle, VoidCallback onTap,
      {bool isLogout = false}) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.red : primaryColor),
        title: Text(title,
            style: TextStyle(
                color: isLogout ? Colors.red : colors.textColor,
                fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: TextStyle(color: colors.subtitleColor)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}


