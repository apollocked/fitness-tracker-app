import 'package:flutter/material.dart';

class DailyCalorieResultsSection extends StatelessWidget {
  final double bmr;
  final double dailyCalories;

  const DailyCalorieResultsSection({
    required this.bmr,
    required this.dailyCalories,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Column(
        children: [
          const Icon(Icons.local_fire_department, size: 50, color: Colors.red),
          const SizedBox(height: 16),
          const Text('Your Results',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildRow('BMR', '${bmr.toStringAsFixed(0)} cal/day'),
          const Divider(height: 24),
          _buildRow('Daily Calorie Needs', '${dailyCalories.toStringAsFixed(0)} cal/day', isMain: true),
          const SizedBox(height: 16),
          Text('Calories needed to maintain current weight',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700], fontSize: 14)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('For Weight Goals:',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(
                    '• Weight Loss: ${(dailyCalories - 500).toStringAsFixed(0)} cal/day',
                    style: const TextStyle(fontSize: 14)),
                Text(
                    '• Weight Gain: ${(dailyCalories + 500).toStringAsFixed(0)} cal/day',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isMain = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontSize: isMain ? 18 : 16,
              fontWeight: isMain ? FontWeight.w600 : FontWeight.normal,
            )),
        Text(value,
            style: TextStyle(
              fontSize: isMain ? 24 : 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            )),
      ],
    );
  }
}
