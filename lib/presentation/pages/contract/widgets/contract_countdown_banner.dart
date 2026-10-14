import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../extensions/contract/contract_extensions.dart';
import '../../../extensions/l10n/l10n.dart';

class ContractCountdownBanner extends StatelessWidget {
  final ContractEntity contract;
  const ContractCountdownBanner({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (contract.isExpired) {
      return _chip(Icons.event_busy, l10n.contractExpired, Colors.red);
    }
    if (contract.isOneMonthLeft) {
      final d = contract.daysLeft;
      return _chip(
        Icons.timer_outlined,
        l10n.daysLeft(d),
        Colors.orange,
      );
    }
    return const SizedBox.shrink(); // more than 1 month: show nothing
  }

  Widget _chip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}