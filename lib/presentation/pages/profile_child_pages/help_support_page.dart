import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/profile/support_contact_widget.dart';
import 'package:fit_tracker/presentation/widgets/profile/help_support_data.dart';
import 'package:fit_tracker/presentation/widgets/shared/app_card.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});
  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  int _expandedFAQIndex = -1;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _faqKey = GlobalKey();
  final GlobalKey _troubleshootKey = GlobalKey();
  final GlobalKey _tipsKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: customAppBarr(
          'Help & Support', primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome to Help & Support',
                style: theme.textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(
                'Find answers to common questions and learn how to use the app.',
                style: TextStyle(color: colors.subtitleColor, fontSize: 13)),
            const SizedBox(height: 24),
            _buildQuickNavigation(colors),
            const SizedBox(height: 28),
            _buildSection(
                key: _faqKey,
                title: 'Frequently Asked Questions',
                child: _buildFAQSection(colors)),
            const SizedBox(height: 28),
            _buildSection(
                key: _troubleshootKey,
                title: 'Troubleshooting',
                child: _buildTroubleshootSection(colors)),
            const SizedBox(height: 28),
            _buildSection(
                key: _tipsKey,
                title: 'Tips & Tricks',
                child: _buildTipsSection(colors)),
            const SizedBox(height: 28),
            _buildSection(
                title: 'Still Need Help?',
                child: const SupportContactWidget(
                    email: 'mahamadbarznji712@gmail.com', title: 'Contact Us')),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      {GlobalKey? key, required String title, required Widget child}) {
    final theme = Theme.of(context);
    return Container(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildQuickNavigation(AppColorsExtension colors) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      borderColor: primaryColor.withOpacity(0.2),
      elevation: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Navigation',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colors.textColor)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _navBtn(Icons.star_outline, 'Features',
                  () => Navigator.pushNamed(context, '/features'), colors),
              _navBtn(
                  Icons.help_outline, 'FAQs', () => _scrollTo(_faqKey), colors),
              _navBtn(Icons.build_circle_outlined, 'Troubleshoot',
                  () => _scrollTo(_troubleshootKey), colors),
              _navBtn(Icons.lightbulb_outline, 'Tips',
                  () => _scrollTo(_tipsKey), colors),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navBtn(IconData icon, String label, VoidCallback onTap,
      AppColorsExtension colors) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colors.cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primaryColor.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: primaryColor),
            const SizedBox(width: 6),
            Text(label,
                style: TextStyle(
                    color: colors.textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection(AppColorsExtension colors) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: helpFaqs.length,
      itemBuilder: (context, index) {
        final faq = helpFaqs[index];
        final isExpanded = _expandedFAQIndex == index;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppCard(
            padding: EdgeInsets.zero,
            borderColor: isExpanded
                ? primaryColor
                : colors.subtitleColor.withOpacity(0.2),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                onExpansionChanged: (expanded) =>
                    setState(() => _expandedFAQIndex = expanded ? index : -1),
                title: Text(faq['question'],
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colors.textColor)),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(faq['answer'],
                        style: TextStyle(
                            fontSize: 13,
                            color: colors.subtitleColor,
                            height: 1.4)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTroubleshootSection(AppColorsExtension colors) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        size: 20, color: orangeColor),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(issue['issue'],
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: colors.textColor))),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Solutions:',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colors.subtitleColor)),
                const SizedBox(height: 8),
                ...(issue['solutions'] as List<String>)
                    .indexed
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${e.$1 + 1}. ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: colors.subtitleColor,
                                      fontWeight: FontWeight.w600)),
                              Expanded(
                                  child: Text(e.$2,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: colors.subtitleColor))),
                            ],
                          ),
                        )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTipsSection(AppColorsExtension colors) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.95,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: helpTips.length,
      itemBuilder: (context, index) {
        final tip = helpTips[index];
        return AppCard(
          borderColor: greenColor.withOpacity(0.3),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(tip['icon'] as IconData, size: 24, color: greenColor),
              const SizedBox(height: 10),
              Text(tip['title'],
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: colors.textColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 6),
              Text(tip['description'],
                  style: TextStyle(
                      fontSize: 11, color: colors.subtitleColor, height: 1.3),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        );
      },
    );
  }
}
