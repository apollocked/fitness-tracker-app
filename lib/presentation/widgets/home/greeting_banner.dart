import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GreetingBanner extends StatelessWidget {
  const GreetingBanner({super.key, this.username});
  final String? username;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(isDark ? 0.25 : 0.15),
            primaryColor.withOpacity(isDark ? 0.08 : 0.04)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor.withOpacity(isDark ? 0.3 : 0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text.rich(TextSpan(
                text: '${l10n.greetingGeneric}, ',
                style: TextStyle(fontSize: 16, color: colors.subtitleColor),
                children: [
                  TextSpan(
                    text: '${username ?? l10n.homeAthleteFallback}!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colors.textColor,
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 4),
              Text(l10n.homeFitnessJourney,
                  style: TextStyle(fontSize: 13, color: colors.subtitleColor)),
            ]),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.15), shape: BoxShape.circle),
            child: Icon(Icons.fitness_center, color: primaryColor, size: 24),
          ),
        ],
      ),
    );
  }
}
