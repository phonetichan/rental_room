import 'package:injectable/injectable.dart';

import '../../di/di.dart';
import '../../domain/entity/booking_entity.dart';
import '../../domain/repository/booking_repository.dart';
import '../../domain/repository/room_repository.dart';
import '../datasource/remote/booking_data_source.dart';
import '../model/booking_model.dart';

@LazySingleton(as: BookingRepository)
class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource _remoteDataSource;

  BookingRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<BookingEntity>> getBookings({String? userId, String? roomId, String? ownerId}) async {
    final bookingModels = await _remoteDataSource.getBookings(
      userId: userId,
      roomId: roomId,
      ownerId: ownerId,
    );

    final entities = <BookingEntity>[];
    for (final model in bookingModels) {
      var entity = model.toEntity();
      if ((entity.roomName == null || entity.roomName!.isEmpty) && entity.roomId.isNotEmpty) {
        try {
          final roomRepo = inject<RoomRepository>();
          final room = await roomRepo.getRoomById(entity.roomId);
          if (room != null) {
            entity = entity.copyWith(
              roomName: room.name,
              roomPrice: room.pricePerMonth,
              roomImageUrl: room.images.isNotEmpty ? room.images.first.imageUrl : null,
            );
          }
        } catch (_) {}
      }
      entities.add(entity);
    }
    return entities;
  }

  @override
  Future<BookingEntity?> getBookingById(String bookingId) async {
    final model = await _remoteDataSource.getBookingById(bookingId);
    if (model == null) return null;
    var entity = model.toEntity();
    if ((entity.roomName == null || entity.roomName!.isEmpty) && entity.roomId.isNotEmpty) {
      try {
        final roomRepo = inject<RoomRepository>();
        final room = await roomRepo.getRoomById(entity.roomId);
        if (room != null) {
          entity = entity.copyWith(
            roomName: room.name,
            roomPrice: room.pricePerMonth,
            roomImageUrl: room.images.isNotEmpty ? room.images.first.imageUrl : null,
          );
        }
      } catch (_) {}
    }
    return entity;
  }

  @override
  Future<BookingEntity> createBooking(BookingEntity booking) async {
    final modelToCreate = BookingModel.fromEntity(booking);
    final createdModel = await _remoteDataSource.createBooking(modelToCreate);
    return createdModel.toEntity();
  }

  @override
  Future<BookingEntity> updateBooking(BookingEntity booking) async {
    final modelToUpdate = BookingModel.fromEntity(booking);
    final updatedModel = await _remoteDataSource.updateBooking(modelToUpdate);
    return updatedModel.toEntity();
  }

  @override
  Future<void> deleteBooking(String bookingId) async {
    await _remoteDataSource.deleteBooking(bookingId);
  }

  @override
  Future<void> cancelOtherPendingBookingsForRoom(String roomId, String exceptedBookingId) async {
    await _remoteDataSource.cancelOtherPendingBookingsForRoom(roomId, exceptedBookingId);
  }

  @override
  Stream<List<BookingEntity>> watchBookings({String? userId, String? roomId, String? ownerId}) {
    return _remoteDataSource.watchBookings(
      userId: userId,
      roomId: roomId,
      ownerId: ownerId,
    ).asyncMap((models) async {
      final entities = <BookingEntity>[];
      for (final model in models) {
        var entity = model.toEntity();
        if ((entity.roomName == null || entity.roomName!.isEmpty) && entity.roomId.isNotEmpty) {
          try {
            final roomRepo = inject<RoomRepository>();
            final room = await roomRepo.getRoomById(entity.roomId);
            if (room != null) {
              entity = entity.copyWith(
                roomName: room.name,
                roomPrice: room.pricePerMonth,
                roomImageUrl: room.images.isNotEmpty ? room.images.first.imageUrl : null,
              );
            }
          } catch (_) {}
        }
        entities.add(entity);
      }
      return entities;
    });
  }
}
