import 'package:flutter/material.dart';

enum AppTheme {
  premiumGold,
  neutralGray,
  sleekCharcoal,
  customTheme,
}

extension AppThemeExtension on AppTheme {
  AppColors get lightColors {
    switch (this) {
      case AppTheme.premiumGold:
        return const AppColors(
          primary: Color(0xFF976501),
          secondary: Color(0xFF193377),
          background: Color(0xFFFDFCF9),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFFDCE7F8),
          accent: Color(0xFF0C8285),
          textColor: Color(0xFF000000),
        );
      case AppTheme.neutralGray:
        return const AppColors(
          primary: Color(0xFF374151),
          secondary: Color(0xFF2563EB),
          background: Color(0xFFF9FAFB),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFFE5E7EB),
          accent: Color(0xFF196501),
          textColor: Color(0xFF111827),
        );
      case AppTheme.sleekCharcoal:
        return const AppColors(
          primary: Color(0xFF334155),
          secondary: Color(0xFF64748B),
          background: Color(0xFFF7F7F7),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFFE5E7EB),
          accent: Color(0xFFD4AA00),
          textColor: Color(0xFF020617),
        );
      case AppTheme.customTheme:
        return lightColors;
    }
  }

  AppColors get darkColors {
    return const AppColors(
      primary: Color(0xFF94A3B8),
      secondary: Color(0xFFBCC6D4),
      background: Color(0xFF0F0F0F),
      surface: Color(0xFF1A1A1A),
      onSurface: Color(0xFF2B2B2B),
      accent: Color(0xFF193377),
      textColor: Color(0xFFFFFFFF),
    );
  }
}

class AppColors {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color onSurface;
  final Color accent;
  final Color textColor;

  const AppColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.onSurface,
    required this.accent,
    required this.textColor,
  });
}
