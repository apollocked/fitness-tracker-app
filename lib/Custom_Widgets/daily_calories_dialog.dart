import 'package:flutter/material.dart';

class DailyCaloriesResultsDialog {
  static void showResults(
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
                  child: const Icon(Icons.local_fire_department, size: 48, color: Colors.red),
                ),
                const SizedBox(height: 20),
                const Text('Your Daily Calorie Needs',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text('BMR', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text('${bmr.toStringAsFixed(0)} cal/day',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(width: 2, height: 50, color: Colors.grey[300]),
                      Column(
                        children: [
                          const Text('Maintenance', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text('${dailyCalories.toStringAsFixed(0)} cal/day',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('💡 Weight Goals:',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blue)),
                      const SizedBox(height: 8),
                      Text('• Weight Loss: ${(dailyCalories - 500).toStringAsFixed(0)} cal/day',
                          style: const TextStyle(fontSize: 11, color: Colors.blue)),
                      Text('• Weight Gain: ${(dailyCalories + 500).toStringAsFixed(0)} cal/day',
                          style: const TextStyle(fontSize: 11, color: Colors.blue)),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Got it!',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
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
