import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class ProteinResultsDialog {
  static void showResults(
    BuildContext context, {
    required bool isBodybuilder,
    required double normalProtein,
    required double minProtein,
    required double maxProtein,
    required VoidCallback onSetGoal,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: colors.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: orangeColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.restaurant,
                      size: 48, color: orangeColor),
                ),
                const SizedBox(height: 20),
                Text(l10n.proteinYourIntake,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colors.textColor)),
                const SizedBox(height: 8),
                Text(isBodybuilder ? l10n.proteinBodybuilderPlan : l10n.proteinRegularPlan,
                    style:
                        TextStyle(fontSize: 14, color: colors.subtitleColor)),
                const SizedBox(height: 24),
                if (isBodybuilder) ...[
                  _ResultPanel(
                    child: Column(
                      children: [
                        Text(l10n.proteinDailyRange,
                            style: TextStyle(
                                fontSize: 14, color: colors.subtitleColor)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _ProteinValue(
                              label: l10n.proteinMinimum,
                              value: minProtein,
                              colors: colors,
                            ),
                            Text(l10n.proteinTo,
                                style: TextStyle(
                                    fontSize: 16, color: colors.subtitleColor)),
                            _ProteinValue(
                              label: l10n.proteinMaximum,
                              value: maxProtein,
                              colors: colors,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _HintBox(
                    message: l10n.proteinBodybuilderHint,
                    color: blueColor,
                    colors: colors,
                  ),
                ] else ...[
                  _ResultPanel(
                    child: Column(
                      children: [
                        Text(l10n.proteinDailyIntake,
                            style: TextStyle(
                                fontSize: 14, color: colors.subtitleColor)),
                        const SizedBox(height: 12),
                        Text('${normalProtein.toStringAsFixed(1)}g',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: orangeColor)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _HintBox(
                    message: l10n.proteinRegularHint,
                    color: greenColor,
                    colors: colors,
                  ),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      onSetGoal();
                      Navigator.pop(context);
                    },
                    child: Text(l10n.proteinGotIt,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultPanel extends StatelessWidget {
  const _ResultPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: orangeColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: orangeColor.withOpacity(0.25), width: 1),
      ),
      child: child,
    );
  }
}

class _ProteinValue extends StatelessWidget {
  const _ProteinValue({
    required this.label,
    required this.value,
    required this.colors,
  });

  final String label;
  final double value;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: TextStyle(fontSize: 12, color: colors.subtitleColor)),
        const SizedBox(height: 4),
        Text('${value.toStringAsFixed(1)}g',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: orangeColor)),
      ],
    );
  }
}

class _HintBox extends StatelessWidget {
  const _HintBox({
    required this.message,
    required this.color,
    required this.colors,
  });

  final String message;
  final Color color;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        message,
        style: TextStyle(fontSize: 12, color: colors.textColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
