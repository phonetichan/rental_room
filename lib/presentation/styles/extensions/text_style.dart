import 'package:flutter/material.dart' as material;
import 'package:rental_room/presentation/presentation.dart';

extension TextStyleUtil on material.TextStyle {
  material.TextStyle get thin => copyWith(fontWeight: material.FontWeight.w100);

  material.TextStyle get extraLight => copyWith(fontWeight: material.FontWeight.w200);

  material.TextStyle get light => copyWith(fontWeight: material.FontWeight.w300);

  material.TextStyle get regular => copyWith(fontWeight: material.FontWeight.w400);

  material.TextStyle get medium => copyWith(fontWeight: material.FontWeight.w500);

  material.TextStyle get semiBold => copyWith(fontWeight: material.FontWeight.w600);

  material.TextStyle get bold => copyWith(fontWeight: material.FontWeight.w700);

  material.TextStyle get extraBold => copyWith(fontWeight: material.FontWeight.w800);

  material.TextStyle get superBold => copyWith(fontWeight: material.FontWeight.w900);

  material.TextStyle get title => copyWith(fontSize: 19.5);

  material.TextStyle get extraSmall => copyWith(fontSize: 10);

  material.TextStyle get option =>
      copyWith(color: $styles.color.clrBlack.withOpacity(0.7)); // Changed to withOpacity for SDK 3.13 compatibility

  material.TextStyle get grey =>
      copyWith(color: $styles.color.clrBlack.withOpacity(0.5));

  material.TextStyle get withPrimary =>
      copyWith(color: $styles.color.clrPrimary);

  double? get lineHeight {
    if (height == null || fontSize == null) return null;
    return height! * fontSize!;
  }
}