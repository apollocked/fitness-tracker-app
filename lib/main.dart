import 'package:fit_tracker/logic/progress_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/pages/layout_page.dart';
import 'package:fit_tracker/presentation/pages/setting_child_pages/privacy_policy_page.dart';
import 'package:fit_tracker/presentation/pages/setting_child_pages/terms_conditions_page.dart';
import 'package:fit_tracker/presentation/pages/calculators/ideal_bw_page.dart';
import 'package:fit_tracker/presentation/pages/calculators/protien_intake_page.dart';
import 'package:fit_tracker/presentation/pages/calculators/daily_calorie_page.dart';
import 'package:fit_tracker/presentation/pages/calculators/add_measurement_page.dart';
import 'package:fit_tracker/presentation/pages/profile_child_pages/features_page.dart';
import 'package:fit_tracker/presentation/pages/auth/login_page.dart';
import 'package:fit_tracker/presentation/pages/onboarding_page.dart';
import 'package:fit_tracker/data/services/notification_service.dart';
import 'package:fit_tracker/data/services/hive_storage_service.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/data/repositories/local_auth_repository.dart';
import 'package:fit_tracker/data/repositories/local_user_repository.dart';
import 'package:fit_tracker/data/repositories/local_measurement_repository.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';

import 'package:fit_tracker/logic/calculators_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorageService.init();
  await HiveStorageService.seedTestUser();
  await NotificationService.instance.initialize();
  final userRepository = LocalUserRepository();
  await userRepository.reloadFromStorage();
  final authRepository = LocalAuthRepository();
  final currentUser = authRepository.getCurrentUser();
  if (currentUser?.notificationsEnabled == true) {
    await NotificationService.instance.scheduleWeightReminder();
  }
  final measurementRepository = LocalMeasurementRepository();
  final seenOnboarding = HiveStorageService.hasSeenOnboarding();
  runApp(FitApp(
    userRepository: userRepository,
    authRepository: authRepository,
    measurementRepository: measurementRepository,
    showOnboarding: !seenOnboarding,
  ));
}

class FitApp extends StatelessWidget {
  final LocalUserRepository userRepository;
  final LocalAuthRepository authRepository;
  final LocalMeasurementRepository measurementRepository;
  final bool showOnboarding;
  const FitApp({
    super.key,
    required this.userRepository,
    required this.authRepository,
    required this.measurementRepository,
    this.showOnboarding = false,
  });
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthViewModel(authRepository, userRepository)),
        ChangeNotifierProvider(
            create: (_) => GoalsViewModel(userRepository, authRepository)),
        ChangeNotifierProvider(
            create: (_) => AppViewModel(authRepository, userRepository)),
        ChangeNotifierProvider(
            create: (_) =>
                ProgressViewModel(measurementRepository, authRepository)),
        ChangeNotifierProvider(create: (_) => CalculatorsViewModel()),
      ],
      child: _FitAppBuilder(showOnboarding: showOnboarding),
    );
  }
}

class _FitAppBuilder extends StatelessWidget {
  final bool showOnboarding;
  const _FitAppBuilder({this.showOnboarding = false});
  @override
  Widget build(BuildContext context) {
    final appVM = context.watch<AppViewModel>();
    final authVM = context.watch<AuthViewModel>();

    Widget home;
    if (showOnboarding) {
      home = const OnboardingPage();
    } else if (authVM.isLoggedIn) {
      home = const LayoutPage();
    } else {
      home = const LoginPage();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fitness Tracker",
      themeMode: appVM.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: home,
      routes: {
        '/terms-conditions': (context) => const TermsConditionsPage(),
        '/privacy-policy': (context) => const PrivacyPolicyPage(),
        '/ideal-weight': (context) => const IdealBodyWeightPage(),
        '/protein-intake': (context) => const ProtienIntakePage(),
        '/daily-calories': (context) => const DailyCaloriePage(),
        '/add-measurement': (context) => const AddMeasurementPage(),
        '/features': (context) => const FeaturesPage(),
        '/login': (context) => const LoginPage(),
        '/onboarding': (context) => const OnboardingPage(),
      },
    );
  }
}
