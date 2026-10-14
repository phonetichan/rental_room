import 'package:flutter/material.dart';

import '../../../../extensions/l10n/l10n.dart';

/// Top bar floating delete button widget for room owner.
class OwnerRoomDeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const OwnerRoomDeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        tooltip: context.l10n.deleteRoom,
        icon: Icon(
          Icons.delete_outline_rounded,
          color: Colors.red.shade400,
          size: 22,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
