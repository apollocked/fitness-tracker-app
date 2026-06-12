import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/app_card.dart';
import 'package:fit_tracker/presentation/widgets/profile/static_page_data.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppBarr(
          'App Features', primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Discover Our Features', style: theme.textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(
                'Explore all the tools and capabilities available in our fitness app.',
                style: TextStyle(color: colors.subtitleColor, fontSize: 14)),
            const SizedBox(height: 24),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: appFeatures.length,
              itemBuilder: (context, index) {
                final feature = appFeatures[index];
                return Padding(
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
                              child: Icon(feature['icon'] as IconData,
                                  size: 24, color: primaryColor),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                                child: Text(feature['title'],
                                    style: theme.textTheme.titleMedium)),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(feature['description'],
                            style: TextStyle(
                                color: colors.subtitleColor,
                                fontSize: 13,
                                height: 1.4)),
                        const SizedBox(height: 16),
                        Text('Why it\'s useful:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: colors.textColor)),
                        const SizedBox(height: 10),
                        ...(feature['benefits'] as List<String>)
                            .map((benefit) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                );
              },
            ),
            const SizedBox(height: 16),
            AppCard(
              borderColor: primaryColor.withOpacity(0.3),
              elevation: false,
              child: Row(
                children: [
                  Icon(Icons.help_outline_rounded,
                      color: primaryColor, size: 28),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Need Help?',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: colors.textColor)),
                        const SizedBox(height: 4),
                        Text(
                            'Visit Help & Support for FAQs and troubleshooting.',
                            style: TextStyle(
                                fontSize: 12, color: colors.subtitleColor)),
                      ],
                    ),
                  ),
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
