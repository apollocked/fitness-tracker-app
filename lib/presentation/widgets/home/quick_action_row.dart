import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class QuickActionRow extends StatelessWidget {
  final VoidCallback? onCalculators;
  final VoidCallback? onGoals;
  final VoidCallback? onProgress;

  const QuickActionRow({
    super.key,
    this.onCalculators,
    this.onGoals,
    this.onProgress,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
            child: _ActionChip(
          icon: Icons.calculate_outlined,
          label: l10n.homeCalculators,
          color: primaryColor,
          isDark: isDark,
          onTap: onCalculators,
        )),
        const SizedBox(width: 10),
        Expanded(
            child: _ActionChip(
          icon: Icons.flag_outlined,
          label: l10n.homeYourGoals,
          color: greenColor,
          isDark: isDark,
          onTap: onGoals,
        )),
        const SizedBox(width: 10),
        Expanded(
            child: _ActionChip(
          icon: Icons.show_chart_rounded,
          label: l10n.navProgress,
          color: blueColor,
          isDark: isDark,
          onTap: onProgress,
        )),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isDark;
  final VoidCallback? onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(isDark ? 0.12 : 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(isDark ? 0.25 : 0.15)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colors.textColor)),
          ],
        ),
      ),
    );
  }
}
