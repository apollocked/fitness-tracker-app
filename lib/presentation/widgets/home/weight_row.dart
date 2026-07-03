import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fit_tracker/data/model/measurement_model.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class WeightRow extends StatelessWidget {
  final Measurement measurement;
  final AppColorsExtension colors;

  const WeightRow({
    super.key,
    required this.measurement,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final m = measurement;
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text('${m.date.day}',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: primaryColor)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(DateFormat.yMd().format(m.date),
                style: TextStyle(fontSize: 13, color: colors.subtitleColor)),
          ),
          Text(l10n.progressWeightValue(m.weight.toStringAsFixed(1)),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: colors.textColor)),
        ],
      ),
    );
  }
}
