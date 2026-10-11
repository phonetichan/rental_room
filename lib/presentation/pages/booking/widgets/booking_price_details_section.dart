import 'package:flutter/material.dart';
import '../../../styles/colors.dart';
import '../../../extensions/number.dart';

class BookingPriceDetailsSection extends StatelessWidget {
  final int durationMonths;
  final double monthlyRent;

  const BookingPriceDetailsSection({
    super.key,
    required this.durationMonths,
    required this.monthlyRent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalAmount = monthlyRent * durationMonths;

    final formattedMonthly = monthlyRent.toKsLabelFormat;
    final formattedTotal = totalAmount.toKsLabelFormat;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Details',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.clrBlack,
          ),
        ),
        const SizedBox(height: 16),
        _buildPriceRow(
          context,
          'Period time',
          '$durationMonths ${durationMonths == 1 ? 'Month' : 'Months'}',
        ),
        const SizedBox(height: 12),
        _buildPriceRow(context, 'Monthly payment', formattedMonthly),
        const SizedBox(height: 12),
        _buildPriceRow(context, 'Tax', '0 Ks'),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
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
