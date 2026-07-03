import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';
import 'protein_result_panel.dart';
import 'protein_value_tile.dart';
import 'protein_hint_box.dart';

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
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: orangeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.restaurant, size: 48, color: orangeColor),
              ),
              const SizedBox(height: 20),
              Text(l10n.proteinYourIntake,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: colors.textColor)),
              const SizedBox(height: 8),
              Text(isBodybuilder ? l10n.proteinBodybuilderPlan : l10n.proteinRegularPlan,
                  style: TextStyle(fontSize: 14, color: colors.subtitleColor)),
              const SizedBox(height: 24),
              if (isBodybuilder) ...[
                ProteinResultPanel(
                  child: Column(children: [
                    Text(l10n.proteinDailyRange,
                        style: TextStyle(fontSize: 14, color: colors.subtitleColor)),
                    const SizedBox(height: 12),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      ProteinValueTile(label: l10n.proteinMinimum, l10n: l10n, value: minProtein, colors: colors),
                      Text(l10n.proteinTo, style: TextStyle(fontSize: 16, color: colors.subtitleColor)),
                      ProteinValueTile(label: l10n.proteinMaximum, l10n: l10n, value: maxProtein, colors: colors),
                    ]),
                  ]),
                ),
                const SizedBox(height: 16),
                ProteinHintBox(message: l10n.proteinBodybuilderHint, color: blueColor, colors: colors),
              ] else ...[
                ProteinResultPanel(
                  child: Column(children: [
                    Text(l10n.proteinDailyIntake,
                        style: TextStyle(fontSize: 14, color: colors.subtitleColor)),
                    const SizedBox(height: 12),
                    Text('${normalProtein.toStringAsFixed(1)}${l10n.proteinGramsShort}',
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: orangeColor)),
                  ]),
                ),
                const SizedBox(height: 16),
                ProteinHintBox(message: l10n.proteinRegularHint, color: greenColor, colors: colors),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () { onSetGoal(); Navigator.pop(context); },
                  child: Text(l10n.proteinGotIt, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
