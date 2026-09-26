// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'colors.dart';
import 'grid.dart';
import 'shadow.dart';
import 'sizes.dart';
import 'typography.dart';
import 'extensions/text_style.dart';

enum ScreenType { sm, md, lg }

class AppStyles {
  static const int tabletXl = 1000;
  static const int tabletLg = 800;

  final double scale;
  final bool useMaterial3;
  final Size? screenSize;
  final Locale? locale;
  final ThemeMode themeMode;
  final ScreenType screenType;

  double? get width => screenSize?.width;

  double? get height => screenSize?.height;

  bool get isLandscape => (width ?? 0) > (height ?? 0);

  bool get isPortrait => !isLandscape;

  bool get isMobile => width == null || width! <= 480;

  AppStyles({
    this.themeMode = ThemeMode.light,
    this.screenSize,
    this.useMaterial3 = true,
    this.locale,
  })  : screenType = screenSize == null
            ? ScreenType.sm
            : screenSize.shortestSide > tabletXl
                ? ScreenType.lg
                : screenSize.shortestSide > tabletLg
                    ? ScreenType.md
                    : ScreenType.sm,
        scale = screenSize == null //screen sized is undetermined
            ? 1
            : screenSize.shortestSide > tabletXl //screen size is xl
                ? 1.2
                : screenSize.shortestSide > tabletLg //screen size is lg
                    ? 1.1
                    : 1; // screen size is small

  late final typography = _Typography(locale);
  late final color = _Colors(useMaterial3, typography);
  late final insets = _Insets(scale);
  late final corner = _Corners();
  late final time = _Times();
  late final spacing = _Spacings();
  late final size = _Sizes();
  late final grid = _GridSystem(screenSize ?? Size.zero);
  late final _shadow = _Shadows();

  Shadows get shadow =>
      themeMode == ThemeMode.light ? _shadow.light : _shadow.dark;

  late final _lightTextTheme = typography.light;
  late final _darkTextTheme = typography.dark;

  late final light = color.light.copyWith(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      scaffoldBackgroundColor: color.background,
      appBarTheme: color.light.appBarTheme.copyWith(
        centerTitle: true,
        backgroundColor: color.light.cardColor,
        titleTextStyle: _lightTextTheme.titleLarge?.semiBold,
        foregroundColor: _lightTextTheme.bodyLarge?.color,
      ),
      tabBarTheme: TabBarThemeData(
        indicatorColor: color.light.primaryColor,
        dividerColor: color.light.dividerColor,
        unselectedLabelColor: Colors.black.withOpacity(0.6),
        labelColor: color.light.primaryColor,
      ),
      textTheme: typography.light.copyWith(
        displayLarge: _lightTextTheme.displayLarge?.bold,
        displayMedium: _lightTextTheme.displayMedium?.bold,
        displaySmall: _lightTextTheme.displaySmall?.bold,
        titleLarge: _lightTextTheme.bodyLarge?.bold,
        titleMedium: _lightTextTheme.bodyMedium?.bold,
        titleSmall: _lightTextTheme.bodySmall?.bold,
        bodyLarge: _lightTextTheme.bodyLarge?.semiBold.copyWith(
          color: _lightTextTheme.bodyLarge!.color?.withOpacity(0.9),
        ),
        bodyMedium: _lightTextTheme.bodyMedium?.semiBold.copyWith(
          color: _lightTextTheme.bodyMedium!.color?.withOpacity(0.9),
        ),
        bodySmall: _lightTextTheme.bodySmall?.semiBold.copyWith(
          color: _lightTextTheme.bodySmall!.color?.withOpacity(0.6),
        ),
        labelLarge: _lightTextTheme.labelLarge?.regular,
        labelMedium: _lightTextTheme.labelMedium?.regular,
        labelSmall: _lightTextTheme.labelSmall?.regular,
        headlineLarge: _lightTextTheme.headlineLarge?.semiBold,
        headlineMedium: _lightTextTheme.headlineMedium?.semiBold,
        headlineSmall: _lightTextTheme.headlineSmall?.semiBold,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color.light.primaryColor,
          foregroundColor: color.dark.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(insets.xs), // Rounded corners
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _lightTextTheme.bodyMedium?.color,
          textStyle: _lightTextTheme.bodyMedium,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.all(
          _lightTextTheme.bodyMedium
              ?.copyWith(height: _lightTextTheme.bodySmall?.height)
              .semiBold,
        ),
      ));

