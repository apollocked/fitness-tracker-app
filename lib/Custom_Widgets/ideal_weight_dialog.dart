import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class IdealWeightResultsDialog {
  static void showResults(
    BuildContext context, {
    required double idealWeight,
    required double currentWeight,
    required Null Function() onSetGoal,
    required String goalType,
    required double weightDifference,
  }) {
    final difference = currentWeight - idealWeight;
    final isOverweight = difference > 0;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: getCardColor(),
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
                        color: getTextColor())),
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
                              fontSize: 14, color: getSubtitleColor())),
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
                      color: isDarkMode() ? Colors.grey[800] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Current Weight',
                              style: TextStyle(
                                  fontSize: 12, color: getSubtitleColor())),
                          const SizedBox(height: 8),
                          Text('${currentWeight.toStringAsFixed(1)} kg',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: getTextColor())),
                        ],
                      ),
                      Container(
                          width: 2,
                          height: 60,
                          color: isDarkMode()
                              ? Colors.grey[700]
                              : Colors.grey[300]),
                      Column(
                        children: [
                          Text(isOverweight ? 'To Lose' : 'To Gain',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: isOverweight
                                      ? Colors.red
                                      : Colors.green)),
                          const SizedBox(height: 8),
                          Text('${difference.abs().toStringAsFixed(1)} kg',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isOverweight ? Colors.red : Colors.green,
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
                        ? Colors.red[isDarkMode() ? 900 : 50]
                        : Colors.green[isDarkMode() ? 900 : 50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isOverweight
                        ? '⚠️ You need to lose ${difference.abs().toStringAsFixed(1)} kg to reach your ideal weight'
                        : '✓ You need to gain ${difference.abs().toStringAsFixed(1)} kg to reach your ideal weight',
                    style: TextStyle(
                        fontSize: 12,
                        color: isOverweight
                            ? Colors.red[isDarkMode() ? 300 : 700]
                            : Colors.green[isDarkMode() ? 300 : 700]),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Got it!',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
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
