import 'package:flutter/material.dart';
import '../../../extensions/extensions.dart';
import '../../../styles/colors.dart';

class BookingPriceDetailsSection extends StatelessWidget {
  final int durationMonths;
  final double monthlyRent;
  final double? depositAmount;
  final double? agentFees;

  const BookingPriceDetailsSection({
    super.key,
    required this.durationMonths,
    required this.monthlyRent,
    this.depositAmount,
    this.agentFees,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    final double rentSubtotal = monthlyRent * durationMonths;
    final double dep = depositAmount ?? 0.0;
    final double fees = agentFees ?? 0.0;
    final double grandTotal = rentSubtotal + dep + fees;

    final formattedMonthly = context.localizedNumber(monthlyRent.toKsLabelFormat);
    final formattedDeposit = dep > 0 ? context.localizedNumber(dep.toKsLabelFormat) : null;
    final formattedAgentFees = fees > 0 ? context.localizedNumber(fees.toKsLabelFormat) : null;
    final formattedTotal = context.localizedNumber(grandTotal.toKsLabelFormat);

    final countText = context.localizedNumber(durationMonths);
    final durationText = durationMonths == 1
        ? l10n.bookingMonthSingular(countText)
        : l10n.bookingMonthPlural(countText);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.bookingPriceDetails,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.clrBlack,
          ),
        ),
        const SizedBox(height: 16),
        _buildPriceRow(context, l10n.bookingPeriodTime, durationText),
        const SizedBox(height: 12),
        _buildPriceRow(context, l10n.bookingMonthlyPayment, formattedMonthly),
        if (dep > 0) ...[
          const SizedBox(height: 12),
          _buildPriceRow(context, l10n.securityDeposit, formattedDeposit!),
        ],
        if (fees > 0) ...[
          const SizedBox(height: 12),
          _buildPriceRow(context, l10n.agentFees, formattedAgentFees!),
        ],
        const SizedBox(height: 12),
        _buildPriceRow(context, l10n.bookingTax, '${context.localizedNumber(0)} Ks'),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.bookingTotal,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.clrBlack,
              ),
            ),
            Text(
              formattedTotal,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF7B51D3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.clrGrey,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.clrBlack,
          ),
        ),
      ],
    );
  }
}