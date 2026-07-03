import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class ProteinValueTile extends StatelessWidget {
  const ProteinValueTile({
    super.key,
    required this.label,
    required this.value,
    required this.colors,
    required this.l10n,
  });

  final AppLocalizations l10n;
  final String label;
  final double value;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: TextStyle(fontSize: 12, color: colors.subtitleColor)),
        const SizedBox(height: 4),
        Text('${value.toStringAsFixed(1)}${l10n.proteinGramsShort}',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: orangeColor)),
      ],
    );
  }
}
