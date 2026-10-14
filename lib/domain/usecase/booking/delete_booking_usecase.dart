import 'package:injectable/injectable.dart';
import '../../../../core/core.dart';
import '../../repository/booking/booking_repository.dart';

@lazySingleton
class DeleteBookingUseCase implements UseCase<DataState<void>, String> {
  final BookingRepository _repository;

  const DeleteBookingUseCase(this._repository);

  @override
  Future<DataState<void>> call(String bookingId) async {
    try {
      await _repository.deleteBooking(bookingId);
      return const Success(null);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}
