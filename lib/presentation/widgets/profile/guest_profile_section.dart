import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/profile/guest_hero_section.dart';
import 'package:fit_tracker/presentation/widgets/profile/guest_benefits_card.dart';
import 'package:fit_tracker/presentation/widgets/profile/guest_appearance_card.dart';
import 'package:fit_tracker/presentation/widgets/profile/guest_app_info_section.dart';
import 'package:fit_tracker/presentation/pages/auth/register_page.dart';
import 'package:fit_tracker/presentation/pages/auth/login_page.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GuestProfilePage extends StatelessWidget {
  final ThemeData theme;
  const GuestProfilePage({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final appVM = context.watch<AppViewModel>();
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: customAppBarr(l10n.navProfile, primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          GuestHeroSection(isDark: theme.brightness == Brightness.dark),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              const GuestBenefitsCard(),
              const SizedBox(height: 20),
              GuestAppearanceCard(appVM: appVM),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.person_add_outlined, size: 20),
                  label: Text(l10n.guestCreateFreeProfile,
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const RegisterPage())),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity, height: 48,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: primaryColor, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: Icon(Icons.login_rounded, color: primaryColor, size: 20),
                  label: Text(l10n.guestAlreadyHaveProfile,
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 14)),
                  onPressed: () {
                    context.read<AuthViewModel>().logout();
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (_) => const LoginPage()), (_) => false);
                  },
                ),
              ),
              const SizedBox(height: 20),
              const GuestAppInfoSection(),
              const SizedBox(height: 20),
              TextButton.icon(
                icon: Icon(Icons.logout_rounded, color: redColor, size: 18),
                label: Text(l10n.guestExitGuestMode,
                    style: TextStyle(color: redColor, fontWeight: FontWeight.w600)),
                onPressed: () {
                  context.read<AuthViewModel>().logout();
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_) => const LoginPage()), (_) => false);
                },
              ),
              const SizedBox(height: 32),
            ]),
          ),
        ]),
      ),
    );
  }
}
