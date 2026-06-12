import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class IdealWeightResultsDialog {
  static void showResults(
    BuildContext context, {
    required double idealWeight,
    required double currentWeight,
    required VoidCallback? onSetGoal,
    required String goalType,
    required double weightDifference,
  }) {
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
                Text('Your Ideal Body Weight',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colors.textColor)),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: blueColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: blueColor.withOpacity(0.3), width: 2),
                  ),
                  child: Column(
                    children: [
                      Text('Ideal Weight',
                          style: TextStyle(
                              fontSize: 14, color: colors.subtitleColor)),
                      const SizedBox(height: 8),
                      Text('${idealWeight.toStringAsFixed(1)} kg',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: blueColor)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: colors.cardColor.withOpacity(isDark ? 0.8 : 0.5),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Current Weight',
                              style: TextStyle(
                                  fontSize: 12, color: colors.subtitleColor)),
                          const SizedBox(height: 8),
                          Text('${currentWeight.toStringAsFixed(1)} kg',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colors.textColor)),
                        ],
                      ),
                      Container(
                          width: 2,
                          height: 60,
                          color: colors.subtitleColor.withOpacity(0.3)),
                      Column(
                        children: [
                          Text(isOverweight ? 'To Lose' : 'To Gain',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: isOverweight
                                      ? redColor
                                      : greenColor)),
                          const SizedBox(height: 8),
                          Text('${difference.abs().toStringAsFixed(1)} kg',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isOverweight ? redColor : greenColor,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isOverweight
                        ? redColor.withOpacity(isDark ? 0.3 : 0.08)
                        : greenColor.withOpacity(isDark ? 0.3 : 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isOverweight
                            ? Icons.warning_rounded
                            : Icons.check_circle_rounded,
                        size: 16,
                        color: isOverweight
                            ? redColor
                            : greenColor,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          isOverweight
                              ? 'You need to lose ${difference.abs().toStringAsFixed(1)} kg to reach your ideal weight'
                              : 'You need to gain ${difference.abs().toStringAsFixed(1)} kg to reach your ideal weight',
                          style: TextStyle(
                              fontSize: 12,
                              color: isOverweight
                                  ? redColor
                                  : greenColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        onSetGoal?.call();
                        Navigator.pop(context);
                      },
                      child: const Text('Got it!',
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
