import 'package:flutter/material.dart';
import 'package:myapp/utils/app_theme.dart';
import 'package:myapp/utils/colors.dart';

Widget buildSectionTitle(BuildContext context, String title) {
  final colors = Theme.of(context).extension<AppColorsExtension>()!;
  return Padding(
    padding: const EdgeInsets.only(left: 8, bottom: 12),
    child: Text(
      title,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: colors.subtitleColor),
    ),
  );
}

Widget buildCardSection(BuildContext context, List<Widget> children) {
  final colors = Theme.of(context).extension<AppColorsExtension>()!;
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Container(
    decoration: BoxDecoration(
      color: colors.cardColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5),
      ],
    ),
    child: Column(children: children),
  );
}

Widget buildListTile(
  BuildContext context,
  IconData icon,
  String title,
  String subtitle,
  VoidCallback onTap, {
  bool isDanger = false,
}) {
  final colors = Theme.of(context).extension<AppColorsExtension>()!;
  return ListTile(
    leading: Icon(icon, color: isDanger ? Colors.red : primaryColor),
    title: Text(title,
        style: TextStyle(
            color: isDanger ? Colors.red : colors.textColor,
            fontWeight: FontWeight.w500)),
    subtitle: Text(subtitle,
        style: TextStyle(fontSize: 12, color: colors.subtitleColor)),
    trailing: const Icon(Icons.chevron_right),
    onTap: onTap,
  );
}

Widget buildSwitchTile(
  BuildContext context,
  IconData icon,
  String title,
  String subtitle,
  bool value,
  Function(bool) onChanged,
) {
  final colors = Theme.of(context).extension<AppColorsExtension>()!;
  return ListTile(
    leading: Icon(icon, color: primaryColor),
    title: Text(title, style: TextStyle(color: colors.textColor)),
    subtitle: Text(subtitle,
        style: TextStyle(fontSize: 12, color: colors.subtitleColor)),
    trailing: Switch(
      value: value,
      onChanged: onChanged,
      activeColor: primaryColor,
      inactiveThumbColor: colors.subtitleColor,
      inactiveTrackColor: colors.cardColor,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    ),
  );
}
