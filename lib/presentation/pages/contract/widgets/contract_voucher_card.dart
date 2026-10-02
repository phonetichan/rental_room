// import 'package:flutter/material.dart';
//
// import '../../../../domain/domain.dart';
// import '../../../styles/colors.dart';
//
// class ContractVoucherCard extends StatelessWidget {
//   final ContractEntity contract;
//
//   const ContractVoucherCard({super.key, required this.contract});
//
//   String _formatDate(DateTime date) {
//     const months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec'
//     ];
//     return '${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final primaryColor = AppColors.clrPrimary;
//
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: primaryColor.withValues(alpha: 0.3), width: 1.5),
//         boxShadow: [
//           BoxShadow(
//             color: primaryColor.withValues(alpha: 0.08),
//             blurRadius: 16,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Voucher Header Ribbon
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [primaryColor, primaryColor.withValues(alpha: 0.8)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Expanded(
//                     child: Row(
//                       children: [
//                         Icon(Icons.verified_rounded, color: Colors.white, size: 18),
//                         SizedBox(width: 6),
//                         Expanded(
//                           child: Text(
//                             'RENTAL AGREEMENT VOUCHER',
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 0.8,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withValues(alpha: 0.25),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       '${contract.durationMonth} Months',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Voucher Body
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildInfoColumn(
//                         context,
//                         'Contract ID',
//                         '#${contract.id.substring(0, contract.id.length > 8 ? 8 : contract.id.length).toUpperCase()}',
//                         Icons.receipt_long_outlined,
//                       ),
//                       _buildInfoColumn(
//                         context,
//                         'Booking ID',
//                         '#${contract.bookingId.substring(0, contract.bookingId.length > 8 ? 8 : contract.bookingId.length).toUpperCase()}',
//                         Icons.bookmark_outline,
//                         crossAlignment: CrossAxisAlignment.end,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   const Divider(height: 1, thickness: 1),
//                   const SizedBox(height: 16),
//
//                   // Dates Row
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildInfoColumn(
//                         context,
//                         'Start Date',
//                         _formatDate(contract.startDate),
//                         Icons.calendar_today_outlined,
//                       ),
//                       _buildInfoColumn(
//                         context,
//                         'End Date',
//                         _formatDate(contract.endDate),
//                         Icons.event_available_outlined,
//                         crossAlignment: CrossAxisAlignment.end,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//
//                   // Financials Row
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildInfoColumn(
//                         context,
//                         'Monthly Rent',
//                         '\$${contract.monthlyRent.toStringAsFixed(2)}',
//                         Icons.attach_money_rounded,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   const Divider(height: 1, thickness: 1),
//                   const SizedBox(height: 16),
//
//                   // Description / Terms
//                   Text(
//                     'Terms & Description',
//                     style: TextStyle(
//                       color: isDark ? Colors.grey[400] : Colors.grey[600],
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     contract.description,
//                     maxLines: 2,
//                     style: TextStyle(
//                       color: theme.textTheme.bodyLarge?.color,
//                       fontSize: 13,
//                       height: 1.4,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoColumn(
//     BuildContext context,
//     String label,
//     String value,
//     IconData icon, {
//     CrossAxisAlignment crossAlignment = CrossAxisAlignment.start,
//   }) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Column(
//       crossAxisAlignment: crossAlignment,
//       children: [
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, size: 14, color: AppColors.clrPrimary),
//             const SizedBox(width: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 color: isDark ? Colors.grey[400] : Colors.grey[600],
//                 fontSize: 11,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: TextStyle(
//             color: theme.textTheme.bodyLarge?.color,
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../styles/colors.dart';

class ContractVoucherCard extends StatelessWidget {
  final ContractEntity contract;

  const ContractVoucherCard({super.key, required this.contract});

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = AppColors.clrPrimary;

    // Financial calculations without deposit
    final double durationRentTotal = contract.monthlyRent * contract.durationMonth;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Ribbon
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withValues(alpha: 0.85)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.verified_rounded, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'RENTAL AGREEMENT VOUCHER',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${contract.durationMonth} Months',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Voucher Body
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ID Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoColumn(
                          context,
                          'Contract ID',
                          '#${contract.id.substring(0, contract.id.length > 8 ? 8 : contract.id.length).toUpperCase()}',
                          Icons.receipt_long_outlined,
                        ),
                      ),
                      Expanded(
                        child: _buildInfoColumn(
                          context,
                          'Booking ID',
                          '#${contract.bookingId.substring(0, contract.bookingId.length > 8 ? 8 : contract.bookingId.length).toUpperCase()}',
                          Icons.bookmark_outline,
                          crossAlignment: CrossAxisAlignment.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 16),

                  // Dates Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoColumn(
                          context,
                          'Start Date',
                          _formatDate(contract.startDate),
                          Icons.calendar_today_outlined,
                        ),
                      ),
                      Expanded(
                        child: _buildInfoColumn(
                          context,
                          'End Date',
                          _formatDate(contract.endDate),
                          Icons.event_available_outlined,
                          crossAlignment: CrossAxisAlignment.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 16),

                  // Financial Breakdown
                  Text(
                    'Financial Summary',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSummaryRow(
                    context,
                    'Monthly Rent',
                    '\$${contract.monthlyRent.toStringAsFixed(2)} / mo',
                  ),
                  const SizedBox(height: 6),
                  _buildSummaryRow(
                    context,
                    'Rent Subtotal (${contract.durationMonth} mos)',
                    '\$${durationRentTotal.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, thickness: 1),
                  const SizedBox(height: 12),

                  // Total Amount Highlight
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Payment Due',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${durationRentTotal.toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  if (contract.description.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    Text(
                      'Terms & Notes',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      contract.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.3,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildInfoColumn(
      BuildContext context,
      String label,
      String value,
      IconData icon, {
        CrossAxisAlignment crossAlignment = CrossAxisAlignment.start,
      }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: crossAlignment,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppColors.clrPrimary),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}