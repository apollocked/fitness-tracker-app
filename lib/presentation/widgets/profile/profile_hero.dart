import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class ProfileHero extends StatelessWidget {
  const ProfileHero({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(isDark ? 0.3 : 0.18),
            primaryColor.withOpacity(isDark ? 0.05 : 0.04)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              boxShadow: [
                BoxShadow(
                    color: primaryColor.withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6))
              ],
            ),
            child:
                const Icon(Icons.person_rounded, size: 46, color: Colors.white),
          ),
          const SizedBox(height: 14),
          Text(username,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colors.textColor)),
          const SizedBox(height: 4),
          Text(AppLocalizations.of(context)!.profilePersonalJourney,
              style: TextStyle(fontSize: 13, color: colors.subtitleColor)),
        ],
      ),
    );
  }
}