  late final dark = color.dark.copyWith(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: AppColors.clrBlack,
    cardColor: AppColors.clrOffBlack,
    canvasColor: AppColors.clrBlack,
    dialogBackgroundColor: AppColors.clrOffBlack,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.clrOffBlack,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: _darkTextTheme.titleLarge?.bold.copyWith(
        color: AppColors.clrWhite,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.clrWhite,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.clrOffBlack,
      selectedItemColor: AppColors.clrSecondary,
      unselectedItemColor: AppColors.clrGrey,
    ),
    textTheme: typography.dark.copyWith(
      displayLarge: _darkTextTheme.displayLarge?.bold.copyWith(color: AppColors.clrWhite),
      displayMedium: _darkTextTheme.displayMedium?.bold.copyWith(color: AppColors.clrWhite),
      displaySmall: _darkTextTheme.displaySmall?.bold.copyWith(color: AppColors.clrWhite),
      titleLarge: _darkTextTheme.bodyLarge?.bold.copyWith(color: AppColors.clrWhite),
      titleMedium: _darkTextTheme.bodyMedium?.semiBold.copyWith(color: AppColors.clrWhite),
      titleSmall: _darkTextTheme.bodySmall?.semiBold.copyWith(color: AppColors.clrWhite),
      bodyLarge: _darkTextTheme.bodyLarge?.regular.copyWith(
        color: AppColors.clrWhite,
      ),
      bodyMedium: _darkTextTheme.bodyMedium?.regular.copyWith(
        color: AppColors.clrWhite,
      ),
      bodySmall: _darkTextTheme.bodySmall?.regular.copyWith(
        color: AppColors.clrGrey,
      ),
      labelLarge: _darkTextTheme.labelLarge?.regular.copyWith(color: AppColors.clrWhite),
      labelMedium: _darkTextTheme.labelMedium?.regular.copyWith(color: AppColors.clrWhite),
      labelSmall: _darkTextTheme.labelSmall?.regular.copyWith(color: AppColors.clrWhite),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.clrSecondary,
        foregroundColor: AppColors.clrWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(insets.xs),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.clrSecondary,
        textStyle: _darkTextTheme.bodyMedium,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.clrOffBlack,
      labelStyle: const TextStyle(color: AppColors.clrGrey),
      hintStyle: const TextStyle(color: AppColors.clrDarkGrey),
      prefixIconColor: AppColors.clrGrey,
      suffixIconColor: AppColors.clrGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.clrDarkerGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.clrDarkerGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.clrSecondary, width: 2),
      ),
    ),
  );
}

class _Colors {
  final _Typography _typography;
  final bool _useMaterial3;

  _Colors(this._useMaterial3, this._typography);

  /// Access color constants via AppStyles: e.g., context.styles.color.clrPrimary
  Color get clrSuccess => AppColors.clrSuccess;

  Color get clrPrimary => AppColors.clrPrimary;

  Color get clrSecondary => AppColors.clrSecondary;

  Color get clrWhite => AppColors.clrWhite;

  Color get clrBlack => AppColors.clrBlack;

  Color get clrBlue => AppColors.clrBlue;

  Color get clrRed => AppColors.clrRed;

  Color get clrSofterGrey => AppColors.clrSofterGrey;

  Color get clrSoftGrey => AppColors.clrSoftGrey;

  Color get clrGrey => AppColors.clrGrey;

  Color get clrDarkGrey => AppColors.clrDarkGrey;

  Color get clrDarkerGrey => AppColors.clrDarkerGrey;

  Color get background => AppColors.background;

  static const _lightColorScheme = ColorScheme(
    surfaceTint: Colors.transparent,
    brightness: Brightness.light,
    primary: AppColors.clrPrimary,
    onPrimary: AppColors.clrWhite,
    secondary: AppColors.clrSecondary,
    onSecondary: AppColors.clrWhite,
    error: AppColors.clrRed,
    onError: AppColors.clrWhite,
    background: AppColors.clrSofterGrey,
    onBackground: AppColors.clrBlack,
    surface: AppColors.clrWhite,
    onSurface: AppColors.clrBlack,
  );

