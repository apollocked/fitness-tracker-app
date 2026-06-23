import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/app_card.dart';
import 'package:fit_tracker/presentation/widgets/profile/help_support_data.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';

class FAQSection extends StatefulWidget {
  const FAQSection({super.key});
  @override
  State<FAQSection> createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  int _expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: helpFaqs.length,
      itemBuilder: (context, index) {
        final faq = helpFaqs[index];
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
                  title: Text(faq['question'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colors.textColor)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Text(faq['answer'], style: TextStyle(fontSize: 13, color: colors.subtitleColor, height: 1.4)),
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
  const TroubleshootSection({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: helpTroubleshooting.length,
      itemBuilder: (context, index) {
        final issue = helpTroubleshooting[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppCard(
            borderColor: orangeColor.withOpacity(0.3),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(Icons.warning_amber_rounded, size: 20, color: orangeColor),
                const SizedBox(width: 10),
                Expanded(child: Text(issue['issue'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colors.textColor))),
              ]),
              const SizedBox(height: 12),
              Text('Solutions:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.subtitleColor)),
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
  const TipsSection({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.95, crossAxisSpacing: 12, mainAxisSpacing: 12,
      ),
      itemCount: helpTips.length,
      itemBuilder: (context, index) {
        final tip = helpTips[index];
        return AppCard(
          borderColor: greenColor.withOpacity(0.3),
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(tip['icon'] as IconData, size: 24, color: greenColor),
            const SizedBox(height: 10),
            Text(tip['title'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: colors.textColor),
                maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 6),
            Text(tip['description'], style: TextStyle(fontSize: 11, color: colors.subtitleColor, height: 1.3),
                maxLines: 3, overflow: TextOverflow.ellipsis),
          ]),
        );
      },
    );
  }
}
