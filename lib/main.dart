// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/pages/LayoutPage/layout_page.dart';
import 'package:myapp/pages/Profile/Settings/privacy_policy_page.dart';
import 'package:myapp/pages/Profile/Settings/terms_conditions_page.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:myapp/providers/navigation_provider.dart';
import 'package:myapp/providers/notification_provider.dart';
import 'package:myapp/utils/user_data.dart';
import 'package:myapp/pages/Cards/ideal_bw_page.dart';
import 'package:myapp/pages/Cards/protien_intake_page.dart';
import 'package:myapp/pages/Cards/daily_calorie_page.dart';
import 'package:myapp/pages/Cards/add_measurement_page.dart';
import 'package:myapp/pages/Profile/features_page.dart';
import 'package:myapp/pages/authentication/login_page.dart';
import 'package:myapp/services/storage_service.dart';

void main() async {
  // Initialize widgets binding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage
  await StorageService.init();

  // Initialize user data from storage
  await initUserData();

  runApp(const FitApp());
}

class FitApp extends StatelessWidget {
  const FitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const _FitAppBuilder(),
    );
  }
}
}

class _FitAppBuilder extends StatelessWidget {
  const _FitAppBuilder();

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fitness Tracker",
      themeMode:
          themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
      // Check if user is logged in
      home: currentUser != null ? const LayoutPage() : const LoginPage(),
      routes: {
        '/terms-conditions': (context) => const TermsConditionsPage(),
        '/privacy-policy': (context) => const PrivacyPolicyPage(),
        '/ideal-weight': (context) => const IdealBodyWeightPage(),
        '/protein-intake': (context) => const ProtienIntakePage(),
        '/daily-calories': (context) => const DailyCaloriePage(),
        '/add-measurement': (context) => const AddMeasurementPage(),
        '/features': (context) => const FeaturesPage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
