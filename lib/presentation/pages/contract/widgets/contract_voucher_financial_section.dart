import 'package:flutter/material.dart';
import '../../../styles/colors.dart';
import '../../../extensions/extensions.dart';

class ContractVoucherFinancialSection extends StatelessWidget {
  final double monthlyRent;
  final int durationMonth;
  final double? depositAmount;
  final double? agentFees;
  final String? agentName;

  const ContractVoucherFinancialSection({
    super.key,
    required this.monthlyRent,
    required this.durationMonth,
    this.depositAmount,
    this.agentFees,
    this.agentName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = AppColors.clrPrimary;
    final l10n = context.l10n;

    final double durationRentTotal = monthlyRent * durationMonth;
    final double dep = depositAmount ?? 0.0;
    final double fees = agentFees ?? 0.0;
    final double grandTotal = durationRentTotal + dep + fees;

    final String depositStr = dep > 0 ? dep.toLocalizedKsShortFormat(context) : '-';
    final String agentFeesStr = fees > 0 ? fees.toLocalizedKsShortFormat(context) : '-';
    final String agentNameStr =
    (agentName != null && agentName!.trim().isNotEmpty) ? agentName! : '-';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.financialSummary,
          style: theme.textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _buildSummaryRow(context, l10n.monthlyRent, monthlyRent.toLocalizedKsFormat(context)), // "/ month"
        const SizedBox(height: 6),
        _buildSummaryRow(context, l10n.rentSubtotal(durationMonth), durationRentTotal.toLocalizedKsShortFormat(context)),
        const SizedBox(height: 6),
        _buildSummaryRow(context, l10n.securityDeposit, depositStr),
        const SizedBox(height: 6),
        _buildSummaryRow(context, l10n.agentFees, agentFeesStr),
        const SizedBox(height: 6),
        _buildSummaryRow(context, l10n.agentName, agentNameStr),
        const SizedBox(height: 12),
        const Divider(height: 1, thickness: 1),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.totalPaymentDue,
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              grandTotal.toLocalizedKsShortFormat(context),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
