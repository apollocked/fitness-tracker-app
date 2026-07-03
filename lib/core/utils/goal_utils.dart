import 'package:fit_tracker/l10n/app_localizations.dart';

String localizedGoalUnit(AppLocalizations l10n, String? unit) {
  switch (unit) {
    case 'kg':
      return l10n.bodyStatsKg;
    case 'g':
      return l10n.proteinGrams;
    case 'cal':
      return l10n.calorieCalories;
    default:
      return unit ?? '';
  }
}
