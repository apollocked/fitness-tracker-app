import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';

AppBar customAppBarr([String title = "Ideal Body Weight Calculator"]) {
  return AppBar(
    backgroundColor: backgroundColor,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(color: secondColor),
    ),
    iconTheme: IconThemeData(color: secondColor),
    elevation: 0,
  );
}
