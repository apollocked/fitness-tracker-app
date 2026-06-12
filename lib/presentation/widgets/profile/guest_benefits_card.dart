import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';

class GuestBenefitsCard extends StatelessWidget {
  const GuestBenefitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.cardColor, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: colors.shadowColor, blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Create a profile to unlock:',
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        ..._benefits.map((b) => Padding(
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

  static const _benefits = [
    _Benefit(icon: Icons.save_alt_rounded, color: primaryColor, title: 'Save your data', subtitle: 'Measurements & progress persist across sessions'),
    _Benefit(icon: Icons.flag_outlined, color: greenColor, title: 'Set goals', subtitle: 'Weight, protein & calorie targets'),
    _Benefit(icon: Icons.show_chart_rounded, color: blueColor, title: 'Track progress', subtitle: 'Visualize your fitness journey over time'),
    _Benefit(icon: Icons.notifications_active_outlined, color: orangeColor, title: 'Reminders', subtitle: 'Weight check-in notifications'),
  ];
}

class _Benefit {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  const _Benefit({required this.icon, required this.color, required this.title, required this.subtitle});
}
