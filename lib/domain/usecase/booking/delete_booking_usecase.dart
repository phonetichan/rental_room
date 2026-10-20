import 'package:injectable/injectable.dart';
import '../../../../core/core.dart';
import '../../repository/booking/booking_repository.dart';

class DeleteBookingParams {
  final String bookingId;
  final bool isOwner;

  const DeleteBookingParams({
    required this.bookingId,
    required this.isOwner,
  });
}

@lazySingleton
class DeleteBookingUseCase implements UseCase<DataState<void>, DeleteBookingParams> {
  final BookingRepository _repository;

  const DeleteBookingUseCase(this._repository);

  @override
  Future<DataState<void>> call(DeleteBookingParams params) async {
    try {
      await _repository.deleteBooking(params.bookingId, isOwner: params.isOwner);
      return const Success(null);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}
