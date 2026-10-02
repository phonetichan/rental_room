import 'package:flutter/material.dart';

/// [AppColors] defines the central raw color palette for the application.
///
/// ### Usage:
/// Access raw hex colors directly when designing custom widgets or referencing brand colors:
/// ```dart
/// Container(color: AppColors.clrPrimary)
/// ```
class AppColors {
  // Primary & Secondary Brand Colors
  static const clrPrimary = Color(0xFF7F56D9);
  static const clrSecondary = Color(0xFF9E77ED);
  static const clrPrimaryDark = Color(0xFF53389E);
  static const clrPrimaryLight = Color(0xFFE9D7FE);

  // Core Neutrals
  static const clrWhite = Color(0xFFFFFFFF);
  static const clrBlack = Color(0xFF101828);
  static const clrOffBlack = Color(0xFF1D2939);

  // Accents & Functional Colors
  static const clrBlue = Color(0xFF2E90FA);
  static const clrRed = Color(0xFFF04438);
  static const clrDanger = Color(0xFFEF4444);
  static const clrSuccess = Color(0xFF12B76A);

  // Greys & Backgrounds
  static const clrSofterGrey = Color(0xFFF9F5FF);
  static const clrSoftGrey = Color(0xFFEAECF0);
  static const clrGrey = Color(0xFF98A2B3);
  static const clrDarkGrey = Color(0xFF667085);
  static const clrDarkerGrey = Color(0xFF344054);

  // Dark Theme Surfaces & Cards
  static const clrDarkSurface = Color(0xFF1E1E1E);
  static const clrDarkCard = Color(0xFF2A2A2A);

  static const background = Color(0xFFF8F9FC);
}
