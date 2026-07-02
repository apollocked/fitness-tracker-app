import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GuestHeroSection extends StatelessWidget {
  final bool isDark;
  const GuestHeroSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fg = isDark ? const Color(0xFFE0E0E0) : blackColor;
    return Container(
      width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark ? const [Color(0xFF1A1A2E), Color(0xFF252540)] : primaryGradient,
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
      ),
      child: Column(children: [
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle, color: fg.withOpacity(0.08),
            border: Border.all(color: fg.withOpacity(0.15), width: 2),
          ),
          child: Icon(Icons.person_outline_rounded, size: 44, color: fg),
        ),
        const SizedBox(height: 14),
        Text(l10n.guestBrowsingAsGuest,
            style: TextStyle(color: fg, fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text(l10n.guestDataNotSaved,
            style: TextStyle(color: fg.withOpacity(0.7), fontSize: 13, fontWeight: FontWeight.w500)),
      ]),
    );
  }
}
