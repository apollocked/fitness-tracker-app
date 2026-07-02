import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_colors_extension.dart';
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
      fontFamily: 'News',
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
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        foregroundColor: text,
        titleTextStyle: TextStyle(
            color: text,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: card,
        selectedItemColor: primaryColor,
        unselectedItemColor: isDark ? Colors.grey[600] : Colors.grey[400],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
            color: text,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 0),
        titleLarge:
            TextStyle(color: text, fontSize: 20, fontWeight: FontWeight.bold),
        titleMedium:
            TextStyle(color: text, fontSize: 16, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: text, fontSize: 16),
        bodyMedium: TextStyle(color: subtitle, fontSize: 14),
        bodySmall: TextStyle(color: subtitle, fontSize: 12),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: card,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle:
            TextStyle(color: text, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: inputBorder, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: primaryColor, width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: redColor, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: redColor, width: 2)),
        labelStyle: TextStyle(color: subtitle),
        hintStyle: TextStyle(color: subtitle),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? const Color(0xFF252540) : blackColor,
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
