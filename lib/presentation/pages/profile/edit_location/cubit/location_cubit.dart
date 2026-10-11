import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/domain.dart';

part 'location_state.dart';
part 'location_cubit.freezed.dart';

@injectable
class LocationCubit extends Cubit<LocationState> {
  final UpdateUserLocationUseCase _updateUserLocation;

  LocationCubit(this._updateUserLocation)
      : super(const LocationState.initial());

  Future<void> updateLocation({
    required String userId,
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    emit(const LocationState.loading());

    final result = await _updateUserLocation(
      UpdateUserLocationParams(
        userId: userId,
        latitude: latitude,
        longitude: longitude,
        address: address,
      ),
    );

    result
      ..onSuccess((user) {
        emit(LocationState.success(user));
      })
      ..onError((failure) {
        emit(LocationState.failure(failure.reason)); // Changed from .message to .reason
      });
  }
}