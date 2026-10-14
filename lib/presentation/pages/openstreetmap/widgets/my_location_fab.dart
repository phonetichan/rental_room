import 'package:flutter/material.dart';
import 'location_constants.dart';

/// Floating Action Button for jumping to GPS current location.
class MyLocationFab extends StatelessWidget {
  final VoidCallback onPressed;

  const MyLocationFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: Colors.white,
      onPressed: onPressed,
      child: const Icon(Icons.my_location, color: kPrimary),
    );
  }
}
