import 'dart:math';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.color,
      required this.onPress,
      required this.text,
      required this.context});
  BuildContext context;
  Function onPress;
  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 255,
      child: FloatingActionButton(
        heroTag: (text + Random().toString()),
        isExtended: true,
        onPressed: onPress(),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
