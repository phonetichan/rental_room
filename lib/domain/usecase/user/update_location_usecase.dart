import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../entity/user/user_entity.dart';
import '../../repository/user/user_repository.dart';

class UpdateUserLocationParams {
  final String userId;
  final double latitude;
  final double longitude;
  final String address;

  UpdateUserLocationParams({
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

@lazySingleton
class UpdateUserLocationUseCase
    implements UseCase<DataState<UserEntity>, UpdateUserLocationParams> {
  final UserRepository _repository;

  const UpdateUserLocationUseCase(this._repository);

  @override
  Future<DataState<UserEntity>> call(UpdateUserLocationParams param) async {
    debugPrint('UpdateUserLocationUseCase: executing for user id: ${param.userId}');
    try {
      final user = await _repository.updateUserLocation(
        userId: param.userId,
        latitude: param.latitude,
        longitude: param.longitude,
        address: param.address,
      );
      debugPrint('UpdateUserLocationUseCase: location update succeeded');
      return Success(user);
    } on RemoteException catch (e) {
      debugPrint('UpdateUserLocationUseCase: RemoteException: ${e.message}');
      return Failed(e.toFailure());
    } catch (e, st) {
      debugPrint('UpdateUserLocationUseCase: unknown error: $e\n$st');
      final cleanMsg = e
          .toString()
          .replaceAll('Exception: ', '')
          .replaceAll(RegExp(r'\[.*?\]\s*'), '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}