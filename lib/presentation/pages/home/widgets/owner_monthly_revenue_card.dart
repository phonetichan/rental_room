import 'package:flutter/material.dart';

import '../../../presentation.dart';

class OwnerMonthlyRevenueCard extends StatefulWidget {
  const OwnerMonthlyRevenueCard({super.key});

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
    final incomeValues = _monthlyIncomeData[_selectedMonth] ?? [0, 0, 0, 0];
    final double totalIncome = incomeValues.reduce((a, b) => a + b);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: AppColors.clrWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.clrSoftGrey),
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
                        color: AppColors.clrBlack,
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
                    color: AppColors.clrSofterGrey,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.clrSoftGrey),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedMonth,
                      icon: const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: AppColors.clrDarkGrey,
                      ),
                      isDense: true,
                      items: _months.map((String month) {
                        return DropdownMenuItem<String>(
                          value: month,
                          child: Text(
                            month,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.clrDarkerGrey,
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
                children: List.generate(incomeValues.length, (index) {
                  final value = incomeValues[index];
                  final maxVal = incomeValues.reduce(
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
                          color: AppColors.clrDarkGrey,
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
                          color: AppColors.clrDarkerGrey,
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
  }
}
