import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';

Widget buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, bottom: 12),
    child: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
    ),
  );
}

Widget buildCardSection(List<Widget> children) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5),
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
    title: Text(title, style: TextStyle(color: isDanger ? Colors.red : Colors.black)),
    subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
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
    title: Text(title),
    subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
    trailing: Switch(value: value, onChanged: onChanged, activeColor: primaryColor),
  );
}
