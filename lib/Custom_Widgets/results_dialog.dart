import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';

class ResultsDialog {
  // For Daily Calories
  static void showDailyCaloriesResults(
    BuildContext context, {
    required double bmr,
    required double dailyCalories,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
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
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.local_fire_department,
                      size: 48, color: Colors.red),
                ),
                const SizedBox(height: 20),
                const Text('Your Daily Calorie Needs',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red[200]!, width: 2),
                  ),
                  child: Column(
                    children: [
                      const Text('Daily Calorie Intake',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 12),
                      Text('${dailyCalories.toStringAsFixed(0)} cal/day',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text('BMR',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text('${bmr.toStringAsFixed(0)} cal/day',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(width: 2, height: 50, color: Colors.grey[300]),
                      Column(
                        children: [
                          const Text('Maintenance',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text('${dailyCalories.toStringAsFixed(0)} cal/day',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('💡 Weight Goals:',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue)),
                      const SizedBox(height: 8),
                      Text(
                          '• Weight Loss: ${(dailyCalories - 500).toStringAsFixed(0)} cal/day',
                          style: const TextStyle(
                              fontSize: 11, color: Colors.blue)),
                      Text(
                          '• Weight Gain: ${(dailyCalories + 500).toStringAsFixed(0)} cal/day',
                          style: const TextStyle(
                              fontSize: 11, color: Colors.blue)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
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

  // For Ideal Weight
  static void showIdealWeightResults(
    BuildContext context, {
    required double idealWeight,
    required double currentWeight,
  }) {
    final difference = currentWeight - idealWeight;
    final isOverweight = difference > 0;

    showDialog(
      context: context,
      builder: (context) => Dialog(
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
                const Text('Your Ideal Body Weight',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                      const Text('Ideal Weight',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
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
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text('Current Weight',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text('${currentWeight.toStringAsFixed(1)} kg',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(width: 2, height: 60, color: Colors.grey[300]),
                      Column(
                        children: [
                          Text(isOverweight ? 'To Lose' : 'To Gain',
                              style: TextStyle(
                                fontSize: 12,
                                color: isOverweight ? Colors.red : Colors.green,
                              )),
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
                    color: isOverweight ? Colors.red[50] : Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isOverweight
                        ? '⚠️ You need to lose ${difference.abs().toStringAsFixed(1)} kg to reach your ideal weight'
                        : '✓ You need to gain ${difference.abs().toStringAsFixed(1)} kg to reach your ideal weight',
                    style: TextStyle(
                      fontSize: 12,
                      color: isOverweight ? Colors.red[700] : Colors.green[700],
                    ),
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

  // For Protein Intake
  static void showProteinResults(
    BuildContext context, {
    required bool isBodybuilder,
    required double normalProtein,
    required double minProtein,
    required double maxProtein,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
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
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.restaurant,
                      size: 48, color: Colors.orange),
                ),
                const SizedBox(height: 20),
                const Text('Your Protein Intake',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(isBodybuilder ? 'Bodybuilder Plan' : 'Regular Plan',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                const SizedBox(height: 24),
                if (isBodybuilder) ...[
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange[200]!, width: 2),
                    ),
                    child: Column(
                      children: [
                        const Text('Daily Protein Range',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text('Minimum',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                                const SizedBox(height: 4),
                                Text('${minProtein.toStringAsFixed(1)}g',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    )),
                              ],
                            ),
                            Text('to',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[400])),
                            Column(
                              children: [
                                const Text('Maximum',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                                const SizedBox(height: 4),
                                Text('${maxProtein.toStringAsFixed(1)}g',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text(
                      '💪 As a bodybuilder, consume protein throughout the day for optimal muscle growth',
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange[200]!, width: 2),
                    ),
                    child: Column(
                      children: [
                        const Text('Daily Protein Intake',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 12),
                        Text('${normalProtein.toStringAsFixed(1)}g',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text(
                      '✓ This is the recommended daily protein intake for a healthy lifestyle',
                      style: TextStyle(fontSize: 12, color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
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
