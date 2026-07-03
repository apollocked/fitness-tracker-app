import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class GoalProgressBar extends StatelessWidget {
  final double progress;
  final bool completed;
  final Color progressColor;
  final String percentText;

  const GoalProgressBar({
    super.key,
    required this.progress,
    required this.completed,
    required this.progressColor,
    required this.percentText,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: colors.subtitleColor.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation<Color>(
                completed ? greenColor : progressColor),
            minHeight: 6,
          ),
        ),
        const SizedBox(height: 4),
        Text(percentText,
            style: TextStyle(fontSize: 11, color: colors.subtitleColor)),
      ],
    );
  }
}
