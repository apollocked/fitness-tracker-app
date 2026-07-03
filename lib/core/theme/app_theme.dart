import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';
import 'package:fit_tracker/core/theme/widgets/app_bar_theme.dart';
import 'package:fit_tracker/core/theme/widgets/bottom_nav_theme.dart';
import 'package:fit_tracker/core/theme/widgets/button_theme.dart';
import 'package:fit_tracker/core/theme/widgets/input_theme.dart';
import 'package:fit_tracker/core/theme/widgets/dialog_theme.dart';
import 'package:fit_tracker/core/theme/widgets/snackbar_theme.dart';
import 'package:fit_tracker/core/theme/widgets/text_theme_config.dart';
import 'package:fit_tracker/core/theme/widgets/card_theme.dart';
export 'package:fit_tracker/core/theme/app_colors_extension.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get lightTheme => _build(isDark: false);
  static ThemeData get darkTheme => _build(isDark: true);

  static ThemeData _build({required bool isDark}) {
    final bg = isDark ? const Color(0xFF0D0D14) : const Color(0xFFF5F5F0);
    final card = isDark ? const Color(0xFF1A1A2E) : Colors.white;
    final text = isDark ? const Color(0xFFE8E8F0) : const Color(0xFF1A1A2E);
    final subtitle = isDark ? const Color(0xFF7A7A9A) : const Color(0xFF8A8A9A);
    final inputFill =
        isDark ? const Color(0xFF252540) : const Color(0xFFF0F0F5);
    final inputBorder =
        isDark ? const Color(0xFF2A2A50) : const Color(0xFFE0E0E8);
    final divColor = isDark ? const Color(0xFF252540) : const Color(0xFFEEEEF4);
    final shadow = isDark ? const Color(0x33000000) : const Color(0x0F000000);

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Rudaw',
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: bg,
      colorScheme: isDark
          ? ColorScheme.dark(
              primary: primaryColor,
              secondary: blueColor,
              surface: card,
              error: redColor)
          : ColorScheme.light(
              primary: primaryColor,
              secondary: blueColor,
              surface: card,
              error: redColor),
      appBarTheme: AppBarThemeConfig.getAppBarTheme(
        bg: bg,
        text: text,
      ),
      cardTheme: CardThemeConfig.getCardTheme(
        card: card,
      ),
      bottomNavigationBarTheme: BottomNavThemeConfig.getBottomNavTheme(
        card: card,
        primaryColor: primaryColor,
        isDark: isDark,
      ),
      textTheme: TextThemeConfig.getTextTheme(
        text: text,
        subtitle: subtitle,
      ),
      dialogTheme: DialogThemeConfig.getDialogTheme(
        card: card,
        text: text,
      ),
      inputDecorationTheme: InputThemeConfig.getInputDecorationTheme(
        inputFill: inputFill,
        inputBorder: inputBorder,
        primaryColor: primaryColor,
        redColor: redColor,
        subtitle: subtitle,
      ),
      elevatedButtonTheme: ButtonThemeConfig.getElevatedButtonTheme(
        primaryColor: primaryColor,
      ),
      snackBarTheme: SnackBarThemeConfig.getSnackBarTheme(
        backgroundColor: isDark ? const Color(0xFF252540) : blackColor,
        isDark: isDark,
      ),
      dividerTheme: DividerThemeData(color: divColor, thickness: 1, space: 0),
      iconTheme: IconThemeData(color: text),
      listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4)),
      extensions: <ThemeExtension<dynamic>>[
        AppColorsExtension(
          cardColor: card,
          textColor: text,
          subtitleColor: subtitle,
          shadowColor: shadow,
        ),
      ],
    );
  }
}
