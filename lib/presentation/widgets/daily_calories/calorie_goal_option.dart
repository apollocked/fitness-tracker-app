import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

/// A tappable goal option chip for the Daily Calorie page.
class CalorieGoalOption extends StatelessWidget {
  const CalorieGoalOption({
    super.key,
    required this.label,
    required this.value,
    required this.selectedValue,
    required this.onTap,
  });

  final String label;
  final String value;
  final String selectedValue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isSelected = selectedValue == value;
    final icon = value == 'lose'
        ? Icons.trending_down
        : value == 'gain'
            ? Icons.trending_up
            : Icons.trending_flat;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? redColor.withOpacity(0.15) : colors.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color:
                  isSelected ? redColor : colors.subtitleColor.withOpacity(0.3),
              width: isSelected ? 2 : 1),
        ),
        child: Column(children: [
          Icon(icon,
              color: isSelected ? redColor : colors.subtitleColor, size: 22),
          const SizedBox(height: 4),
          Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? redColor : colors.textColor)),
        ]),
      ),
    );
  }
}
