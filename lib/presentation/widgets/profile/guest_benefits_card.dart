import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GuestBenefitsCard extends StatelessWidget {
  const GuestBenefitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.cardColor, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: colors.shadowColor, blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(l10n.guestBenefitsTitle,
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        ..._benefits(l10n).map((b) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(color: b.color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(b.icon, size: 17, color: b.color),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(b.title, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                  Text(b.subtitle, style: theme.textTheme.bodySmall?.copyWith(color: colors.subtitleColor)),
                ])),
              ]),
            )),
      ]),
    );
  }

  List<_Benefit> _benefits(AppLocalizations l10n) => [
    _Benefit(icon: Icons.save_alt_rounded, color: primaryColor, title: l10n.guestBenefitSaveData, subtitle: l10n.guestBenefitSaveDataSub),
    _Benefit(icon: Icons.flag_outlined, color: greenColor, title: l10n.guestBenefitSetGoals, subtitle: l10n.guestBenefitSetGoalsSub),
    _Benefit(icon: Icons.show_chart_rounded, color: blueColor, title: l10n.guestBenefitTrackProgress, subtitle: l10n.guestBenefitTrackProgressSub),
    _Benefit(icon: Icons.notifications_active_outlined, color: orangeColor, title: l10n.guestBenefitReminders, subtitle: l10n.guestBenefitRemindersSub),
  ];
}

class _Benefit {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  const _Benefit({required this.icon, required this.color, required this.title, required this.subtitle});
}
