import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rental_room/domain/domain.dart';
import 'package:rental_room/domain/usecase/delete_booking_usecase.dart';

part 'booking_state.dart';
part 'booking_cubit.freezed.dart';

@injectable
class BookingCubit extends Cubit<BookingState> {
  final GetBookingsUseCase _getBookingsUseCase;
  final CreateBookingUseCase _createBookingUseCase;
  final UpdateBookingUseCase _updateBookingUseCase;
  final DeleteBookingUseCase _deleteBookingUseCase;
  final BookingRepository _bookingRepository;

  BookingCubit(
    this._getBookingsUseCase,
    this._createBookingUseCase,
    this._updateBookingUseCase,
    this._deleteBookingUseCase,
    this._bookingRepository,
  ) : super(const BookingState.initial());

  Future<void> fetchBookings(
    String id, {
    String? userId,
    String? roomId,
    String? ownerId,
  }) async {
    // Only emit loading if we don't already have bookings loaded
    if (state is! BookingLoaded) {
      emit(const BookingState.loading());
    }

    final effectiveUserId = userId ?? (ownerId == null && roomId == null ? id : null);
    final res = await _getBookingsUseCase(
      GetBookingsParams(userId: effectiveUserId, roomId: roomId, ownerId: ownerId),
    );

    res
      ..onSuccess((bookings) {
        emit(BookingState.loaded(bookings));
      })
      ..onError((failure) {
        if (state is! BookingLoaded) {
          emit(BookingState.failure(failure.reason));
        }
      });
  }

  Future<void> createBooking(BookingEntity booking, {bool silent = false}) async {
    if (!silent) {
      emit(const BookingState.loading());
    }
    final res = await _createBookingUseCase(booking);

    res
      ..onSuccess((created) {
        if (!silent) {
          emit(BookingState.success(
            message: 'Booking request created successfully!',
            booking: created,
          ));
        } else {
          emit(BookingState.success(
            message: '',
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
    List<BookingEntity>? currentBookings;
    if (state is BookingLoaded) {
      currentBookings = (state as BookingLoaded).bookings;
    }

    // Only emit loading if we don't already have loaded bookings in state
    if (currentBookings == null && !silent) {
      emit(const BookingState.loading());
    }

    final res = await _updateBookingUseCase(booking);

    res
      ..onSuccess((updated) {
        if (currentBookings != null) {
          final updatedList = currentBookings
              .map((b) => b.id == updated.id ? updated : b)
              .toList();
          if (!silent) {
            emit(BookingState.success(message: 'Booking updated successfully!', booking: updated));
          }
          emit(BookingState.loaded(updatedList));
        } else {
          if (!silent) {
            emit(BookingState.success(message: 'Booking updated successfully!', booking: updated));
          }
        }
      })
      ..onError((failure) {
        if (currentBookings == null && !silent) {
          emit(BookingState.failure(failure.reason));
        }
      });
  }

  Future<void> deleteBooking(String bookingId) async {
    List<BookingEntity>? currentBookings;
    if (state is BookingLoaded) {
      currentBookings = (state as BookingLoaded).bookings;
    }

    if (currentBookings == null) {
      emit(const BookingState.loading());
    }

    final res = await _deleteBookingUseCase(bookingId);

    res
      ..onSuccess((_) {
        if (currentBookings != null) {
          final updatedList = currentBookings.where((b) => b.id != bookingId).toList();
          emit(const BookingState.success(message: 'Booking request is successfully deleted!'));
          emit(BookingState.loaded(updatedList));
        } else {
          emit(const BookingState.success(message: 'Booking request is successfully deleted!'));
        }
      })
      ..onError((failure) {
        if (currentBookings == null) {
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
