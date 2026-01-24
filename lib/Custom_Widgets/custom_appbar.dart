import 'package:flutter/material.dart';

AppBar customAppBarr(
    [String title = "Ideal Body Weight Calculator",
    Color? backgroundColor,
    Color? foregroundColor]) {
  {
    return AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }
}
