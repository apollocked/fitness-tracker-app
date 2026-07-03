import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/app_card.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class TipsSection extends StatelessWidget {
  final AppLocalizations l10n;
  const TipsSection({super.key, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final tips = [
      {'icon': Icons.flag_outlined, 'title': l10n.helpTipRealistic, 'desc': l10n.helpTipRealisticDesc},
      {'icon': Icons.calendar_month_outlined, 'title': l10n.helpTipConsistent, 'desc': l10n.helpTipConsistentDesc},
      {'icon': Icons.calculate_outlined, 'title': l10n.helpTipCalculators, 'desc': l10n.helpTipCalculatorsDesc},
      {'icon': Icons.dashboard_rounded, 'title': l10n.helpTipDashboard, 'desc': l10n.helpTipDashboardDesc},
      {'icon': Icons.dark_mode_outlined, 'title': l10n.helpTipDarkMode, 'desc': l10n.helpTipDarkModeDesc},
      {'icon': Icons.notifications_active_outlined, 'title': l10n.helpTipNotifications, 'desc': l10n.helpTipNotificationsDesc},
      {'icon': Icons.fitness_center, 'title': l10n.helpTipBodybuilder, 'desc': l10n.helpTipBodybuilderDesc},
      {'icon': Icons.trending_up, 'title': l10n.helpTipReview, 'desc': l10n.helpTipReviewDesc},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.95, crossAxisSpacing: 12, mainAxisSpacing: 12,
      ),
      itemCount: tips.length,
      itemBuilder: (context, index) {
        final tip = tips[index];
        return AppCard(
          borderColor: greenColor.withOpacity(0.3),
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(tip['icon'] as IconData, size: 24, color: greenColor),
            const SizedBox(height: 10),
            Text(tip['title'] as String, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: colors.textColor),
                maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 6),
            Text(tip['desc'] as String, style: TextStyle(fontSize: 11, color: colors.subtitleColor, height: 1.3),
                maxLines: 3, overflow: TextOverflow.ellipsis),
          ]),
        );
      },
    );
  }
}
