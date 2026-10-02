import 'package:injectable/injectable.dart';
import '../../core/core.dart';
import '../entity/booking_entity.dart';
import '../repository/booking_repository.dart';

@lazySingleton
class CreateBookingUseCase implements UseCase<DataState<BookingEntity>, BookingEntity> {
  final BookingRepository _repository;

  const CreateBookingUseCase(this._repository);

  @override
  Future<DataState<BookingEntity>> call(BookingEntity booking) async {
    try {
      final created = await _repository.createBooking(booking);
      return Success(created);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}
