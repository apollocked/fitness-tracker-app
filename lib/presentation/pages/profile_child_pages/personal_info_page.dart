import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthViewModel>().currentUser;
    final theme = Theme.of(context);
    final colors = theme.extension<AppColorsExtension>()!;
    final l10n = AppLocalizations.of(context)!;

    if (user == null) {
      return Scaffold(
        appBar: customAppBarr(l10n.bodyStatsTitle, primaryColor,
            theme.scaffoldBackgroundColor),
        body: Center(child: Text(l10n.errorNoUserLoggedIn)),
      );
    }

    final fields = [
      (l10n.profileUsername, user.username, Icons.person_outline_rounded),
      (l10n.bodyStatsAge, '${user.age} years', Icons.cake_outlined),
      (l10n.bodyStatsHeight, '${user.height} ${l10n.bodyStatsCm}', Icons.height_rounded),
      (l10n.bodyStatsWeight, '${user.weight} ${l10n.bodyStatsKg}', Icons.monitor_weight_outlined),
      (l10n.bodyStatsGender, user.gender, Icons.wc_rounded),
    ];

    return Scaffold(
      appBar: customAppBarr(
          l10n.bodyStatsTitle, primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: colors.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: colors.shadowColor,
                  blurRadius: 12,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: fields.indexed.map(((int, (String, String, IconData)) e) {
              final i = e.$1;
              final (label, value, icon) = e.$2;
              return Column(children: [
                _InfoTile(label: label, value: value, icon: icon),
                if (i < fields.length - 1)
                  Divider(
                      height: 1,
                      thickness: 1,
                      color: colors.subtitleColor.withOpacity(0.12),
                      indent: 56),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile(
      {required this.label, required this.value, required this.icon});
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, size: 18, color: primaryColor),
        ),
        const SizedBox(width: 14),
        Expanded(
            child: Text(label,
                style: TextStyle(fontSize: 14, color: colors.subtitleColor))),
        Text(value,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.textColor)),
      ]),
    );
  }
}
