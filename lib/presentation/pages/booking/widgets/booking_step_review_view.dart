import 'package:flutter/material.dart';

import '../../../extensions/l10n/l10n.dart';
import '../../../extensions/number/number.dart';

class BookingStepReviewView extends StatelessWidget {
  final bool isPhoneContacted;
  final bool isVisited;
  final double monthlyRent;
  final bool isConfirmed;
  final bool isOwner;
  final bool isReadOnly;
  final VoidCallback onViewVoucher;
  final VoidCallback onDeleteBooking;
  final VoidCallback? onConfirmBooking;

  const BookingStepReviewView({
    super.key,
    required this.isPhoneContacted,
    required this.isVisited,
    required this.monthlyRent,
    required this.isConfirmed,
    required this.isOwner,
    required this.isReadOnly,
    required this.onViewVoucher,
    required this.onDeleteBooking,
    this.onConfirmBooking,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardBackground = theme.cardColor;
    final primaryAccent = theme.colorScheme.primary;
    final borderColor = theme.dividerColor;
    final textPrimary = theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
    final textSecondary = theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurfaceVariant;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.stepReviewSubmit,
          style: TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.stepReviewSubmitDesc,maxLines: 3,
          style: TextStyle(color: textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            children: [
              _buildReviewRow(context, l10n.phoneContacted, isPhoneContacted),
              Divider(color: borderColor, height: 24),
              _buildReviewRow(context, l10n.roomVisited, isVisited),
              Divider(color: borderColor, height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.monthlyRent,
                    style: TextStyle(color: textSecondary),
                  ),
                  Text(
                    monthlyRent.toKsLabelFormat,
                    style: TextStyle(
                      color: primaryAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (isOwner && !isConfirmed && onConfirmBooking != null) ...[
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.check_circle_rounded),
              label: Text(
                l10n.confirmBooking,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: onConfirmBooking,
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (!isOwner && isConfirmed) ...[
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.description_outlined),
              label: Text(
                l10n.viewRentalContractVoucher,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: onViewVoucher,
            ),
          ),
          const SizedBox(height: 16),
        ],
        // Delete / Cancel Booking Button (tenant can delete only before submitting request to owner)
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: (isReadOnly && !isOwner) ? theme.disabledColor : Colors.redAccent,
              side: BorderSide(
                color: (isReadOnly && !isOwner) ? theme.disabledColor : Colors.redAccent,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: Icon(
              Icons.delete_outline,
              size: 20,
              color: (isReadOnly && !isOwner) ? theme.disabledColor : Colors.redAccent,
            ),
            label: Text(
              (isReadOnly && !isOwner)
                  ? 'Request Submitted (Cannot Delete)'
                  : (isConfirmed
                      ? 'Booking Confirmed'
                      : (isOwner ? 'Cancel Request' : l10n.deleteRequest)),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: (isReadOnly && !isOwner) ? theme.disabledColor : Colors.redAccent,
              ),
            ),
            onPressed: (isReadOnly && !isOwner) ? null : onDeleteBooking,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewRow(BuildContext context, String title, bool isCompleted) {
    final l10n = context.l10n;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              isCompleted ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
              color: isCompleted ? Colors.green : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: (isCompleted ? Colors.green : Colors.orange).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            isCompleted ? l10n.completed : l10n.pending,
            style: TextStyle(
              color: isCompleted ? Colors.green : Colors.orange,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
