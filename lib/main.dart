import 'package:fit_tracker/logic/porviders/progress_viewmodel.dart';
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
import 'package:fit_tracker/data/services/storage_service.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/data/services/local_auth_repository.dart';
import 'package:fit_tracker/data/services/local_user_repository.dart';
import 'package:fit_tracker/data/services/local_measurement_repository.dart';
import 'package:fit_tracker/logic/porviders/auth_viewmodel.dart';
import 'package:fit_tracker/logic/porviders/goals_viewmodel.dart';
import 'package:fit_tracker/logic/porviders/app_viewmodel.dart';
import 'package:fit_tracker/logic/porviders/calculators_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  final userRepository = LocalUserRepository();
  await userRepository.reloadFromStorage();
  await userRepository.addDefaultUserIfEmpty();
  final authRepository = LocalAuthRepository(userRepository);
  final measurementRepository = LocalMeasurementRepository();
  runApp(FitApp(
    userRepository: userRepository,
    authRepository: authRepository,
    measurementRepository: measurementRepository,
  ));
}

class FitApp extends StatelessWidget {
  final LocalUserRepository userRepository;
  final LocalAuthRepository authRepository;
  final LocalMeasurementRepository measurementRepository;
  const FitApp({
    super.key,
    required this.userRepository,
    required this.authRepository,
    required this.measurementRepository,
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
            create: (_) => ProgressViewModel(measurementRepository)),
        ChangeNotifierProvider(create: (_) => CalculatorsViewModel()),
      ],
      child: const _FitAppBuilder(),
    );
  }
}

class _FitAppBuilder extends StatelessWidget {
  const _FitAppBuilder();
  @override
  Widget build(BuildContext context) {
    final appVM = context.watch<AppViewModel>();
    final authVM = context.watch<AuthViewModel>();
    if (authVM.currentUser?.darkMode != null &&
        appVM.isDarkMode != authVM.currentUser!.darkMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appVM.setDarkMode(authVM.currentUser!.darkMode);
      });
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fitness Tracker",
      themeMode: appVM.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: authVM.isLoggedIn ? const LayoutPage() : const LoginPage(),
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
