import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/app_card.dart';
import 'package:fit_tracker/presentation/widgets/profile/privacy_policy_data.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/l10n/app_localizations.dart';

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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: privacyPolicySections.length,
              itemBuilder: (context, index) {
                final section = privacyPolicySections[index];
                final points = section['points'] as List<String>?;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(section['title'],
                            style: theme.textTheme.titleMedium),
                        const SizedBox(height: 10),
                        Text(section['desc'],
                            style: TextStyle(
                                color: colors.subtitleColor,
                                fontSize: 13,
                                height: 1.4)),
                        if (points != null) ...[
                          const SizedBox(height: 12),
                          ...points.map((point) => Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Icon(Icons.circle,
                                          size: 6, color: primaryColor),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Text(point,
                                            style: TextStyle(
                                                color: colors.textColor,
                                                fontSize: 13))),
                                  ],
                                ),
                              )),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
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
                  Text(
                      'If you have any questions about this Privacy Policy, please contact us at:',
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
