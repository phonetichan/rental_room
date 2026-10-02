import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';
import '../../../presentation.dart';

class OwnerMonthlyRevenueCard extends StatefulWidget {
  final UserEntity user;
  const OwnerMonthlyRevenueCard({super.key, required this.user});

  @override
  State<OwnerMonthlyRevenueCard> createState() =>
      _OwnerMonthlyRevenueCardState();
}

class _OwnerMonthlyRevenueCardState extends State<OwnerMonthlyRevenueCard> {
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  late String _selectedMonth;

  final Map<String, List<double>> _monthlyIncomeData = {
    'January': [1200, 1500, 1100, 1800],
    'February': [1400, 1600, 1300, 1900],
    'March': [1500, 1800, 1700, 2100],
    'April': [1600, 1400, 1800, 2200],
    'May': [1700, 1900, 2000, 2400],
    'June': [1800, 2100, 1900, 2500],
    'July': [2000, 2200, 2100, 2600],
    'August': [1900, 2000, 2300, 2700],
    'September': [2100, 2300, 2200, 2800],
    'October': [2200, 2400, 2500, 2900],
    'November': [2300, 2500, 2400, 3000],
    'December': [2500, 2800, 2700, 3200],
  };

  @override
  void initState() {
    super.initState();
    _selectedMonth = _months[DateTime.now().month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF2A2A2A) : AppColors.clrWhite;
    final borderColor = isDark ? Colors.white.withValues(alpha: 0.12) : AppColors.clrSoftGrey;
    final dropdownBgColor = isDark ? Colors.white.withValues(alpha: 0.08) : AppColors.clrSofterGrey;
    final textColor = isDark ? Colors.white : AppColors.clrBlack;
    final subtitleColor = isDark ? Colors.white70 : AppColors.clrDarkGrey;

    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, bookingState) {
        final List<BookingEntity> confirmedBookings = bookingState.maybeWhen(
          loaded: (bookings) => bookings
              .where((b) => b.ownerId == widget.user.id && b.status.toLowerCase() == 'confirmed')
              .toList(),
          orElse: () => [],
        );

        final double realTotal = confirmedBookings.fold(0.0, (sum, b) => sum + (b.roomPrice ?? 0.0));
        final incomeValues = _monthlyIncomeData[_selectedMonth] ?? [0, 0, 0, 0];
        final double totalIncome = realTotal > 0 ? realTotal : incomeValues.reduce((a, b) => a + b);
        final displayValues = realTotal > 0
            ? [totalIncome * 0.25, totalIncome * 0.25, totalIncome * 0.25, totalIncome * 0.25]
            : incomeValues;

        return Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: borderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly Revenue',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Total: \$${totalIncome.toStringAsFixed(0)}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.clrPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: dropdownBgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: borderColor),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedMonth,
                          dropdownColor: cardColor,
                          icon: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: subtitleColor,
                          ),
                          isDense: true,
                          items: _months.map((String month) {
                            return DropdownMenuItem<String>(
                              value: month,
                              child: Text(
                                month,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedMonth = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(displayValues.length, (index) {
                      final value = displayValues[index];
                      final maxVal = displayValues.reduce(
                        (a, b) => a > b ? a : b,
                      );
                      final double heightPercentage =
                          maxVal > 0 ? (value / maxVal) : 0;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '\$${value.toInt()}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: subtitleColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                            height: 120 * heightPercentage,
                            width: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.clrPrimary,
                                  AppColors.clrSecondary,
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'week ${index + 1}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
