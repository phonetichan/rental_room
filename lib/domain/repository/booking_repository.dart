import '../entity/booking_entity.dart';

abstract class BookingRepository {
  Future<List<BookingEntity>> getBookings({String? userId, String? roomId, String? ownerId});
  Future<BookingEntity?> getBookingById(String bookingId);
  Future<BookingEntity> createBooking(BookingEntity booking);
  Future<BookingEntity> updateBooking(BookingEntity booking);
  Future<void> deleteBooking(String bookingId);
  Future<void> cancelOtherPendingBookingsForRoom(String roomId, String exceptedBookingId);
  Stream<List<BookingEntity>> watchBookings({String? userId, String? roomId, String? ownerId});
}
