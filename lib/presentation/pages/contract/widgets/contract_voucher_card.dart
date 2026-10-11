import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../styles/colors.dart';
import '../../../extensions/l10n.dart';
import 'contract_voucher_header.dart';
import 'contract_voucher_financial_section.dart';

class ContractVoucherCard extends StatelessWidget {
  final ContractEntity contract;
  final RoomEntity? room;
  final double? depositAmount;
  final String? depositReceiverName;

  const ContractVoucherCard({
    super.key,
    required this.contract,
    this.room,
    this.depositAmount,
    this.depositReceiverName,
  });

  String _formatDate(BuildContext context, DateTime date) {
    final l10n = context.l10n;
    final months = [
      l10n.monthJan,
      l10n.monthFeb,
      l10n.monthMar,
      l10n.monthApr,
      l10n.monthMay,
      l10n.monthJun,
      l10n.monthJul,
      l10n.monthAug,
      l10n.monthSep,
      l10n.monthOct,
      l10n.monthNov,
      l10n.monthDec,
    ];
    return '${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = AppColors.clrPrimary;
    final l10n = context.l10n;

    final double? effectiveDeposit = depositAmount ?? room?.depositeAmount;
    final String? effectiveReceiver =
        depositReceiverName ?? room?.agentName; // Use depositReceiverName here

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
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
            ContractVoucherHeader(durationMonth: contract.durationMonth),

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
                          l10n.contractId,
                          '#${contract.id.substring(0, contract.id.length > 8 ? 8 : contract.id.length).toUpperCase()}',
                          Icons.receipt_long_outlined,
                        ),
                      ),
                      Expanded(
                        child: _buildInfoColumn(
                          context,
                          l10n.bookingId,
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
                          l10n.startDate,
                          _formatDate(context, contract.startDate),
                          Icons.calendar_today_outlined,
                        ),
                      ),
                      Expanded(
                        child: _buildInfoColumn(
                          context,
                          l10n.endDate,
                          _formatDate(context, contract.endDate),
                          Icons.event_available_outlined,
                          crossAlignment: CrossAxisAlignment.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 16),

                  // Financial Breakdown Section
                  ContractVoucherFinancialSection(
                    monthlyRent: contract.monthlyRent,
                    durationMonth: contract.durationMonth,
                    depositAmount: effectiveDeposit,
                    depositReceiverName: effectiveReceiver,
                    agentFees: room?.agentFees,
                    agentName: effectiveReceiver,
                  ),

                  if (contract.description.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    Text(
                      l10n.termsAndNotes,
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
