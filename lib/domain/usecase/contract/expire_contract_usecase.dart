import 'package:injectable/injectable.dart';
import '../../domain.dart';

@lazySingleton
class ExpireContractUseCase {
  final ContractRepository _contractRepository;
  final RoomRepository _roomRepository;
  final BookingRepository _bookingRepository;

  ExpireContractUseCase(
    this._contractRepository,
    this._roomRepository,
    this._bookingRepository,
  );

  Future<ContractEntity> call(ContractEntity contract) async {
    final expiredContract = await _contractRepository.updateContract(
      contract.copyWith(status: ContractStatus.expired),
    );

    // Update room status to available if it was rented
    if (contract.roomId.isNotEmpty) {
      try {
        final room = await _roomRepository.getRoomById(contract.roomId);
        if (room != null && room.status == 'rented') {
          await _roomRepository.updateRoom(room.copyWith(status: 'available'));
        }
      } catch (_) {}
    }

    // Update booking status to expired
    if (contract.bookingId.isNotEmpty) {
      try {
        final booking = await _bookingRepository.getBookingById(contract.bookingId);
        if (booking != null && booking.status.toLowerCase() != 'expired') {
          await _bookingRepository.updateBooking(
            booking.copyWith(status: 'expired'),
          );
        }
      } catch (_) {}
    }

    return expiredContract;
  }
}
