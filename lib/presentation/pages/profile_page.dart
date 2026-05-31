import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/pages/profile_child_pages/about_page.dart';
import 'package:fit_tracker/presentation/pages/profile_child_pages/goals_page.dart';
import 'package:fit_tracker/presentation/pages/profile_child_pages/features_page.dart';
import 'package:fit_tracker/presentation/pages/profile_child_pages/help_support_page.dart';
import 'package:fit_tracker/presentation/widgets/profile/logout_dialog.dart';
import 'package:fit_tracker/presentation/pages/profile_child_pages/personal_info_page.dart';
import 'package:fit_tracker/presentation/pages/profile_child_pages/settings_page.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/porviders/auth_viewmodel.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    final user = context.watch<AuthViewModel>().currentUser;
    final isDark = theme.brightness == Brightness.dark;

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
      appBar: customAppBarr('Profile', primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Profile header
            _buildProfileHeader(context, user, colors, isDark),
            const SizedBox(height: 20),
            // Menu sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel(context, 'Account', colors),
                  const SizedBox(height: 8),
                  _buildMenuCard(context, isDark, [
                    _buildMenuTile(
                      context,
                      icon: Icons.person_outline_rounded,
                      title: 'Personal Info',
                      subtitle: 'View your profile details',
                      color: blueColor,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PersonalInfoPage())),
                    ),
                    _buildDivider(colors),
                    _buildMenuTile(
                      context,
                      icon: Icons.flag_outlined,
                      title: 'Goals',
                      subtitle: 'Set your fitness targets',
                      color: greenColor,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GoalsPage())),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  _buildSectionLabel(context, 'App', colors),
                  const SizedBox(height: 8),
                  _buildMenuCard(context, isDark, [
                    _buildMenuTile(
                      context,
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      subtitle: 'Preferences & appearance',
                      color: primaryColor,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsPage())),
                    ),
                    _buildDivider(colors),
                    _buildMenuTile(
                      context,
                      icon: Icons.help_outline_rounded,
                      title: 'Help & Support',
                      subtitle: 'Get assistance',
                      color: orangeColor,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HelpAndSupportPage())),
                    ),
                    _buildDivider(colors),
                    _buildMenuTile(
                      context,
                      icon: Icons.auto_fix_high_rounded,
                      title: 'App Features',
                      subtitle: 'Explore all features',
                      color: blueColor,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FeaturesPage())),
                    ),
                    _buildDivider(colors),
                    _buildMenuTile(
                      context,
                      icon: Icons.info_outline_rounded,
                      title: 'About',
                      subtitle: 'App information',
                      color: Colors.grey,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutPage())),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  _buildMenuCard(context, isDark, [
                    _buildMenuTile(
                      context,
                      icon: Icons.logout_rounded,
                      title: 'Logout',
                      subtitle: 'Sign out of your account',
                      color: Colors.red,
                      isDanger: true,
                      onTap: () => LogoutDialog.show(context),
                    ),
                  ]),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    dynamic user,
    AppColorsExtension colors,
    bool isDark,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  primaryColor.withOpacity(0.3),
                  primaryColor.withOpacity(0.05),
                ]
              : [
                  primaryColor.withOpacity(0.18),
                  primaryColor.withOpacity(0.04),
                ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(Icons.person_rounded,
                    size: 48, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            user.username,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colors.textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(fontSize: 13, color: colors.subtitleColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(
      BuildContext context, String label, AppColorsExtension colors) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: colors.subtitleColor,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildMenuCard(
      BuildContext context, bool isDark, List<Widget> children) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Container(
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDivider(AppColorsExtension colors) {
    return Divider(
      height: 1,
      thickness: 1,
      color: colors.subtitleColor.withOpacity(0.12),
      indent: 56,
    );
  }

  Widget _buildMenuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isDanger ? Colors.red : colors.textColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: 12, color: colors.subtitleColor),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded,
                  size: 20, color: colors.subtitleColor),
            ],
          ),
        ),
      ),
    );
  }
}
