import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  bool get isDarkMode => state == ThemeMode.dark;

  void toggle() => emit(isDarkMode ? ThemeMode.light : ThemeMode.dark);

  void setDarkMode(bool isDark) =>
      emit(isDark ? ThemeMode.dark : ThemeMode.light);

  ThemeData get theme => isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
}
