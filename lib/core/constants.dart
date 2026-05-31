import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/colors.dart';

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
    const SizedBox(height: 20),
    Text(
      'Fit Tracker',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    ),
  ],
);
