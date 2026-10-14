import 'package:flutter/material.dart';

class RoomMetricWidget extends StatelessWidget {
  final IconData icon;
  final String label;

  const RoomMetricWidget({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 22),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
