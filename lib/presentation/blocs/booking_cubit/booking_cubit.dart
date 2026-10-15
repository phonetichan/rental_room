import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rental_room/domain/domain.dart';
import 'package:rental_room/domain/usecase/booking/delete_booking_usecase.dart';

part 'booking_state.dart';
part 'booking_cubit.freezed.dart';

@injectable
class BookingCubit extends Cubit<BookingState> {
  final GetBookingsUseCase _getBookingsUseCase;
  final CreateBookingUseCase _createBookingUseCase;
  final UpdateBookingUseCase _updateBookingUseCase;
  final DeleteBookingUseCase _deleteBookingUseCase;
  final BookingRepository _bookingRepository;
  final RoomRepository _roomRepository;
  final CreateContractUseCase _createContractUseCase;

  List<BookingEntity>? _cachedBookings;
  List<BookingEntity>? get cachedBookings => _cachedBookings;
  bool get isReady => _cachedBookings != null;
  final Set<String> _recentlyDeletedBookingIds = {};

  BookingCubit(
    this._getBookingsUseCase,
    this._createBookingUseCase,
    this._updateBookingUseCase,
    this._deleteBookingUseCase,
    this._bookingRepository,
    this._roomRepository,
    this._createContractUseCase,
  ) : super(const BookingState.initial());

  bool _same(List<BookingEntity> a, List<BookingEntity> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  void _emitLoaded(List<BookingEntity> bookings) {
    _cachedBookings = bookings;
    emit(BookingState.loaded(bookings));
  }

  Future<void> fetchBookings(
    String id, {
    String? userId,
    String? roomId,
    String? ownerId,
  }) async {
    // Loading ONLY when there is nothing to show yet
    if (!isReady) emit(const BookingState.loading());

    final effectiveUserId =
        userId ?? (ownerId == null && roomId == null ? id : null);

    final res = await _getBookingsUseCase(
      GetBookingsParams(
          userId: effectiveUserId, roomId: roomId, ownerId: ownerId),
    );

    res
      ..onSuccess((fresh) {
        final filteredFresh = fresh
            .where((b) => !_recentlyDeletedBookingIds.contains(b.id))
            .toList();
        final old = _cachedBookings;
        if (old != null && _same(old, filteredFresh)) return; // no change -> do nothing
        _emitLoaded(filteredFresh); // changed (or first load) -> update instantly
      })
      ..onError((failure) {
        if (isReady) {
          // Keep the current list, only notify
          emit(BookingState.failure(failure.reason));
          emit(BookingState.loaded(_cachedBookings!));
        } else {
          emit(BookingState.failure(failure.reason));
        }
      });
  }

  /// Call when switching user/owner/room so old data doesn't show.
  void clear() {
    _cachedBookings = null;
    emit(const BookingState.initial());
  }

  Future<void> createBooking(BookingEntity booking, {bool silent = false}) async {
    if (!silent && !isReady) {
      emit(const BookingState.loading());
    }
    final res = await _createBookingUseCase(booking);

    res
      ..onSuccess((created) {
        if (_cachedBookings != null) {
          final updatedList = [..._cachedBookings!, created];
          _emitLoaded(updatedList);
        }
        if (!silent) {
          emit(BookingState.success(
            message: 'Booking request created successfully!',
            booking: created,
          ));
        }
      })
      ..onError((failure) {
        if (!silent) {
          emit(BookingState.failure(failure.reason));
        }
      });
  }

  Future<void> updateBooking(BookingEntity booking, {bool silent = false}) async {
    final res = await _updateBookingUseCase(booking);

    res
      ..onSuccess((updated) {
        if (_cachedBookings != null) {
          final updatedList = _cachedBookings!
              .map((b) => b.id == updated.id ? updated : b)
              .toList();
          _emitLoaded(updatedList);
        }
        if (!silent) {
          emit(BookingState.success(message: 'Booking updated successfully!', booking: updated));
        }
      })
      ..onError((failure) {
        if (!silent) {
          emit(BookingState.failure(failure.reason));
        }
      });
  }

  Future<void> confirmBooking(BookingEntity booking) async {
    final confirmedBooking = booking.copyWith(
      status: 'confirmed',
      isReadByOwner: true,
      isReadByTenant: false,
      updatedAt: DateTime.now(),
    );

    final res = await _updateBookingUseCase(confirmedBooking);

    await res.onSuccess((updated) async {
      try {
        // 1. Update room status to 'rented'
        final room = await _roomRepository.getRoomById(updated.roomId);
        if (room != null) {
          final rentedRoom = room.copyWith(
            status: 'rented',
            updatedAt: DateTime.now(),
          );
          await _roomRepository.updateRoom(rentedRoom);
        }

        // 2. Create automatic contract (minimum duration 3 months)
        final now = DateTime.now();
        int targetYear = now.year;
        int targetMonth = now.month + 3;
        while (targetMonth > 12) {
          targetMonth -= 12;
          targetYear += 1;
        }
        int targetDay = now.day;
        final lastDayOfMonth = DateTime(targetYear, targetMonth + 1, 0).day;
        if (targetDay > lastDayOfMonth) targetDay = lastDayOfMonth;
        final endDate = DateTime(targetYear, targetMonth, targetDay);

        final newContract = ContractEntity(
          id: '',
          bookingId: updated.id,
          roomId: updated.roomId,
          ownerId: updated.ownerId ?? '',
          tenantId: updated.userId,
          startDate: now,
          endDate: endDate,
          durationMonth: 3,
          monthlyRent: updated.roomPrice ?? 0.0,
          description:
              'Standard Rental Agreement for ${updated.roomName}. Minimum duration 3 months.',
          createdAt: now,
        );
        await _createContractUseCase(newContract);

        // 3. Cancel other pending/draft requests for this room
        await _bookingRepository.cancelOtherPendingBookingsForRoom(
          updated.roomId,
          updated.id,
        );
      } catch (e) {
        debugPrint('❌ Error during booking confirmation post-processing: $e');
      }

      if (_cachedBookings != null) {
        final updatedList = _cachedBookings!
            .map((b) => b.id == updated.id ? updated : b)
            .toList();
        _emitLoaded(updatedList);
      }

      emit(BookingState.success(
        message: 'Booking request confirmed! Room status updated to rented.',
        booking: updated,
      ));
    });

    res.onError((failure) {
      emit(BookingState.failure(failure.reason));
    });
  }

  Future<void> deleteBooking(String bookingId) async {
    _recentlyDeletedBookingIds.add(bookingId);
    final res = await _deleteBookingUseCase(bookingId);

    res
      ..onSuccess((_) {
        if (_cachedBookings != null) {
          final updatedList = _cachedBookings!.where((b) => b.id != bookingId).toList();
          _emitLoaded(updatedList);
        }
        emit(const BookingState.success(message: 'Booking request is successfully deleted!'));
        Future.delayed(const Duration(seconds: 3), () {
          _recentlyDeletedBookingIds.remove(bookingId);
        });
      })
      ..onError((failure) {
        _recentlyDeletedBookingIds.remove(bookingId);
        if (!isReady) {
          emit(BookingState.failure(failure.reason));
        }
      });
  }

  Stream<List<BookingEntity>> watchBookings({
    String? userId,
    String? roomId,
    String? ownerId,
  }) {
    return _bookingRepository.watchBookings(userId: userId, roomId: roomId, ownerId: ownerId);
  }
}
