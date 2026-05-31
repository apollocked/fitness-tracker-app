import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/colors.dart';

class AppTheme {
  AppTheme._(); // Prevent instantiation

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.grey[100],
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: blueColor,
          surface: Colors.white,
          error: redColor,
        ),

        // AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Card
        cardTheme: CardThemeData(
          color: const Color.fromARGB(255, 255, 254, 246),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: Colors.grey.withOpacity(0.1),
        ),

        // Bottom Navigation Bar
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color.fromARGB(255, 255, 254, 246),
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: const TextStyle(fontSize: 13),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          selectedIconTheme: const IconThemeData(size: 27),
          unselectedIconTheme: const IconThemeData(size: 20),
          showSelectedLabels: true,
          showUnselectedLabels: false,
        ),

        // Text
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Colors.black87,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.black87, fontSize: 14),
        ),

        // Dialog
        dialogTheme: DialogThemeData(
          backgroundColor: const Color.fromARGB(255, 255, 254, 246),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titleTextStyle: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Input Decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryColor),
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),

        // Elevated Button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
        ),

        // Divider
        dividerTheme: DividerThemeData(
          color: Colors.grey[300],
          thickness: 1,
        ),

        // Icon
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),

        // Extensions for custom colors
        extensions: const <ThemeExtension>[
          AppColorsExtension(
            cardColor: Color.fromARGB(255, 255, 254, 246),
            textColor: Colors.black87,
            subtitleColor: Color(0xFF757575), // Colors.grey[600]
            insideButtonColor: Color(0xFFFAFAFA), // Colors.grey[50]
            shadowColor: Color(0x1A9E9E9E), // Colors.grey.withOpacity(0.1)
          ),
        ],
      );

  // GöÇGöÇGöÇ Dark Theme GöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇGöÇ

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: darkBg,
        colorScheme: ColorScheme.dark(
          primary: primaryColor,
          secondary: blueColor,
          surface: darkCard,
          error: redColor,
        ),

        // AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: darkBg,
          foregroundColor: darkText,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: darkText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Card
        cardTheme: CardThemeData(
          color: darkCard,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: Colors.black.withOpacity(0.3),
        ),

        // Bottom Navigation Bar
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: darkCard,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey[400],
          selectedLabelStyle: const TextStyle(fontSize: 13),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          selectedIconTheme: const IconThemeData(size: 27),
          unselectedIconTheme: const IconThemeData(size: 20),
          showSelectedLabels: true,
          showUnselectedLabels: false,
        ),

        // Text
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: darkText,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: darkText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: darkText,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(color: darkText, fontSize: 16),
          bodyMedium: TextStyle(color: darkText, fontSize: 14),
        ),

        // Dialog
        dialogTheme: DialogThemeData(
          backgroundColor: darkCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titleTextStyle: TextStyle(
            color: darkText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Input Decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkBg,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryColor),
          ),
          labelStyle: TextStyle(color: Colors.grey[400]),
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),

        // Elevated Button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
        ),

        // Divider
        dividerTheme: const DividerThemeData(
          color: Color(0xFF2A2A2A),
          thickness: 1,
        ),

        // Icon
        iconTheme: IconThemeData(
          color: darkText,
        ),

        // Extensions for custom colors
        extensions: const <ThemeExtension>[
          AppColorsExtension(
            cardColor: darkCard,
            textColor: darkText,
            subtitleColor: Color(0xFFBDBDBD), // Colors.grey[400]
            insideButtonColor: darkBg,
            shadowColor: Color(0x4D000000), // Colors.black.withOpacity(0.3)
          ),
        ],
      );
}

/// Custom theme extension for app-specific colors that don't map
/// directly to Material's ColorScheme.
@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color cardColor;
  final Color textColor;
  final Color subtitleColor;
  final Color insideButtonColor;
  final Color shadowColor;

  const AppColorsExtension({
    required this.cardColor,
    required this.textColor,
    required this.subtitleColor,
    required this.insideButtonColor,
    required this.shadowColor,
  });

  /// Standard card BoxDecoration using the current theme colors.
  BoxDecoration get cardDecoration => BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      );

  @override
  AppColorsExtension copyWith({
    Color? cardColor,
    Color? textColor,
    Color? subtitleColor,
    Color? insideButtonColor,
    Color? shadowColor,
  }) {
    return AppColorsExtension(
      cardColor: cardColor ?? this.cardColor,
      textColor: textColor ?? this.textColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      insideButtonColor: insideButtonColor ?? this.insideButtonColor,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      subtitleColor: Color.lerp(subtitleColor, other.subtitleColor, t)!,
      insideButtonColor:
          Color.lerp(insideButtonColor, other.insideButtonColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
    );
  }
}

