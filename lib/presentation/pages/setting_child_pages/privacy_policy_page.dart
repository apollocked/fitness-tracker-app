import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/app_card.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: customAppBarr(
          l10n.privacyTitle, primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.privacyTitle,
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(l10n.privacyLastUpdated,
                style: TextStyle(color: colors.subtitleColor, fontSize: 13)),
            const SizedBox(height: 24),
            ..._privacySections(l10n).map((section) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(section.$1,
                            style: theme.textTheme.titleMedium),
                        const SizedBox(height: 10),
                        Text(section.$2,
                            style: TextStyle(
                                color: colors.subtitleColor,
                                fontSize: 13,
                                height: 1.4)),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 16),
            AppCard(
              borderColor: primaryColor.withOpacity(0.3),
              elevation: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.privacyContactInfo,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colors.textColor)),
                  const SizedBox(height: 8),
                  Text(l10n.privacyContactMessage,
                      style:
                          TextStyle(color: colors.subtitleColor, fontSize: 13)),
                  const SizedBox(height: 8),
                  Text(l10n.privacyContactEmail,
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

List<(String, String)> _privacySections(AppLocalizations l10n) => [
      (l10n.privacySection1Title, l10n.privacySection1Body),
      (l10n.privacySection2Title, l10n.privacySection2Body),
      (l10n.privacySection3Title, l10n.privacySection3Body),
      (l10n.privacySection4Title, l10n.privacySection4Body),
      (l10n.privacySection5Title, l10n.privacySection5Body),
      (l10n.privacySection6Title, l10n.privacySection6Body),
      (l10n.privacySection7Title, l10n.privacySection7Body),
      (l10n.privacySection8Title, l10n.privacySection8Body),
    ];
