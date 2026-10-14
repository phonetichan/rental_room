import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import '../../repository/location/location_repository.dart';

@lazySingleton
class GetCurrentLocationUseCase {
  final LocationRepository _repository;

  const GetCurrentLocationUseCase(this._repository);

  Future<LatLng?> call() {
    return _repository.getCurrentLocation();
  }
}
