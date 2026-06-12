import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/presentation/pages/auth/register_page.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';

/// Sticky gradient banner shown at the top of every main page for guests.
class GuestBanner extends StatelessWidget {
  const GuestBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isGuest = context.watch<AuthViewModel>().isGuest;
    if (!isGuest) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: primaryGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(children: [
        const Icon(Icons.cloud_off_rounded, color: blackColor, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Guest mode — your data won\'t be saved.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: blackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => _navigateToRegister(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: primaryColor, // White button with gold text is fine, but maybe white background with primary text is enough since primaryColor is dark gold now.
              ),
            ),
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
    if (!authVM.isGuest) return true; // not guest — allow action

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(children: [
          Icon(Icons.lock_outline_rounded, color: primaryColor),
          SizedBox(width: 10),
          Text('Guest Mode'),
        ]),
        content: const Text(
          'You\'re currently in guest mode.\n\n'
          'Create a free account to save your fitness data, track progress, and set goals.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Stay as Guest'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterPage()),
              );
            },
            child: const Text('Create Account'),
          ),
        ],
      ),
    );
    return false; // block the action — user either navigated away or dismissed
  }
}
