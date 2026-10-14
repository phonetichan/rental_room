import 'dart:ui';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  NavigatorState get navigator => Navigator.of(this);
  FlutterView get view => View.of(this);
  double get textScaleFactor => mediaQuery.textScaler.scale(1);
  double get pixelRatio => view.devicePixelRatio;
  Display get display => view.display;

  double get width => mediaQuery.size.width;
  double get height => mediaQuery.size.height;
}