import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/goals/goals_tile.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GoalsList extends StatelessWidget {
  const GoalsList({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      physics: const BouncingScrollPhysics(),
      children: [
        const GoalTile(goalKey: 'weight'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: blueColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(color: blueColor.withOpacity(isDark ? 0.3 : 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline_rounded, size: 20, color: blueColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.goalsInfoText,
                  style: TextStyle(
                      fontSize: 12, color: colors.textColor, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
