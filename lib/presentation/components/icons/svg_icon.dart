import 'package:flutter/material.dart';

class SvgIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;

  const SvgIcon({
    super.key,
    required this.icon,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color ?? IconTheme.of(context).color,
    );
  }
}
