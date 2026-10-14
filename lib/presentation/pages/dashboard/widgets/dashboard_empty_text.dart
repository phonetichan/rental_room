import 'package:flutter/material.dart';

class DashboardEmptyText extends StatelessWidget {
  final String text;

  const DashboardEmptyText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(color: Colors.grey.shade600)),
    );
  }
}
