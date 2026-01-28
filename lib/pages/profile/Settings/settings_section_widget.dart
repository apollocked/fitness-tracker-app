import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

Widget buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, bottom: 12),
    child: Text(
      title,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: getSubtitleColor()),
    ),
  );
}

Widget buildCardSection(List<Widget> children) {
  return Container(
    decoration: BoxDecoration(
      color: getCardColor(),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
            color: isDarkMode()
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
  IconData icon,
  String title,
  String subtitle,
  VoidCallback onTap, {
  bool isDanger = false,
}) {
  return ListTile(
    leading: Icon(icon, color: isDanger ? Colors.red : primaryColor),
    title: Text(title,
        style: TextStyle(
            color: isDanger ? Colors.red : getTextColor(),
            fontWeight: FontWeight.w500)),
    subtitle: Text(subtitle,
        style: TextStyle(fontSize: 12, color: getSubtitleColor())),
    trailing: const Icon(Icons.chevron_right),
    onTap: onTap,
  );
}

Widget buildSwitchTile(
  IconData icon,
  String title,
  String subtitle,
  bool value,
  Function(bool) onChanged,
) {
  return ListTile(
    leading: Icon(icon, color: primaryColor),
    title: Text(title, style: TextStyle(color: getTextColor())),
    subtitle: Text(subtitle,
        style: TextStyle(fontSize: 12, color: getSubtitleColor())),
    trailing:
        Switch(value: value, onChanged: onChanged, activeColor: primaryColor),
  );
}
