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
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/presentation/pages/auth/register_page.dart';
import 'package:fit_tracker/presentation/pages/auth/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    final authVM = context.watch<AuthViewModel>();
    final user = authVM.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: customAppBarr(
            'Profile', primaryColor, theme.scaffoldBackgroundColor),
        body: Center(
            child: Text('No user logged in',
                style: TextStyle(color: colors.textColor))),
      );
    }

    // ── Guest profile ──────────────────────────────────────────────────────
    if (authVM.isGuest) {
      return _GuestProfilePage(colors: colors, theme: theme);
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

// ─────────────────────────────────────────────────────────────────────────────
// Guest Profile Page
// ─────────────────────────────────────────────────────────────────────────────

class _GuestProfilePage extends StatelessWidget {
  final AppColorsExtension colors;
  final ThemeData theme;
  const _GuestProfilePage({required this.colors, required this.theme});

  @override
  Widget build(BuildContext context) {
    final appVM = context.watch<AppViewModel>();
    return Scaffold(
      appBar: customAppBarr(
          'Profile', primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          // Hero gradient card
          _GuestHero(colors: colors),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              // Benefit chips
              _BenefitsCard(colors: colors, theme: theme),
              const SizedBox(height: 20),
              // Appearance toggle (theme works for guests in-session)
              _GuestAppearanceCard(
                  colors: colors, theme: theme, appVM: appVM),
              const SizedBox(height: 20),
              // Create account CTA
              _CreateAccountButton(theme: theme),
              const SizedBox(height: 12),
              // Login CTA
              _LoginButton(theme: theme),
              const SizedBox(height: 20),
              // App info section still available
              _AppInfoSection(colors: colors, theme: theme),
              const SizedBox(height: 20),
              // Exit guest button
              _ExitGuestButton(theme: theme),
              const SizedBox(height: 32),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _GuestHero extends StatelessWidget {
  final AppColorsExtension colors;
  const _GuestHero({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2),
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
          ),
          child: const Icon(Icons.person_outline_rounded,
              size: 44, color: Colors.white),
        ),
        const SizedBox(height: 14),
        const Text('Browsing as Guest',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text(
          'Your data is not being saved',
          style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13,
              fontWeight: FontWeight.w400),
        ),
      ]),
    );
  }
}

class _BenefitsCard extends StatelessWidget {
  final AppColorsExtension colors;
  final ThemeData theme;
  const _BenefitsCard({required this.colors, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: colors.shadowColor,
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Create an account to unlock:',
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        ..._benefits.map((b) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: b.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(b.icon, size: 17, color: b.color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(b.title,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        Text(b.subtitle,
                            style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.subtitleColor)),
                      ]),
                ),
              ]),
            )),
      ]),
    );
  }

  static const _benefits = [
    _Benefit(
        icon: Icons.save_alt_rounded,
        color: primaryColor,
        title: 'Save your data',
        subtitle: 'Measurements & progress persist across sessions'),
    _Benefit(
        icon: Icons.flag_outlined,
        color: greenColor,
        title: 'Set goals',
        subtitle: 'Weight, protein & calorie targets'),
    _Benefit(
        icon: Icons.show_chart_rounded,
        color: blueColor,
        title: 'Track progress',
        subtitle: 'Visualize your fitness journey over time'),
    _Benefit(
        icon: Icons.notifications_active_outlined,
        color: orangeColor,
        title: 'Reminders',
        subtitle: 'Weight check-in notifications'),
  ];
}

class _Benefit {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  const _Benefit(
      {required this.icon,
      required this.color,
      required this.title,
      required this.subtitle});
}

class _CreateAccountButton extends StatelessWidget {
  final ThemeData theme;
  const _CreateAccountButton({required this.theme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: primaryGradient,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
          icon: const Icon(Icons.person_add_outlined,
              color: Colors.white, size: 20),
          label: const Text('Create Free Account',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15)),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const RegisterPage())),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final ThemeData theme;
  const _LoginButton({required this.theme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: primaryColor, width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        icon: const Icon(Icons.login_rounded,
            color: primaryColor, size: 20),
        label: const Text('Already have an account? Login',
            style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14)),
        onPressed: () {
          // Logout guest session and go to login
          context.read<AuthViewModel>().logout();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (_) => false,
          );
        },
      ),
    );
  }
}

class _AppInfoSection extends StatelessWidget {
  final AppColorsExtension colors;
  final ThemeData theme;
  const _AppInfoSection({required this.colors, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colors.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: colors.shadowColor,
                blurRadius: 12,
                offset: const Offset(0, 4))
          ]),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.hardEdge,
        child: Column(children: [
          ProfileMenuTile(
              icon: Icons.auto_fix_high_rounded,
              title: 'App Features',
              subtitle: 'Explore all features',
              accentColor: blueColor,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const FeaturesPage()))),
          Divider(
              height: 1,
              thickness: 1,
              color: colors.subtitleColor.withOpacity(0.12),
              indent: 56),
          ProfileMenuTile(
              icon: Icons.info_outline_rounded,
              title: 'About',
              subtitle: 'App information',
              accentColor: Colors.grey,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AboutPage()))),
          Divider(
              height: 1,
              thickness: 1,
              color: colors.subtitleColor.withOpacity(0.12),
              indent: 56),
          ProfileMenuTile(
              icon: Icons.help_outline_rounded,
              title: 'Help & Support',
              subtitle: 'Get assistance',
              accentColor: orangeColor,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const HelpAndSupportPage()))),
        ]),
      ),
    );
  }
}

class _ExitGuestButton extends StatelessWidget {
  final ThemeData theme;
  const _ExitGuestButton({required this.theme});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.logout_rounded, color: Colors.red, size: 18),
      label: const Text('Exit Guest Mode',
          style:
              TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
      onPressed: () {
        context.read<AuthViewModel>().logout();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (_) => false,
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Guest Appearance Card (theme toggle available for guests)
// ─────────────────────────────────────────────────────────────────────────────

class _GuestAppearanceCard extends StatelessWidget {
  final AppColorsExtension colors;
  final ThemeData theme;
  final AppViewModel appVM;
  const _GuestAppearanceCard(
      {required this.colors, required this.theme, required this.appVM});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: colors.shadowColor,
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.dark_mode_outlined,
                color: primaryColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dark Mode',
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  Text('Toggle dark/light theme',
                      style: theme.textTheme.bodySmall),
                ]),
          ),
          Switch(
            value: appVM.isDarkMode,
            activeColor: primaryColor,
            onChanged: (v) => context.read<AppViewModel>().setDarkMode(v),
          ),
        ]),
      ),
    );
  }
}
