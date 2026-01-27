import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';

const String imagePath = "assets/images/";
const String startBanner = "${imagePath}banner.jpg";
const String weightBanner = "${imagePath}weight.png";
const String protienBanner = "${imagePath}protien.png";

Widget logoWidget = Column(
  children: [
    Container(
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
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          " 2 + 2 = 1",
          style: TextStyle(
            color: primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          child: Image.asset(
            'assets/images/kurdistan_flaag.png',
            height: 35,
            width: 50,
            fit: BoxFit.contain,
          ),
        ),
      ],
    ),
  ],
);
