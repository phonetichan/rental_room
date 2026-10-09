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

  List<BookingEntity>? _cachedBookings;
  List<BookingEntity>? get cachedBookings => _cachedBookings;
  bool get isReady => _cachedBookings != null;

  BookingCubit(
    this._getBookingsUseCase,
    this._createBookingUseCase,
    this._updateBookingUseCase,
    this._deleteBookingUseCase,
    this._bookingRepository,
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
        final old = _cachedBookings;
        if (old != null && _same(old, fresh)) return; // no change -> do nothing
        _emitLoaded(fresh); // changed (or first load) -> update instantly
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

  Future<void> deleteBooking(String bookingId) async {
    final res = await _deleteBookingUseCase(bookingId);

    res
      ..onSuccess((_) {
        if (_cachedBookings != null) {
          final updatedList = _cachedBookings!.where((b) => b.id != bookingId).toList();
          _emitLoaded(updatedList);
        }
        emit(const BookingState.success(message: 'Booking request is successfully deleted!'));
      })
      ..onError((failure) {
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
