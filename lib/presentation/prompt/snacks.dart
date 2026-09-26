import 'package:flutter/material.dart';
import 'package:rental_room/presentation/extensions/extensions.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum SnackGravity { top, bottom }

abstract interface class Snacks {
  static void _showMessage(
    BuildContext context, {
    required String message,
    SnackGravity gravity = SnackGravity.top,
    Color? backgroundColor,
    Color? textColor,
  }) {
    showTopSnackBar(
      Overlay.of(context, rootOverlay: true),
      OverflowControlSnackText(
        message: message,
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
    );
  }

  static void info(
    BuildContext context, {
    required String message,
    SnackGravity gravity = SnackGravity.top,
  }) {
    _showMessage(
      context,
      message: message,
      gravity: gravity,
      backgroundColor: context.theme.colorScheme.onSurface,
      textColor: context.theme.colorScheme.surface,
    );
  }

  static void error(
    BuildContext context, {
    required String message,
    SnackGravity gravity = SnackGravity.top,
  }) {
    _showMessage(
      context,
      message: message,
      gravity: gravity,
      backgroundColor: Color.lerp(
        context.theme.colorScheme.error,
        context.theme.scaffoldBackgroundColor,
        0.3,
      ),
      textColor: Colors.white,
    );
  }

  static void success(
    BuildContext context, {
    required String message,
    SnackGravity gravity = SnackGravity.top,
  }) {
    _showMessage(
      context,
      message: message,
      gravity: gravity,
      backgroundColor: context.theme.primaryColor,
      textColor: Colors.white,
    );
  }
}

class OverflowControlSnackText extends StatelessWidget {
  final String message;
  final Color? backgroundColor;
  final Color? textColor;

  const OverflowControlSnackText({
    super.key,
    required this.message,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.bodyMedium?.copyWith(
      color: textColor ?? context.theme.primaryColor,
    );

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.theme.cardColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Text(
        message,
        textAlign: TextAlign.center,
        maxLines: 3,
        style: textStyle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
