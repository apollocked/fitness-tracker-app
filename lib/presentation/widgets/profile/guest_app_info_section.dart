import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/profile/profile_widgets.dart';
import 'package:fit_tracker/presentation/widgets/profile/profile_section_helpers.dart';
import 'package:fit_tracker/presentation/pages/profile_child_pages/features_page.dart';
import 'package:fit_tracker/presentation/pages/profile_child_pages/about_page.dart';
import 'package:fit_tracker/presentation/pages/profile_child_pages/help_support_page.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GuestAppInfoSection extends StatelessWidget {
  const GuestAppInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: colors.cardColor, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: colors.shadowColor, blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Material(
        color: Colors.transparent, borderRadius: BorderRadius.circular(16), clipBehavior: Clip.hardEdge,
        child: Column(children: [
          ProfileMenuTile(
              icon: Icons.auto_fix_high_rounded, title: l10n.guestAppFeatures, subtitle: l10n.guestAppFeaturesSub,
              accentColor: blueColor,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeaturesPage()))),
          sectionDivider(colors),
          ProfileMenuTile(
              icon: Icons.info_outline_rounded, title: l10n.aboutTitle, subtitle: l10n.guestAppInfoSub,
              accentColor: colors.subtitleColor,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()))),
          sectionDivider(colors),
          ProfileMenuTile(
              icon: Icons.help_outline_rounded, title: l10n.helpTitle, subtitle: l10n.guestGetAssistance,
              accentColor: orangeColor,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpAndSupportPage()))),
        ]),
      ),
    );
  }
}
