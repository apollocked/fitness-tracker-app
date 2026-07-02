import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/presentation/pages/auth/register_page.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

/// Sticky gradient banner shown at the top of every main page for guests.
class GuestBanner extends StatelessWidget {
  const GuestBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isGuest = context.watch<AuthViewModel>().isGuest;
    if (!isGuest) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = theme.brightness == Brightness.dark;
    final bg =
        isDark ? const [Color(0xFF1A1A2E), Color(0xFF252540)] : primaryGradient;
    final fg = isDark ? colors.textColor : blackColor;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: bg,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(children: [
        Icon(Icons.cloud_off_rounded, color: fg, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            l10n.guestBannerMessage,
            style: theme.textTheme.bodySmall?.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: 28,
          child: ElevatedButton(
            onPressed: () => _navigateToRegister(context),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            child: Text(l10n.guestCreateProfile,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ),
      ]),
    );
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const RegisterPage()));
  }
}

/// Shows a dialog blocking data-write actions for guests,
/// offering to navigate to registration.
class GuestGuard {
  static Future<bool> check(BuildContext context) async {
    final authVM = context.read<AuthViewModel>();
    final l10n = AppLocalizations.of(context)!;
    if (!authVM.isGuest) return true; // not guest — allow action

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(children: [
          Icon(Icons.lock_outline_rounded, color: primaryColor),
          SizedBox(width: 10),
          Text(l10n.guestModeTitle),
        ]),
        content: Text(l10n.guestModeMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.guestStayAsGuest),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterPage()),
              );
            },
            child: Text(l10n.guestCreateProfile),
          ),
        ],
      ),
    );
    return false; // block the action — user either navigated away or dismissed
  }
}
