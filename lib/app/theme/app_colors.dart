import 'package:flutter/material.dart';

/// Lexora design tokens — light & dark.
abstract final class AppColors {
  static const Color primary = Color(0xFF2F6BFF);
  static const Color primaryDark = Color(0xFF2455E6);
  static const Color primaryLight = Color(0xFFEAF2FF);
  static const Color purpleAccent = Color(0xFF8B5CF6);

  static const Color background = Color(0xFFF7FAFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFEAF2FF);

  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF2F6BFF);

  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFEAF2FF);

  // Dark
  static const Color backgroundDark = Color(0xFF0B1220);
  static const Color surfaceDark = Color(0xFF111827);
  static const Color surfaceMutedDark = Color(0xFF1E293B);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color borderDark = Color(0xFF334155);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2F6BFF), Color(0xFF2455E6), Color(0xFF8B5CF6)],
  );

  static Color cefrColor(String level) {
    switch (level.toUpperCase()) {
      case 'A1':
        return success;
      case 'A2':
        return const Color(0xFF14B8A6);
      case 'B1':
        return primary;
      case 'B2':
        return purpleAccent;
      case 'C1':
        return warning;
      case 'C2':
        return error;
      default:
        return textSecondary;
    }
  }
}
