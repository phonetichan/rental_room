import 'package:flutter/material.dart';

import '../../extensions/l10n/l10n.dart';
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
    final l10n = context.l10n;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        l10n.logoutConfirmTitle,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(
        l10n.logoutConfirmMessage,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 14),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [
        ConfirmCancelButtons(
          confirmText: l10n.signOut,
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
