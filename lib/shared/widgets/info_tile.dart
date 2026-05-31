import 'package:flutter/material.dart';
import 'package:fit_tracker/config/theme/app_theme.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? iconColor;

  const InfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>();
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Theme.of(context).primaryColor),
      title: Text(title,
          style: TextStyle(color: colors?.textColor)),
      trailing: Text(value,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colors?.textColor)),
    );
  }
}
