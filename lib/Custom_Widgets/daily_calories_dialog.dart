import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class DailyCaloriesResultsDialog {
  static void showResults(
    BuildContext context, {
    required double bmr,
    required double dailyCalories,
    double? maintenanceCalories,
    String goalType = 'maintain',
    double weeklyGoal = 0.5,
    String goalDescription = "Maintenance",
    VoidCallback? onSetGoal,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: getCardColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: redColor,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Calorie Results',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: getTextColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Divider
                  Divider(color: Colors.grey.withOpacity(0.3)),
                  const SizedBox(height: 16),

                  // BMR
                  _buildResultRow(
                    'Basal Metabolic Rate (BMR)',
                    '${bmr.toStringAsFixed(0)} calories/day',
                    Icons.energy_savings_leaf,
                    blueColor,
                  ),

                  if (maintenanceCalories != null) ...[
                    const SizedBox(height: 12),
                    _buildResultRow(
                      'Maintenance Calories',
                      '${maintenanceCalories.toStringAsFixed(0)} calories/day',
                      Icons.balance,
                      greenColor,
                    ),
                  ],

                  const SizedBox(height: 12),

                  // Daily Calories with goal type
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _getGoalColor(goalType).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: _getGoalColor(goalType).withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getGoalIcon(goalType),
                          color: _getGoalColor(goalType),
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                goalDescription,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: getSubtitleColor(),
                                ),
                              ),
                              Text(
                                '${dailyCalories.toStringAsFixed(0)} calories/day',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: _getGoalColor(goalType),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Goal explanation
                  if (goalType != 'maintain')
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: getCardColor(),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: orangeColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              goalType == 'lose'
                                  ? 'To lose ${weeklyGoal}kg per week, consume ${dailyCalories.toStringAsFixed(0)} calories daily'
                                  : 'To gain ${weeklyGoal}kg per week, consume ${dailyCalories.toStringAsFixed(0)} calories daily',
                              style: TextStyle(
                                fontSize: 13,
                                color: getSubtitleColor(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(color: redColor),
                          ),
                          child: Text(
                            'Close',
                            style: TextStyle(
                              color: redColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            onSetGoal?.call();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: redColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Set as Goal',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildResultRow(
      String title, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: getSubtitleColor(),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: getTextColor(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Color _getGoalColor(String goalType) {
    switch (goalType) {
      case 'lose':
        return greenColor;
      case 'gain':
        return orangeColor;
      default:
        return blueColor;
    }
  }

  static IconData _getGoalIcon(String goalType) {
    switch (goalType) {
      case 'lose':
        return Icons.trending_down;
      case 'gain':
        return Icons.trending_up;
      default:
        return Icons.trending_flat;
    }
  }
}
