import 'package:flutter/material.dart';

AppBar customAppBarr(
    [String title = "", Color? backgroundColor, Color? foregroundColor]) {
  return AppBar(
    title: Text(title, style: TextStyle(color: foregroundColor)),
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
  );
}
