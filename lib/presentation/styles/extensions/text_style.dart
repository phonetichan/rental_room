import 'package:flutter/material.dart';
import 'package:rental_room/presentation/presentation.dart';

extension TextStyleUtil on TextStyle {
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);

  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);

  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);

  TextStyle get superBold => copyWith(fontWeight: FontWeight.w900);

  TextStyle get title => copyWith(fontSize: 19.5);

  TextStyle get extraSmall => copyWith(fontSize: 10);

  TextStyle get option =>
      copyWith(color: $styles.color.clrBlack.withValues(alpha: 0.7));

  TextStyle get grey =>
      copyWith(color: $styles.color.clrBlack.withValues(alpha: 0.5));

  TextStyle get withPrimary =>
      copyWith(color: $styles.color.clrPrimary);

  double? get lineHeight {
    if (height == null || fontSize == null) return null;
    return height! * fontSize!;
  }
}
