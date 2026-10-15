import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/domain.dart';
import '../../../../blocs/blocs.dart';
import '../../../../extensions/l10n/l10n.dart';
import '../../../../extensions/number/number.dart';

/// Bottom action bar for tenant room detail screen (price & Rent Now / Request Details button).
class TenantRoomBottomActionBar extends StatelessWidget {
  final RoomEntity room;
  final UserEntity? currentUser;
  final bool isBookingLoading;
  final ValueChanged<UserEntity> onHandleBooking;
  final void Function(BookingEntity booking, UserEntity currentUser) onOpenExistingBooking;

  const TenantRoomBottomActionBar({
    super.key,
    required this.room,
    required this.currentUser,
    required this.isBookingLoading,
    required this.onHandleBooking,
    required this.onOpenExistingBooking,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                room.pricePerMonth.toKsFormat,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: BlocBuilder<BookingCubit, BookingState>(
              builder: (context, bookingState) {
                final existingBooking = bookingState.maybeWhen(
                  loaded: (bookings) {
                    try {
                      return bookings.firstWhere((b) => b.roomId == room.id);
                    } catch (_) {
                      return null;
                    }
                  },
                  orElse: () => null,
                );

                final isAlreadyBooked = existingBooking != null;
                final isRented = room.status.toLowerCase() == 'rented';

                if (isAlreadyBooked) {
                  return SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        side: BorderSide(color: primaryColor, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        if (currentUser != null) {
                          onOpenExistingBooking(existingBooking, currentUser!);
                        }
                      },
                      icon: const Icon(Icons.assignment_outlined, size: 20),
                      label: const Text(
                        'Request Detail',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }

                if (isRented) {
                  return SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.disabledColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: null,
                      icon: const Icon(Icons.block, size: 20),
                      label: const Text(
                        'Already Rented',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: (isBookingLoading || currentUser == null)
                        ? null
                        : () => onHandleBooking(currentUser!),
                    icon: isBookingLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.bookmark_add_outlined, size: 20),
                    label: Text(
                      context.l10n.rentNow,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
