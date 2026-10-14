import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class ProfileSignOutButton extends StatelessWidget {
  final VoidCallback onSignOut;

  const ProfileSignOutButton({super.key, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          overlayColor: Colors.red.shade800,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: const Icon(Icons.logout_rounded, size: 20),
        label: Text(
          l10n.signOut,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        onPressed: onSignOut,
      ),
    );
  }
}
