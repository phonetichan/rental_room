import 'package:flutter/material.dart';
import 'location_constants.dart';

/// Fixed Pin indicator located precisely at the map center.
class CenterPinOverlay extends StatelessWidget {
  const CenterPinOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 48),
          child: Icon(Icons.location_on, size: 56, color: kPin),
        ),
      ),
    );
  }
}
