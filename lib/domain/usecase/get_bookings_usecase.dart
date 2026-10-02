// import 'package:injectable/injectable.dart';
// import '../../core/core.dart';
// import '../entity/booking_entity.dart';
// import '../repository/booking_repository.dart';
//
// class GetBookingsParams {
//   final String? userId;
//   final String? roomId;
//   final String? ownerId;
//
//   const GetBookingsParams({this.userId, this.roomId, this.ownerId});
// }
//
// @lazySingleton
// class GetBookingsUseCase implements UseCase<DataState<List<BookingEntity>>, GetBookingsParams> {
//   final BookingRepository _repository;
//
//   const GetBookingsUseCase(this._repository);
//
//   @override
//   Future<DataState<List<BookingEntity>>> call(GetBookingsParams param) async {
//     try {
//       final bookings = await _repository.getBookings(
//         userId: param.userId,
//         roomId: param.roomId,
//         ownerId: param.ownerId,
//       );
//       return Success(bookings);
//     } catch (e) {
//       final cleanMsg = e.toString().replaceAll('Exception: ', '');
//       return Failed(DbFailure(cleanMsg));
//     }
//   }
// }


import 'package:injectable/injectable.dart';
import '../../core/core.dart';
import '../entity/booking_entity.dart';
import '../repository/booking_repository.dart';

class GetBookingsParams {
  final String? userId;
  final String? roomId;
  final String? ownerId;

  const GetBookingsParams({this.userId, this.roomId, this.ownerId});
}

@lazySingleton
class GetBookingsUseCase implements UseCase<DataState<List<BookingEntity>>, GetBookingsParams> {
  final BookingRepository _repository;

  const GetBookingsUseCase(this._repository);

  @override
  Future<DataState<List<BookingEntity>>> call(GetBookingsParams param) async {
    try {
      final bookings = await _repository.getBookings(
        userId: param.userId,
        roomId: param.roomId,
        ownerId: param.ownerId,
      );

      // OWNER ROLE: Filter out draft bookings so owner only sees submitted requests (e.g. pending)
      if (param.ownerId != null) {
        final filteredForOwner = bookings
            .where((booking) => booking.status.toLowerCase() != 'draft')
            .toList();
        return Success(filteredForOwner);
      }

      // TENANT ROLE: Return all bookings (including draft and pending)
      return Success(bookings);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}