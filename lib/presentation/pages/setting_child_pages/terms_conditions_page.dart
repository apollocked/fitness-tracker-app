import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/app_card.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: customAppBarr(
          l10n.termsTitle, primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.termsTitle,
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(l10n.termsLastUpdated,
                style: TextStyle(color: colors.subtitleColor, fontSize: 13)),
            const SizedBox(height: 24),
            ..._termsSections(l10n).map((section) => Padding(
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
                  Text('Contact Information',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colors.textColor)),
                  const SizedBox(height: 8),
                  Text('For questions about these Terms & Conditions:',
                      style:
                          TextStyle(color: colors.subtitleColor, fontSize: 13)),
                  const SizedBox(height: 8),
                  Text('mahamadbarznji712@gmail.com',
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

List<(String, String)> _termsSections(AppLocalizations l10n) => [
      (l10n.termsSection1Title, l10n.termsSection1Body),
      (l10n.termsSection2Title, l10n.termsSection2Body),
      (l10n.termsSection3Title, l10n.termsSection3Body),
      (l10n.termsSection4Title, l10n.termsSection4Body),
      (l10n.termsSection5Title, l10n.termsSection5Body),
      (l10n.termsSection6Title, l10n.termsSection6Body),
      (l10n.termsSection7Title, l10n.termsSection7Body),
    ];
