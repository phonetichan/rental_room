import 'package:injectable/injectable.dart';
import '../../../core/core.dart';
import '../../entity/booking/booking_entity.dart';
import '../../repository/booking/booking_repository.dart';

@lazySingleton
class UpdateBookingUseCase implements UseCase<DataState<BookingEntity>, BookingEntity> {
  final BookingRepository _repository;

  const UpdateBookingUseCase(this._repository);

  @override
  Future<DataState<BookingEntity>> call(BookingEntity booking) async {
    try {
      final updated = await _repository.updateBooking(booking);
      return Success(updated);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}
