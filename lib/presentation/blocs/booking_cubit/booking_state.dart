
part of 'booking_cubit.dart';

@freezed
abstract class BookingState with _$BookingState {
  const factory BookingState.initial() = BookingInitial;

  const factory BookingState.loading() = BookingLoading;

  const factory BookingState.loaded({
    @Default([]) List<BookingEntity> bookings,
  }) = BookingLoaded;

  const factory BookingState.success({
    required String message,
    BookingEntity? booking,
  }) = BookingSuccess;

  const factory BookingState.failure(String message) = BookingFailure;
}
