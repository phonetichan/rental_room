import 'package:flutter/material.dart';

/// Extension on [Color] providing convenient helper methods.
/// 
/// ### Usage:
/// ```dart
/// final fadedColor = AppColors.clrPrimary.addOpacity(0.5);
/// ```
extension ColorX on Color {
  /// Returns a new color with the specified [opacity] (between 0.0 and 1.0).
  Color addOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((255.0 * opacity).round());
  }
}
