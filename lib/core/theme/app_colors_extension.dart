import 'package:flutter/material.dart';

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

  BoxDecoration get cardDecoration => BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 4),
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
  }) =>
      AppColorsExtension(
        cardColor: cardColor ?? this.cardColor,
        textColor: textColor ?? this.textColor,
        subtitleColor: subtitleColor ?? this.subtitleColor,
        insideButtonColor: insideButtonColor ?? this.insideButtonColor,
        shadowColor: shadowColor ?? this.shadowColor,
      );

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      subtitleColor: Color.lerp(subtitleColor, other.subtitleColor, t)!,
      insideButtonColor: Color.lerp(insideButtonColor, other.insideButtonColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
    );
  }
}
