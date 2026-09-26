import 'package:flutter/material.dart';
import '../presentation.dart';

class AppShadows {
  static final light = Shadows(
    light: BoxShadow(
      color: $styles.color.clrBlack.withValues(alpha: 0.02),
      blurRadius: 4.0,
      offset: const Offset(2, 2),
      spreadRadius: 0,
    ),
  );

  static final dark = Shadows(
    light: BoxShadow(
      color: $styles.color.clrBlack.withValues(alpha: 0.02),
      blurRadius: 4.0,
      offset: const Offset(2, 2),
      spreadRadius: 0,
    ),
  );
}

class Shadows {
  final BoxShadow light;
  const Shadows({required this.light});
}