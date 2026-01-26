import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';

const String imagePath = "assets/images/";
const String startBanner = "${imagePath}banner.jpg";
const String weightBanner = "${imagePath}weight.png";
const String protienBanner = "${imagePath}protien.png";

Widget logoWidget = Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: primaryColor,
    borderRadius: BorderRadius.circular(20),
  ),
  child: const Icon(
    Icons.fitness_center,
    size: 60,
    color: Colors.white,
  ),
);
