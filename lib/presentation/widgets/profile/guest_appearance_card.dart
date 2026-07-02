import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GuestAppearanceCard extends StatelessWidget {
  final AppViewModel appVM;
  const GuestAppearanceCard({super.key, required this.appVM});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: colors.cardColor, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: colors.shadowColor, blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(color: primaryColor.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.dark_mode_outlined, color: primaryColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(l10n.settingsDark, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
            Text(l10n.settingsToggleTheme, style: theme.textTheme.bodySmall),
          ])),
          Switch(
            value: appVM.isDarkMode, activeColor: primaryColor,
            onChanged: (v) => context.read<AppViewModel>().setDarkMode(v),
          ),
        ]),
      ),
    );
  }
}
