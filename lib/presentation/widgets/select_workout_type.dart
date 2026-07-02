import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class CustomBodyTypeRatio extends StatelessWidget {
  final bool isBodybuilder;
  final Function(bool) onChanged;
  const CustomBodyTypeRatio({
    super.key,
    required this.isBodybuilder,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      children: [
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(orangeColor),
          title: Text(l10n.bodybuilderNo, style: TextStyle(color: colors.textColor)),
          value: false.toString(),
          groupValue: isBodybuilder.toString(),
          onChanged: (value) {
            onChanged(false);
          },
        ),
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(orangeColor),
          title: Text(
            l10n.bodybuilderYes,
            style: TextStyle(color: colors.textColor),
          ),
          value: true.toString(),
          groupValue: isBodybuilder.toString(),
          onChanged: (value) {
            onChanged(true);
          },
        ),
      ],
    );
  }
}
