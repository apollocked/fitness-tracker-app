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
import 'package:fit_tracker/presentation/widgets/profile/guest_profile_section.dart';
import 'package:fit_tracker/presentation/widgets/profile/profile_widgets.dart';
import 'package:fit_tracker/presentation/widgets/profile/profile_section_helpers.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    final authVM = context.watch<AuthViewModel>();
    final user = authVM.currentUser;
    final l10n = AppLocalizations.of(context)!;

    if (user == null) {
      return Scaffold(
        appBar: customAppBarr(
            l10n.profileTitle, primaryColor, theme.scaffoldBackgroundColor),
        body: Center(
            child: Text(l10n.profileGuestUser,
                style: TextStyle(color: colors.textColor))),
      );
    }
    if (authVM.isGuest) return GuestProfilePage(theme: theme);

    return Scaffold(
      appBar: customAppBarr(
          l10n.profileTitle, primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          ProfileHero(username: user.username),
          const SizedBox(height: 20),
          _buildSections(context, colors),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }

  Widget _buildSections(BuildContext context, AppColorsExtension colors) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        sectionLabel('ACCOUNT', colors),
        const SizedBox(height: 8),
        sectionCard(context, colors, [
          ProfileMenuTile(
              icon: Icons.person_outline_rounded,
              title: l10n.profileBodyStats,
              subtitle: l10n.profileEditBodyStats,
              accentColor: blueColor,
              onTap: () => pushPage(context, const PersonalInfoPage())),
          sectionDivider(colors),
          ProfileMenuTile(
              icon: Icons.flag_outlined,
              title: l10n.profileGoals,
              subtitle: l10n.profileViewGoals,
              accentColor: greenColor,
              onTap: () => pushPage(context, const GoalsPage())),
        ]),
        const SizedBox(height: 16),
        sectionLabel('APP', colors),
        const SizedBox(height: 8),
        sectionCard(context, colors, [
          ProfileMenuTile(
              icon: Icons.settings_outlined,
              title: l10n.profileSettings,
              subtitle: l10n.profileCustomizeApp,
              accentColor: primaryColor,
              onTap: () => pushPage(context, const SettingsPage())),
          sectionDivider(colors),
          ProfileMenuTile(
              icon: Icons.help_outline_rounded,
              title: l10n.profileHelpSupport,
              subtitle: l10n.profileGetHelp,
              accentColor: orangeColor,
              onTap: () => pushPage(context, const HelpAndSupportPage())),
          sectionDivider(colors),
          ProfileMenuTile(
              icon: Icons.auto_fix_high_rounded,
              title: l10n.profileFeatures,
              subtitle: 'Explore all features',
              accentColor: blueColor,
              onTap: () => pushPage(context, const FeaturesPage())),
          sectionDivider(colors),
          ProfileMenuTile(
              icon: Icons.info_outline_rounded,
              title: l10n.profileAbout,
              subtitle: l10n.profileLearnApp,
              accentColor: colors.subtitleColor,
              onTap: () => pushPage(context, const AboutPage())),
        ]),
        const SizedBox(height: 16),
        sectionCard(context, colors, [
          ProfileMenuTile(
              icon: Icons.logout_rounded,
              title: 'Logout',
              subtitle: 'Sign out of your profile',
              accentColor: redColor,
              isDanger: true,
              onTap: () => LogoutDialog.show(context)),
        ]),
      ]),
    );
  }
}
