import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

Widget buildSectionTitle(BuildContext context, String title) {
  final colors = Theme.of(context).extension<AppColorsExtension>()!;
  return Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 10),
    child: Text(title.toUpperCase(),
        style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: colors.subtitleColor,
            letterSpacing: 1.2)),
  );
}

Widget buildCardSection(BuildContext context, List<Widget> children) {
  final colors = Theme.of(context).extension<AppColorsExtension>()!;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
            color: colors.shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4))
      ],
    ),
    child: Material(
      color: colors.cardColor,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.hardEdge,
      child: Column(children: children),
    ),
  );
}

Widget buildListTile(BuildContext context, IconData icon, String title,
    String subtitle, VoidCallback onTap,
    {bool isDanger = false}) {
  final colors = Theme.of(context).extension<AppColorsExtension>()!;
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: (isDanger ? Colors.red : primaryColor).withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon,
                size: 18, color: isDanger ? Colors.red : primaryColor),
          ),
          const SizedBox(width: 14),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDanger ? Colors.red : colors.textColor)),
                Text(subtitle,
                    style:
                        TextStyle(fontSize: 12, color: colors.subtitleColor)),
              ])),
          Icon(Icons.chevron_right_rounded,
              size: 18, color: colors.subtitleColor),
        ]),
      ),
    ),
  );
}

Widget buildSwitchTile(BuildContext context, IconData icon, String title,
    String subtitle, bool value, Function(bool) onChanged) {
  final colors = Theme.of(context).extension<AppColorsExtension>()!;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(children: [
      Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, size: 18, color: primaryColor),
      ),
      const SizedBox(width: 14),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.textColor)),
        Text(subtitle,
            style: TextStyle(fontSize: 12, color: colors.subtitleColor)),
      ])),
      Switch(
          value: value,
          onChanged: onChanged,
          activeColor: primaryColor,
          inactiveThumbColor: colors.subtitleColor,
          inactiveTrackColor: colors.cardColor,
          overlayColor: WidgetStateProperty.all(Colors.transparent)),
    ]),
  );
}
