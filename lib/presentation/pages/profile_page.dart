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
import 'package:fit_tracker/presentation/widgets/profile/profile_widgets.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';

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
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          ProfileHero(username: user.username, email: user.email),
          const SizedBox(height: 20),
          _buildSections(context, colors),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }

  Widget _buildSections(BuildContext context, AppColorsExtension colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _label('ACCOUNT', colors),
        const SizedBox(height: 8),
        _card(context, colors, [
          ProfileMenuTile(
              icon: Icons.person_outline_rounded,
              title: 'Personal Info',
              subtitle: 'View your profile details',
              accentColor: blueColor,
              onTap: () => _push(context, const PersonalInfoPage())),
          _divider(colors),
          ProfileMenuTile(
              icon: Icons.flag_outlined,
              title: 'Goals',
              subtitle: 'Set your fitness targets',
              accentColor: greenColor,
              onTap: () => _push(context, const GoalsPage())),
        ]),
        const SizedBox(height: 16),
        _label('APP', colors),
        const SizedBox(height: 8),
        _card(context, colors, [
          ProfileMenuTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
              subtitle: 'Preferences & appearance',
              accentColor: primaryColor,
              onTap: () => _push(context, const SettingsPage())),
          _divider(colors),
          ProfileMenuTile(
              icon: Icons.help_outline_rounded,
              title: 'Help & Support',
              subtitle: 'Get assistance',
              accentColor: orangeColor,
              onTap: () => _push(context, const HelpAndSupportPage())),
          _divider(colors),
          ProfileMenuTile(
              icon: Icons.auto_fix_high_rounded,
              title: 'App Features',
              subtitle: 'Explore all features',
              accentColor: blueColor,
              onTap: () => _push(context, const FeaturesPage())),
          _divider(colors),
          ProfileMenuTile(
              icon: Icons.info_outline_rounded,
              title: 'About',
              subtitle: 'App information',
              accentColor: Colors.grey,
              onTap: () => _push(context, const AboutPage())),
        ]),
        const SizedBox(height: 16),
        _card(context, colors, [
          ProfileMenuTile(
              icon: Icons.logout_rounded,
              title: 'Logout',
              subtitle: 'Sign out of your account',
              accentColor: Colors.red,
              isDanger: true,
              onTap: () => LogoutDialog.show(context)),
        ]),
      ]),
    );
  }

  Widget _label(String text, AppColorsExtension colors) => Text(text,
      style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: colors.subtitleColor,
          letterSpacing: 0));

  Widget _divider(AppColorsExtension colors) => Divider(
      height: 1,
      thickness: 1,
      color: colors.subtitleColor.withOpacity(0.12),
      indent: 56);

  Widget _card(BuildContext context, AppColorsExtension colors,
          List<Widget> children) =>
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: colors.shadowColor,
                  blurRadius: 12,
                  offset: const Offset(0, 4))
            ]),
        child: Material(
          color: colors.cardColor,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.hardEdge,
          child: Column(children: children),
        ),
      );

  void _push(BuildContext context, Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}
