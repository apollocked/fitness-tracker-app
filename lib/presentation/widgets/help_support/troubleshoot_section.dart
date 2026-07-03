import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/app_card.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class TroubleshootSection extends StatelessWidget {
  final AppLocalizations l10n;
  const TroubleshootSection({super.key, required this.l10n});

  List<Map<String, dynamic>> _troubles(AppLocalizations l10n) => [
    {'issue': l10n.helpTroubleCalculators, 'solutions': [l10n.helpTroubleCalculatorsS1, l10n.helpTroubleCalculatorsS2, l10n.helpTroubleCalculatorsS3]},
    {'issue': l10n.helpTroubleGoals, 'solutions': [l10n.helpTroubleGoalsS1, l10n.helpTroubleGoalsS2, l10n.helpTroubleGoalsS3]},
    {'issue': l10n.helpTroubleDarkMode, 'solutions': [l10n.helpTroubleDarkModeS1, l10n.helpTroubleDarkModeS2, l10n.helpTroubleDarkModeS3]},
    {'issue': l10n.helpTroubleChart, 'solutions': [l10n.helpTroubleChartS1, l10n.helpTroubleChartS2, l10n.helpTroubleChartS3]},
    {'issue': l10n.helpTroubleSlow, 'solutions': [l10n.helpTroubleSlowS1, l10n.helpTroubleSlowS2, l10n.helpTroubleSlowS3]},
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final troubles = _troubles(l10n);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: troubles.length,
      itemBuilder: (context, index) {
        final issue = troubles[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppCard(
            borderColor: orangeColor.withOpacity(0.3),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(Icons.warning_amber_rounded, size: 20, color: orangeColor),
                const SizedBox(width: 10),
                Expanded(child: Text(issue['issue'] as String, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colors.textColor))),
              ]),
              const SizedBox(height: 12),
              Text(l10n.helpSolutions, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.subtitleColor)),
              const SizedBox(height: 8),
              ...(issue['solutions'] as List<String>).indexed.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('${e.$1 + 1}. ', style: TextStyle(fontSize: 12, color: colors.subtitleColor, fontWeight: FontWeight.w600)),
                      Expanded(child: Text(e.$2, style: TextStyle(fontSize: 12, color: colors.subtitleColor))),
                    ]),
                  )),
            ]),
          ),
        );
      },
    );
  }
}
