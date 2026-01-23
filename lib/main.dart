import 'package:flutter/material.dart';
import 'package:myapp/pages/Start_page/start_page.dart';

void main() {
  runApp(const FitApp());
}

class FitApp extends StatelessWidget {
  const FitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "fitness mesurment app",
        home: StartPage());
  }
}
