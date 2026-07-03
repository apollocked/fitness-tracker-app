import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class CalorieResultActions extends StatelessWidget {
  final VoidCallback? onSetGoal;

  const CalorieResultActions({
    super.key,
    this.onSetGoal,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(children: [
      Expanded(
          child: OutlinedButton(
        onPressed: () => Navigator.pop(context),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: primaryColor),
        ),
        child: Text(l10n.calorieClose,
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600)),
      )),
      const SizedBox(width: 12),
      Expanded(
          child: ElevatedButton(
        onPressed: () {
          onSetGoal?.call();
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14)),
        child: Text(l10n.calorieSetAsGoal,
            style: TextStyle(fontWeight: FontWeight.w600)),
      )),
    ]);
  }
}
