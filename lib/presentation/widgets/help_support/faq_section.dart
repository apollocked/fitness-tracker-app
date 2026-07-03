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
