import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/features/navigation/layout_page.dart';
import 'package:fit_tracker/features/profile/settings/privacy_policy_page.dart';
import 'package:fit_tracker/features/profile/settings/terms_conditions_page.dart';
import 'package:fit_tracker/features/calculators/ideal_bw_page.dart';
import 'package:fit_tracker/features/calculators/protien_intake_page.dart';
import 'package:fit_tracker/features/calculators/daily_calorie_page.dart';
import 'package:fit_tracker/features/calculators/add_measurement_page.dart';
import 'package:fit_tracker/features/profile/features_page.dart';
import 'package:fit_tracker/features/auth/login_page.dart';
import 'package:fit_tracker/shared/services/storage_service.dart';
import 'package:fit_tracker/config/theme/app_theme.dart';
import 'package:fit_tracker/features/auth/data/repositories/local_auth_repository.dart';
import 'package:fit_tracker/features/auth/data/repositories/local_user_repository.dart';
import 'package:fit_tracker/features/auth/data/repositories/local_measurement_repository.dart';
import 'package:fit_tracker/features/auth/presentation/auth_viewmodel.dart';
import 'package:fit_tracker/features/profile/presentation/goals_viewmodel.dart';
import 'package:fit_tracker/features/app/presentation/app_viewmodel.dart';
import 'package:fit_tracker/features/progress/presentation/progress_viewmodel.dart';

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
        ChangeNotifierProvider(create: (_) => AuthViewModel(authRepository, userRepository)),
        ChangeNotifierProvider(create: (_) => GoalsViewModel(userRepository, authRepository)),
        ChangeNotifierProvider(create: (_) => AppViewModel(authRepository, userRepository)),
        ChangeNotifierProvider(create: (_) => ProgressViewModel(measurementRepository)),
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
    if (authVM.currentUser?.darkMode != null) {
      appVM.setDarkMode(authVM.currentUser!.darkMode);
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
