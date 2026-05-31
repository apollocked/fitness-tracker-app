import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tracker/features/navigation/layout_page.dart';
import 'package:fit_tracker/features/profile/settings/privacy_policy_page.dart';
import 'package:fit_tracker/features/profile/settings/terms_conditions_page.dart';
import 'package:fit_tracker/app/cubits/theme_cubit.dart';
import 'package:fit_tracker/app/cubits/navigation_cubit.dart';
import 'package:fit_tracker/features/calculators/ideal_bw_page.dart';
import 'package:fit_tracker/features/calculators/protien_intake_page.dart';
import 'package:fit_tracker/features/calculators/daily_calorie_page.dart';
import 'package:fit_tracker/features/calculators/add_measurement_page.dart';
import 'package:fit_tracker/features/profile/features_page.dart';
import 'package:fit_tracker/features/auth/login_page.dart';
import 'package:fit_tracker/app/services/storage_service.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/app/repositories/local_auth_repository.dart';
import 'package:fit_tracker/app/repositories/local_user_repository.dart';
import 'package:fit_tracker/app/repositories/local_measurement_repository.dart';
import 'package:fit_tracker/app/cubits/auth_cubit.dart';
import 'package:fit_tracker/app/cubits/goals_cubit.dart';
import 'package:fit_tracker/app/cubits/settings_cubit.dart';
import 'package:fit_tracker/app/cubits/progress_cubit.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(authRepository, userRepository)),
        BlocProvider(create: (_) => GoalsCubit(userRepository, authRepository)),
        BlocProvider(
            create: (_) => SettingsCubit(authRepository, userRepository)),
        BlocProvider(create: (_) => ProgressCubit(measurementRepository)),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => NavigationCubit()),
      ],
      child: const _FitAppBuilder(),
    );
  }
}

class _FitAppBuilder extends StatelessWidget {
  const _FitAppBuilder();
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final authState = context.watch<AuthCubit>().state;
    if (authState.user?.darkMode != null) {
      themeCubit.setDarkMode(authState.user!.darkMode);
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fitness Tracker",
      themeMode: themeCubit.state,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: authState.isLoggedIn ? const LayoutPage() : const LoginPage(),
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
