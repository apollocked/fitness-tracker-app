import 'package:flutter/material.dart';
import 'package:myapp/pages/LayoutPage/layout_page.dart';
import 'package:myapp/utils/user_data.dart';

void main() {
  runApp(const FitApp());
}

class FitApp extends StatefulWidget {
  const FitApp({super.key});

  // Provide access to state for theme updates
  // ignore: library_private_types_in_public_api
  static _FitAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_FitAppState>();

  @override
  State<FitApp> createState() => _FitAppState();
}

class _FitAppState extends State<FitApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    // Use default user if editing without logging in
    currentUser ??= users[0];
    // Initialize dark mode
    currentUser!['darkMode'] ??= true;
    _isDarkMode = currentUser!['darkMode'] ?? true;
  }

  void updateTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
      currentUser!['darkMode'] = isDark;

      // Update in users list
      final userIndex =
          users.indexWhere((user) => user['id'] == currentUser!['id']);
      if (userIndex != -1) {
        users[userIndex]['darkMode'] = isDark;
      }
    });

    // Force rebuild the entire app
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fitness Tracker",
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: LayoutPage(onThemeChanged: updateTheme),
    );
  }
}
