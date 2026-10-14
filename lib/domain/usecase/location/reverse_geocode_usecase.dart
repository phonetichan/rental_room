import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import '../../repository/location/location_repository.dart';

@lazySingleton
class ReverseGeocodeUseCase {
  final LocationRepository _repository;

  const ReverseGeocodeUseCase(this._repository);

  Future<String> call(LatLng position) {
    return _repository.reverseGeocode(position);
  }
}
