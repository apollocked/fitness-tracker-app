import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';
import 'package:fit_tracker/presentation/widgets/ideal_weight/ideal_weight_result_display.dart';
import 'package:fit_tracker/presentation/widgets/ideal_weight/ideal_weight_comparison.dart';
import 'package:fit_tracker/presentation/widgets/ideal_weight/ideal_weight_warning_message.dart';
import 'package:fit_tracker/presentation/widgets/ideal_weight/ideal_weight_action_button.dart';

class IdealWeightResultsDialog {
  static void showResults(
    BuildContext context, {
    required double idealWeight,
    required double currentWeight,
    required VoidCallback? onSetGoal,
    required String goalType,
    required double weightDifference,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final difference = currentWeight - idealWeight;
    final isOverweight = difference > 0;
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
                    color: blueColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.scale, size: 48, color: blueColor),
                ),
                const SizedBox(height: 20),
                Text(l10n.idealWeightYourIdeal,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colors.textColor)),
                const SizedBox(height: 24),
                IdealWeightResultDisplay(
                    idealWeight: idealWeight, l10n: l10n, colors: colors),
                const SizedBox(height: 20),
                IdealWeightComparison(
                  currentWeight: currentWeight,
                  weightDifference: weightDifference,
                  isOverweight: isOverweight,
                  isDark: isDark,
                  l10n: l10n,
                  colors: colors,
                ),
                const SizedBox(height: 20),
                IdealWeightWarningMessage(
                  isOverweight: isOverweight,
                  weightDifference: weightDifference,
                  isDark: isDark,
                  l10n: l10n,
                  colors: colors,
                ),
                const SizedBox(height: 24),
                IdealWeightActionButton(onSetGoal: onSetGoal, l10n: l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