  static const _darkColorScheme = ColorScheme(
    surfaceTint: Colors.transparent,
    brightness: Brightness.dark,
    primary: AppColors.clrSecondary,
    onPrimary: AppColors.clrWhite,
    secondary: AppColors.clrPrimary,
    onSecondary: AppColors.clrWhite,
    error: AppColors.clrRed,
    onError: AppColors.clrWhite,
    background: AppColors.clrBlack,
    onBackground: AppColors.clrWhite,
    surface: AppColors.clrOffBlack,
    onSurface: AppColors.clrWhite,
  );

  late final light = ThemeData.from(
    useMaterial3: _useMaterial3,
    colorScheme: _lightColorScheme,
    textTheme: _typography.light,
  );

  late final dark = ThemeData.from(
    useMaterial3: _useMaterial3,
    colorScheme: _darkColorScheme,
    textTheme: _typography.dark,
  ).copyWith(
    primaryColor: _darkColorScheme.primary,
    canvasColor: _darkColorScheme.background,
    scaffoldBackgroundColor: _darkColorScheme.background,
    cardColor: AppColors.clrOffBlack,
  );
}

class _Insets {
  _Insets(this._scale);

  final double _scale;

  /// equalivalent to 4px if scale is 1.0
  late final double xxs = AppSizes.size50 * _scale;

  /// equalivalent to 8px if scale is 1.0
  late final double xs = AppSizes.size100 * _scale;

  /// equalivalent to 16px if scale is 1.0
  late final double sm = AppSizes.size200 * _scale;

  /// equalivalent to 24px if scale is 1.0
  late final double md = AppSizes.size300 * _scale;

  /// equalivalent to 32px if scale is 1.0
  late final double lg = AppSizes.size400 * _scale;

  /// equalivalent to 48px if scale is 1.0
  late final double xl = AppSizes.size600 * _scale;

  /// equalivalent to 56px if scale is 1.0
  late final double xxl = AppSizes.size700 * _scale;

  /// equalivalent to 72px if scale is 1.0
  late final double offset = AppSizes.size900 * _scale;
}

class _Corners {
  _Corners();

  late final double sm = AppSizes.size50;
  late final double md = AppSizes.size100;
  late final double lg = AppSizes.size200;
}

class _Times {
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

class _Typography {
  final AppTypography _appTypography;

  _Typography(Locale? locale) : _appTypography = AppTypography(locale);

  late final light = _appTypography.light;
  late final dark = _appTypography.dark;
}

class _GridSystem {
  final Size size;

  _GridSystem(this.size);

  static const double _maxMobileWidth = 600;
  static const double _maxTabletWidth = 1280;

  int get columns => _grid.columns;

  double get columnsGutter => _grid.columnsGutter;

  double get columnsMargin => _grid.columnsMargin;

  double get rowPx => _grid.rowPx;

  double get rowsGutter => _grid.rowsGutter;

  double get maxWidth => _grid.maxWidth;

  DesignGridSystem get _grid {
    if (size.width < _maxMobileWidth) return AppGridSystem.mobile;
    if (size.width < _maxTabletWidth) return AppGridSystem.tablet;
    return AppGridSystem.desktop;
  }

  T getValueFor<T>(T mobile, {T? tablet, T? desktop}) {
    if (size.width < _maxMobileWidth) return mobile;
    if (size.width < _maxTabletWidth) return tablet ?? mobile;
    return desktop ?? tablet ?? mobile;
  }
}

class _Spacings {
  _Spacings();

  late final double spacing50 = AppSizes.size50;
  late final double spacing100 = AppSizes.size100;
  late final double spacing200 = AppSizes.size200;
  late final double spacing300 = AppSizes.size300;
  late final double spacing400 = AppSizes.size400;
  late final double spacing500 = AppSizes.size500;
  late final double spacing600 = AppSizes.size600;
  late final double spacing700 = AppSizes.size700;
  late final double spacing800 = AppSizes.size800;
  late final double spacing900 = AppSizes.size900;
}

class _Sizes {
  _Sizes();

  late final double size50 = AppSizes.size50;
  late final double size100 = AppSizes.size100;
  late final double size200 = AppSizes.size200;
  late final double size300 = AppSizes.size300;
  late final double size400 = AppSizes.size400;
  late final double size500 = AppSizes.size500;
  late final double size600 = AppSizes.size600;
  late final double size700 = AppSizes.size700;
  late final double size800 = AppSizes.size800;
  late final double size900 = AppSizes.size900;
}

class _Shadows {
  _Shadows();

  late final light = AppShadows.light;
  late final dark = AppShadows.dark;
}
