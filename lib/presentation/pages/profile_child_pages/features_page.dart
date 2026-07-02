import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/app_card.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final features = _features(l10n);
    return Scaffold(
      appBar: customAppBarr(
          l10n.featuresTitle, primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.featureDiscover, style: theme.textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(l10n.featureCount(features.length.toString()),
                style: TextStyle(color: colors.subtitleColor, fontSize: 14)),
            const SizedBox(height: 24),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(feature.icon,
                                  size: 24, color: primaryColor),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                                child: Text(feature.title,
                                    style: theme.textTheme.titleMedium)),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(feature.description,
                            style: TextStyle(
                                color: colors.subtitleColor,
                                fontSize: 13,
                                height: 1.4)),
                        const SizedBox(height: 16),
                        Text(l10n.featuresWhyUseful,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: colors.textColor)),
                        const SizedBox(height: 10),
                        ...feature.benefits.map((benefit) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.check_circle_rounded,
                                      size: 18, color: greenColor),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: Text(benefit,
                                          style: TextStyle(
                                              color: colors.subtitleColor,
                                              fontSize: 13))),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 16),
            AppCard(
              borderColor: primaryColor.withOpacity(0.3),
              elevation: false,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Row(
                  children: [
                    Icon(Icons.help_outline_rounded,
                        color: primaryColor, size: 28),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.featuresNeedHelp,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: colors.textColor)),
                          const SizedBox(height: 4),
                          Text(l10n.featuresHelpDesc,
                              style: TextStyle(
                                  fontSize: 12, color: colors.subtitleColor)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded,
                        color: colors.subtitleColor, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  List<_FeatureItem> _features(AppLocalizations l10n) => [
        _FeatureItem(
          icon: Icons.dashboard_rounded,
          title: l10n.featuresDashboardTitle,
          description: l10n.featuresDashboardDesc,
          benefits: [
            l10n.featuresDashboardBenefit1,
            l10n.featuresDashboardBenefit2,
            l10n.featuresDashboardBenefit3,
          ],
        ),
        _FeatureItem(
          icon: Icons.calculate,
          title: l10n.featuresCalorieTracker,
          description: l10n.featuresCalorieDesc,
          benefits: [
            l10n.featuresCalorieBenefit1,
            l10n.featuresCalorieBenefit2,
            l10n.featuresCalorieBenefit3,
          ],
        ),
        _FeatureItem(
          icon: Icons.monitor_weight,
          title: l10n.featuresIdealWeightTitle,
          description: l10n.featuresIdealWeightDesc,
          benefits: [
            l10n.featuresIdealWeightBenefit1,
            l10n.featuresIdealWeightBenefit2,
            l10n.featuresIdealWeightBenefit3,
          ],
        ),
        _FeatureItem(
          icon: Icons.restaurant,
          title: l10n.featuresProteinTitle,
          description: l10n.featuresProteinDesc,
          benefits: [
            l10n.featuresProteinBenefit1,
            l10n.featuresProteinBenefit2,
            l10n.featuresProteinBenefit3,
          ],
        ),
        _FeatureItem(
          icon: Icons.trending_up,
          title: l10n.featuresProgressTitle,
          description: l10n.featuresProgressDesc,
          benefits: [
            l10n.featuresProgressBenefit1,
            l10n.featuresProgressBenefit2,
            l10n.featuresProgressBenefit3,
          ],
        ),
        _FeatureItem(
          icon: Icons.flag_outlined,
          title: l10n.featuresGoalsTitle,
          description: l10n.featuresGoalsDesc,
          benefits: [
            l10n.featuresGoalsBenefit1,
            l10n.featuresGoalsBenefit2,
            l10n.featuresGoalsBenefit3,
          ],
        ),
        _FeatureItem(
          icon: Icons.person_outline,
          title: l10n.featuresProfileTitle,
          description: l10n.featuresProfileDesc,
          benefits: [
            l10n.featuresProfileBenefit1,
            l10n.featuresProfileBenefit2,
            l10n.featuresProfileBenefit3,
          ],
        ),
        _FeatureItem(
          icon: Icons.dark_mode,
          title: l10n.featuresDarkModeTitle,
          description: l10n.featuresDarkModeDesc,
          benefits: [
            l10n.featuresDarkModeBenefit1,
            l10n.featuresDarkModeBenefit2,
            l10n.featuresDarkModeBenefit3,
          ],
        ),
        _FeatureItem(
          icon: Icons.notifications_outlined,
          title: l10n.featuresNotifications,
          description: l10n.featuresNotificationsDesc,
          benefits: [
            l10n.featuresNotificationsBenefit1,
            l10n.featuresNotificationsBenefit2,
            l10n.featuresNotificationsBenefit3,
          ],
        ),
        _FeatureItem(
          icon: Icons.person_outlined,
          title: l10n.featuresGuestTitle,
          description: l10n.featuresGuestDesc,
          benefits: [
            l10n.featuresGuestBenefit1,
            l10n.featuresGuestBenefit2,
            l10n.featuresGuestBenefit3,
          ],
        ),
      ];
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String description;
  final List<String> benefits;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.benefits,
  });
}
