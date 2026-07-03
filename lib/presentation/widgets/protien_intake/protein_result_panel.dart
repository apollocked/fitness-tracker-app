import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';

class ProteinResultPanel extends StatelessWidget {
  const ProteinResultPanel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: orangeColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: orangeColor.withOpacity(0.25), width: 1),
      ),
      child: child,
    );
  }
}
