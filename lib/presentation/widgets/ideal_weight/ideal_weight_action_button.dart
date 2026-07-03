import 'package:flutter/material.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class IdealWeightActionButton extends StatelessWidget {
  const IdealWeightActionButton({
    super.key,
    required this.onSetGoal,
    required this.l10n,
  });

  final VoidCallback? onSetGoal;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          onSetGoal?.call();
          Navigator.pop(context);
        },
        child: Text(l10n.idealWeightGotIt,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
