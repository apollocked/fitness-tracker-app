import 'package:flutter/material.dart';

AppBar customAppBarr([String title = '', Color? accentColor, Color? bgColor]) {
  return AppBar(
    backgroundColor: bgColor,
    scrolledUnderElevation: 0,
    elevation: 0,
    centerTitle: true,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (accentColor != null) ...[
          Container(
            width: 6,
            height: 6,
            decoration:
                BoxDecoration(color: accentColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
        ],
        Text(
          title,
          style: TextStyle(
            color: accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0,
          ),
        ),
      ],
    ),
  );
}
