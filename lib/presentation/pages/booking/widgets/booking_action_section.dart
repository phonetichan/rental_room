import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';

class BookingActionSection extends StatelessWidget {
  final BookingEntity? booking;
  final UserEntity currentUser;
  final VoidCallback onConfirmBooking;
  final VoidCallback? onCancelBooking;

  static const Color primaryAccent = Color(0xFFFF521B);

  const BookingActionSection({
    super.key,
    this.booking,
    required this.currentUser,
    required this.onConfirmBooking,
    this.onCancelBooking,
  });

  @override
  Widget build(BuildContext context) {
    if (booking == null) return const SizedBox.shrink();

    final isOwner = currentUser.role == UserRole.owner;
    final status = booking!.status.toLowerCase();

    if (status == 'cancelled') {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.withAlpha(38),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.withAlpha(128)),
        ),
        child: const Text(
          'This booking has been cancelled.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Column(
      children: [
        if (isOwner && status != 'confirmed') ...[
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.check_circle, size: 20),
              label: const Text(
                'Confirm Booking',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onPressed: onConfirmBooking,
            ),
          ),
          const SizedBox(height: 12),
        ],
        // Only non-owners (tenants) can cancel/delete requests. Owners can only confirm.
        if (!isOwner && onCancelBooking != null)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.redAccent,
                side: const BorderSide(color: Colors.redAccent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.cancel_outlined, size: 20),
              label: const Text(
                'Cancel Booking Request',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onPressed: onCancelBooking,
            ),
          ),
      ],
    );
  }
}
