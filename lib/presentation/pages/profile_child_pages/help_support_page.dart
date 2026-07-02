import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/profile/support_contact_widget.dart';
import 'package:fit_tracker/presentation/widgets/help_support/help_support_sections.dart';
import 'package:fit_tracker/presentation/widgets/shared/app_card.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/l10n/app_localizations.dart';

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});
  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: customAppBarr(
          l10n.helpTitle, primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('How can we help you?', style: theme.textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
              'Find answers, troubleshooting tips, and guides to get the most out of Fitness Tracker.',
              style: TextStyle(color: colors.subtitleColor, fontSize: 13)),
          const SizedBox(height: 24),
          AppCard(
            padding: const EdgeInsets.all(16),
            borderColor: primaryColor.withOpacity(0.2),
            elevation: false,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Quick Navigation',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: colors.textColor)),
              const SizedBox(height: 12),
              Wrap(spacing: 8, runSpacing: 8, children: [
                _navBtn(Icons.help_outline, 'FAQs', () => _scrollTo(_faqKey),
                    colors),
                _navBtn(Icons.build_circle_outlined, 'Troubleshoot',
                    () => _scrollTo(_troubleshootKey), colors),
                _navBtn(Icons.lightbulb_outline, 'Tips',
                    () => _scrollTo(_tipsKey), colors),
              ]),
            ]),
          ),
          const SizedBox(height: 28),
          _section(
              theme: theme,
              key: _faqKey,
              title: l10n.helpFaq,
              subtitle: 'Answers to the most common questions.',
              child: const FAQSection()),
          const SizedBox(height: 28),
          _section(
              theme: theme,
              key: _troubleshootKey,
              title: 'Troubleshooting',
              subtitle: 'Solutions for common issues.',
              child: const TroubleshootSection()),
          const SizedBox(height: 28),
          _section(
              theme: theme,
              key: _tipsKey,
              title: 'Tips & Tricks',
              subtitle: 'Get the most out of your fitness journey.',
              child: const TipsSection()),
          const SizedBox(height: 28),
          _section(
              theme: theme,
              title: l10n.helpContact,
              subtitle: l10n.helpContactDesc,
              child: SupportContactWidget(
                email: l10n.helpContactEmail,
                title: l10n.helpContact,
              )),
          const SizedBox(height: 32),
        ]),
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
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 16, color: primaryColor),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  color: colors.textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }

  Widget _section(
      {required ThemeData theme,
      GlobalKey? key,
      required String title,
      String? subtitle,
      required Widget child}) {
    return Container(
      key: key,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: theme.textTheme.titleMedium),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: theme.extension<AppColorsExtension>()!.subtitleColor)),
        ],
        const SizedBox(height: 12),
        child,
      ]),
    );
  }
}
