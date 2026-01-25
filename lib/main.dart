import 'package:flutter/material.dart';
import 'package:myapp/pages/HomePage/home_page.dart';
import 'package:myapp/utils/user_data.dart';

void main() {
  runApp(const FitApp());
}

class FitApp extends StatelessWidget {
  const FitApp({super.key});

  @override
  Widget build(BuildContext context) {
    //uses a default user if i editing without logging in
    currentUser ??= users[0];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Fitness Measurement App",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomePage());
  }
}
