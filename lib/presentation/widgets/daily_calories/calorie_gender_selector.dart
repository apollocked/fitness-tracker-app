import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/select_gender_radio.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class CalorieGenderSelector extends StatelessWidget {
  final String gender;
  final ValueChanged<String> onGenderChanged;

  const CalorieGenderSelector({
    super.key,
    required this.gender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.calorieGender,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colors.textColor)),
        const SizedBox(height: 8),
        CustomGenderRatio(
          color: redColor,
          selectedGender: gender,
          onGenderChanged: onGenderChanged,
        ),
      ],
    );
  }
}
