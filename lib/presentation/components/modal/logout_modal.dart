import 'package:flutter/material.dart';

import '../button/confirm_cancel_button.dart';

class LogoutModal extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutModal({
    super.key,
    required this.onLogout,
  });

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onLogout,
  }) {
    return showDialog(
      context: context,
      builder: (dialogContext) => LogoutModal(onLogout: onLogout),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text(
        'Confirm Logout',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Text(
        'Are you sure you want to log out of your account?',
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [
        ConfirmCancelButtons(
          confirmText: 'Log Out',
          confirmColor: Colors.red,
          onConfirm: () {
            Navigator.pop(context);
            onLogout();
          },
          onCancel: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
