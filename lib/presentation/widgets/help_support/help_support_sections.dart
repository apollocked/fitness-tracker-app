import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/app_card.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class FAQSection extends StatefulWidget {
  final AppLocalizations l10n;
  const FAQSection({super.key, required this.l10n});
  @override
  State<FAQSection> createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  int _expandedIndex = -1;

  List<Map<String, String>> _faqs(AppLocalizations l10n) => [
    {'q': l10n.helpFaq1Q, 'a': l10n.helpFaq1A},
    {'q': l10n.helpFaq2Q, 'a': l10n.helpFaq2A},
    {'q': l10n.helpFaq3Q, 'a': l10n.helpFaq3A},
    {'q': l10n.helpFaq4Q, 'a': l10n.helpFaq4A},
    {'q': l10n.helpFaq5Q, 'a': l10n.helpFaq5A},
    {'q': l10n.helpFaq6Q, 'a': l10n.helpFaq6A},
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final faqs = _faqs(widget.l10n);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        final faq = faqs[index];
        final isExpanded = _expandedIndex == index;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppCard(
            padding: EdgeInsets.zero,
            borderColor: isExpanded ? primaryColor : colors.subtitleColor.withOpacity(0.2),
            child: Material(
              type: MaterialType.transparency,
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  onExpansionChanged: (expanded) => setState(() => _expandedIndex = expanded ? index : -1),
                  title: Text(faq['q']!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colors.textColor)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Text(faq['a']!, style: TextStyle(fontSize: 13, color: colors.subtitleColor, height: 1.4)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TroubleshootSection extends StatelessWidget {
  final AppLocalizations l10n;
  const TroubleshootSection({super.key, required this.l10n});

  List<Map<String, dynamic>> _troubles(AppLocalizations l10n) => [
    {'issue': l10n.helpTroubleCalculators, 'solutions': [l10n.helpTroubleCalculatorsS1, l10n.helpTroubleCalculatorsS2, l10n.helpTroubleCalculatorsS3]},
    {'issue': l10n.helpTroubleGoals, 'solutions': [l10n.helpTroubleGoalsS1, l10n.helpTroubleGoalsS2, l10n.helpTroubleGoalsS3]},
    {'issue': l10n.helpTroubleDarkMode, 'solutions': [l10n.helpTroubleDarkModeS1, l10n.helpTroubleDarkModeS2, l10n.helpTroubleDarkModeS3]},
    {'issue': l10n.helpTroubleChart, 'solutions': [l10n.helpTroubleChartS1, l10n.helpTroubleChartS2, l10n.helpTroubleChartS3]},
    {'issue': l10n.helpTroubleSlow, 'solutions': [l10n.helpTroubleSlowS1, l10n.helpTroubleSlowS2, l10n.helpTroubleSlowS3]},
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final troubles = _troubles(l10n);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: troubles.length,
      itemBuilder: (context, index) {
        final issue = troubles[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppCard(
            borderColor: orangeColor.withOpacity(0.3),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(Icons.warning_amber_rounded, size: 20, color: orangeColor),
                const SizedBox(width: 10),
                Expanded(child: Text(issue['issue'] as String, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colors.textColor))),
              ]),
              const SizedBox(height: 12),
              Text(l10n.helpSolutions, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.subtitleColor)),
              const SizedBox(height: 8),
              ...(issue['solutions'] as List<String>).indexed.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('${e.$1 + 1}. ', style: TextStyle(fontSize: 12, color: colors.subtitleColor, fontWeight: FontWeight.w600)),
                      Expanded(child: Text(e.$2, style: TextStyle(fontSize: 12, color: colors.subtitleColor))),
                    ]),
                  )),
            ]),
          ),
        );
      },
    );
  }
}

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
