import 'package:flutter/material.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class ProteinResultsDialog {
  static void showResults(
    BuildContext context, {
    required bool isBodybuilder,
    required double normalProtein,
    required double minProtein,
    required double maxProtein,
  }) {
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
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.restaurant,
                      size: 48, color: Colors.orange),
                ),
                const SizedBox(height: 20),
                Text('Your Protein Intake',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: getTextColor())),
                const SizedBox(height: 8),
                Text(isBodybuilder ? 'Bodybuilder Plan' : 'Regular Plan',
                    style: TextStyle(fontSize: 14, color: getSubtitleColor())),
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
                        Text('Daily Protein Range',
                            style: TextStyle(
                                fontSize: 14, color: getSubtitleColor())),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Minimum',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: getSubtitleColor())),
                                const SizedBox(height: 4),
                                Text('${minProtein.toStringAsFixed(1)}g',
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange)),
                              ],
                            ),
                            Text('to',
                                style: TextStyle(
                                    fontSize: 16, color: getSubtitleColor())),
                            Column(
                              children: [
                                Text('Maximum',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: getSubtitleColor())),
                                const SizedBox(height: 4),
                                Text('${maxProtein.toStringAsFixed(1)}g',
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange)),
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
                        color: Colors.blue[isDarkMode() ? 900 : 50],
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      '💪 As a bodybuilder, consume protein throughout the day for optimal muscle growth',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue[isDarkMode() ? 300 : 600]),
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
                        Text('Daily Protein Intake',
                            style: TextStyle(
                                fontSize: 14, color: getSubtitleColor())),
                        const SizedBox(height: 12),
                        Text('${normalProtein.toStringAsFixed(1)}g',
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.green[isDarkMode() ? 900 : 50],
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      '✓ This is the recommended daily protein intake for a healthy lifestyle',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[isDarkMode() ? 300 : 600]),
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
