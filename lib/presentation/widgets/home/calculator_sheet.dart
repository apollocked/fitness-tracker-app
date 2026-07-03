import 'package:fit_tracker/presentation/widgets/shared/calc_tile.dart';
import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/pages/calculators/add_measurement_page.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class CalculatorSheet extends StatelessWidget {
  const CalculatorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.homeCalculators,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colors.textColor)),
          const SizedBox(height: 8),
          Text(l10n.homeCalculatorSubtitle,
              style: TextStyle(fontSize: 13, color: colors.subtitleColor)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: CalcTile(
                icon: Icons.monitor_weight_outlined,
                title: l10n.homeIdealBodyWeight,
                color: primaryColor,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/ideal-weight');
                },
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: CalcTile(
                icon: Icons.restaurant_outlined,
                title: l10n.homeProteinIntake,
                color: orangeColor,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/protein-intake');
                },
              )),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: CalcTile(
                icon: Icons.local_fire_department_outlined,
                title: l10n.homeCalorieCalculator,
                color: redColor,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/daily-calories');
                },
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: CalcTile(
                icon: Icons.scale_outlined,
                title: l10n.homeLogWeight,
                color: greenColor,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AddMeasurementPage()));
                },
              )),
            ],
          ),
        ],
      ),
    );
  }
}
