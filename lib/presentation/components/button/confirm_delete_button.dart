import 'package:flutter/material.dart';

class ConfirmCancelButtons extends StatelessWidget {
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final bool isConfirmLoading;
  final Color? confirmColor;
  final bool isDelete; // Flag to enable delete styling

  const ConfirmCancelButtons({
    super.key,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    required this.onConfirm,
    required this.onCancel,
    this.isConfirmLoading = false,
    this.confirmColor,
    this.isDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    // Automatically use Red if isDelete is true, unless a custom confirmColor is passed
    final effectiveConfirmColor = isDelete
        ? (confirmColor ?? Colors.red.shade600)
        : (confirmColor ?? Theme.of(context).primaryColor);

    // If confirmText wasn't explicitly changed and it's a delete action, display 'Delete'
    final effectiveConfirmText =
    (isDelete && confirmText == 'Confirm') ? 'Delete' : confirmText;

    return Row(
      children: [
        // Cancel Button
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: isConfirmLoading ? null : onCancel,
            child: Text(
              cancelText,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Confirm / Delete Button
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: effectiveConfirmColor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: isConfirmLoading ? null : onConfirm,
            child: isConfirmLoading
                ? const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isDelete) ...[
                  const Icon(
                    Icons.delete_outline_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  effectiveConfirmText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}