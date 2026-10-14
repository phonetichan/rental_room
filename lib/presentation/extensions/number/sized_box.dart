import 'package:flutter/material.dart';

extension SizedBoxExtension on num {
  // Creates a SizedBox with a specified width
  SizedBox get toWidthSizedBox => SizedBox(width: toDouble());

  // Creates a SizedBox with a specified height
  SizedBox get toHeightSizedBox => SizedBox(height: toDouble());

  // Optionally, you can create a method that accepts both width and height
  SizedBox toSizedBox({double? width, double? height}) {
    return SizedBox(width: width ?? toDouble(), height: height ?? toDouble());
  }
}
