import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/utils/assets.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr('About', primaryColor, getBackgroundColor()),
      backgroundColor: getBackgroundColor(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Center(child: logoWidget),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Fitness Tracker',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: getTextColor()),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 14, color: getSubtitleColor()),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'About This App',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: getTextColor()),
            ),
            const SizedBox(height: 12),
            Text(
              'Fitness Tracker is your personal fitness companion designed to help you achieve your health and fitness goals. Whether you\'re looking to lose weight, build muscle, or maintain a healthy lifestyle, our app provides you with all the tools you need.',
              style: TextStyle(
                  fontSize: 14, color: getSubtitleColor(), height: 1.6),
            ),
            const SizedBox(height: 24),
            Text(
              'Our Mission',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: getTextColor()),
            ),
            const SizedBox(height: 12),
            Text(
              'We believe that fitness is a journey, not a destination. Our mission is to make fitness tracking simple, accessible, and enjoyable for everyone. With Fitness Tracker, you\'re never alone in your fitness journey.',
              style: TextStyle(
                  fontSize: 14, color: getSubtitleColor(), height: 1.6),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode() ? Colors.blue[900] : Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color:
                        isDarkMode() ? Colors.blue[700]! : Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App Information',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: getTextColor()),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('App Name:',
                          style: TextStyle(color: getSubtitleColor())),
                      Text('Fitness Tracker',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getTextColor())),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Version:',
                          style: TextStyle(color: getSubtitleColor())),
                      Text('1.0.0',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getTextColor())),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Developer:',
                          style: TextStyle(color: getSubtitleColor())),
                      Text('Fitness Team',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getTextColor())),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Email',
                          style: TextStyle(color: getSubtitleColor())),
                      Text('support@fitnessapp.com',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getTextColor())),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
