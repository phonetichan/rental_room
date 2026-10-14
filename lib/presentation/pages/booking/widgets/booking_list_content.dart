import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/domain.dart';
import '../../../presentation.dart';

class BookingListContent extends StatelessWidget {
  final List<BookingEntity> rawBookings;
  final UserEntity currentUser;
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;
  final Future<void> Function() onRefresh;
  final Set<String> contractedBookingIds;

  const BookingListContent({
    super.key,
    required this.rawBookings,
    required this.currentUser,
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.onRefresh,
    this.contractedBookingIds = const {},
  });

  @override
  Widget build(BuildContext context) {
    final isOwner = currentUser.role == UserRole.owner;
    List<BookingEntity> displayedBookings = rawBookings;
    List<BookingEntity> validOwnerBookings = [];

    if (isOwner) {
      validOwnerBookings = rawBookings.where((b) {
        final status = b.status.toLowerCase();
        return status != 'draft' && status != 'cancelled';
      }).toList();

      if (selectedFilter == 'pending') {
        displayedBookings = validOwnerBookings
            .where((b) => b.status.toLowerCase() == 'pending')
            .toList();
      } else if (selectedFilter == 'confirmed') {
        displayedBookings = validOwnerBookings
            .where((b) => b.status.toLowerCase() == 'confirmed' && !contractedBookingIds.contains(b.id))
            .toList();
      } else {
        displayedBookings = validOwnerBookings
            .where((b) => b.status.toLowerCase() == 'pending')
            .toList();
      }
    } else {
      if (selectedFilter == 'pending') {
        displayedBookings = rawBookings
            .where((b) => b.status.toLowerCase() == 'pending')
            .toList();
      } else if (selectedFilter == 'confirmed') {
        displayedBookings = rawBookings
            .where((b) => b.status.toLowerCase() == 'confirmed' && !contractedBookingIds.contains(b.id))
            .toList();
      } else {
        displayedBookings = rawBookings
            .where((b) => b.status.toLowerCase() == 'pending')
            .toList();
      }
    }

    Widget listOrEmpty;
    if (displayedBookings.isEmpty) {
      listOrEmpty = SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 64,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                isOwner
                    ? (selectedFilter == 'pending'
                        ? 'No pending booking requests.'
                        : 'No confirmed booking requests.')
                    : (selectedFilter == 'pending'
                        ? 'No pending bookings.'
                        : 'No confirmed bookings.'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      listOrEmpty = ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: displayedBookings.length,
        itemBuilder: (context, index) {
          final booking = displayedBookings[index];
          final isConfirmedForOwner = isOwner && booking.status.toLowerCase() == 'confirmed';

          return BookingCard(
            booking: booking,
            currentUser: currentUser,
            onBookingUpdated: onRefresh,
            onTap: isConfirmedForOwner
                ? null // Do not route when owner clicks a confirmed booking
                : () async {
                    final result = await context.pushNamed<bool>(
                      'new-booking',
                      extra: booking,
                    );

                    if (result == true && context.mounted) {
                      onRefresh();
                    }
                  },
          );
        },
      );
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: listOrEmpty,
    );
  }
}

class BookingTabStreamView extends StatelessWidget {
  final Stream<List<BookingEntity>> stream;
  final List<BookingEntity>? cachedBookings;
  final ValueChanged<List<BookingEntity>> onCacheUpdate;
  final UserEntity currentUser;
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;
  final Future<void> Function() onRefresh;
  final Set<String> contractedBookingIds;

  const BookingTabStreamView({
    super.key,
    required this.stream,
    required this.cachedBookings,
    required this.onCacheUpdate,
    required this.currentUser,
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.onRefresh,
    this.contractedBookingIds = const {},
    required bool showFilterChips,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BookingEntity>>(
      stream: stream,
      initialData: cachedBookings,
      builder: (context, snapshot) {
        final bookings = snapshot.data;

        if (bookings == null) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (!listEquals(bookings, cachedBookings)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onCacheUpdate(bookings);
          });
        }

        return BookingListContent(
          rawBookings: bookings,
          currentUser: currentUser,
          selectedFilter: selectedFilter,
          onFilterSelected: onFilterSelected,
          onRefresh: onRefresh,
          contractedBookingIds: contractedBookingIds,
        );
      },
    );
  }
}
