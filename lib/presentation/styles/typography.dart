import 'package:flutter/material.dart';
import '../../presentation/presentation.dart';

class AppTypography {
  final Locale? _locale;
  AppTypography(this._locale);

  static const ffEnglish = null;
  static const ffMyanmar = null;

  late final ffPrimary = {
        "en": ffEnglish,
        "my": ffMyanmar,
      }[_locale?.languageCode] ??
      ffMyanmar;

  late final heading1 = TextStyle(
    fontSize: 20.0,
    height: 28.0 / 20.0,
    color: $styles.color.clrBlack,
    fontFamily: ffPrimary,
  );

  late final heading2 = TextStyle(
    fontSize: 18.0,
    height: 24.0 / 18.0,
    color: $styles.color.clrBlack,
    fontFamily: ffPrimary,
  );

  late final heading3 = TextStyle(
    fontSize: 16.0,
    height: 20.0 / 16.0,
    color: $styles.color.clrBlack,
    fontFamily: ffPrimary,
  );

  late final paragraph1 = TextStyle(
    fontSize: 16.0,
    height: 20.0 / 16.0,
    color: $styles.color.clrBlack,
    fontFamily: ffPrimary,
  );

  late final paragraph2 = TextStyle(
    fontSize: 14.0,
    height: 24.0 / 14.0,
    color: $styles.color.clrBlack,
    fontFamily: ffPrimary,
  );

  late final paragraph3 = TextStyle(
    fontSize: 12.0,
    height: 18.0 / 12.0,
    color: $styles.color.clrBlack,
    fontFamily: ffPrimary,
  );

  late final _defaultTextOverFlow = TextOverflow.ellipsis;
  late final _defaultM3TextTheme = ThemeData(
    useMaterial3: true,
    fontFamily: ffPrimary,
  ).textTheme;

  late final light = _defaultM3TextTheme.copyWith(
    titleLarge: heading1.copyWith(overflow: _defaultTextOverFlow),
    titleMedium: heading2.copyWith(overflow: _defaultTextOverFlow),
    titleSmall: heading3.copyWith(overflow: _defaultTextOverFlow),
    bodyLarge: paragraph1.copyWith(overflow: _defaultTextOverFlow),
    bodyMedium: paragraph2.copyWith(overflow: _defaultTextOverFlow),
    bodySmall: paragraph3.copyWith(overflow: _defaultTextOverFlow),
    displayLarge: _defaultM3TextTheme.displayLarge?.copyWith(overflow: _defaultTextOverFlow),
    displayMedium: _defaultM3TextTheme.displayMedium?.copyWith(overflow: _defaultTextOverFlow),
    displaySmall: _defaultM3TextTheme.displaySmall?.copyWith(overflow: _defaultTextOverFlow),
    headlineLarge: _defaultM3TextTheme.headlineLarge?.copyWith(overflow: _defaultTextOverFlow),
    headlineMedium: _defaultM3TextTheme.headlineMedium?.copyWith(overflow: _defaultTextOverFlow),
    headlineSmall: _defaultM3TextTheme.headlineSmall?.copyWith(overflow: _defaultTextOverFlow),
    labelLarge: _defaultM3TextTheme.labelLarge?.copyWith(overflow: _defaultTextOverFlow),
    labelMedium: _defaultM3TextTheme.labelMedium?.copyWith(overflow: _defaultTextOverFlow),
    labelSmall: _defaultM3TextTheme.labelSmall?.copyWith(overflow: _defaultTextOverFlow),
  );

  late final dark = _defaultM3TextTheme.copyWith(
    titleLarge: heading1.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    titleMedium: heading2.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    titleSmall: heading3.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    bodyLarge: paragraph1.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    bodyMedium: paragraph2.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    bodySmall: paragraph3.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    displayLarge: _defaultM3TextTheme.displayLarge?.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    displayMedium: _defaultM3TextTheme.displayMedium?.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    displaySmall: _defaultM3TextTheme.displaySmall?.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    headlineLarge: _defaultM3TextTheme.headlineLarge?.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    headlineMedium: _defaultM3TextTheme.headlineMedium?.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    headlineSmall: _defaultM3TextTheme.headlineSmall?.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    labelLarge: _defaultM3TextTheme.labelLarge?.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    labelMedium: _defaultM3TextTheme.labelMedium?.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
    labelSmall: _defaultM3TextTheme.labelSmall?.copyWith(overflow: _defaultTextOverFlow, color: AppColors.clrWhite),
  );
}
