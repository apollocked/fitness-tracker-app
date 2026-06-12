import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';

Widget sectionLabel(String text, AppColorsExtension colors) => Text(text,
    style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: colors.subtitleColor,
        letterSpacing: 0));

Widget sectionDivider(AppColorsExtension colors) => Divider(
    height: 1,
    thickness: 1,
    color: colors.subtitleColor.withOpacity(0.12),
    indent: 56);

Widget sectionCard(BuildContext context, AppColorsExtension colors,
        List<Widget> children) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: colors.shadowColor,
                blurRadius: 12,
                offset: const Offset(0, 4))
          ]),
      child: Material(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.hardEdge,
        child: Column(children: children),
      ),
    );

void pushPage(BuildContext context, Widget page) =>
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
