import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';

class ProteinHintBox extends StatelessWidget {
  const ProteinHintBox({
    super.key,
    required this.message,
    required this.color,
    required this.colors,
  });

  final String message;
  final Color color;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        message,
        style: TextStyle(fontSize: 12, color: colors.textColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
