import 'package:flutter/material.dart';
import 'package:myapp/pages/HomePage/home_page.dart';
import 'package:myapp/pages/authentication/login_page.dart';

void main() {
  runApp(const FitApp());
}

class FitApp extends StatelessWidget {
  const FitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fitness Measurement App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
