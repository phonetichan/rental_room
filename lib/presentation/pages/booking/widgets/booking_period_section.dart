import 'package:flutter/material.dart';
import '../../../styles/colors.dart';

class BookingPeriodSection extends StatelessWidget {
  final String dateRangeText;

  const BookingPeriodSection({
    super.key,
    required this.dateRangeText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Period',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.clrBlack,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF3EDF7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.calendar_month_outlined,
                color: Color(0xFF7B51D3),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.clrGrey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dateRangeText,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.clrBlack,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.clrGrey,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Make sure to check your date before making any sort of payments', maxLines: 3,
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.clrGrey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
