import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import '../../../domain/entity/location/picked_location.dart';
import '../../../domain/repository/location/location_repository.dart';
import '../../datasource/local/location_device_data_source.dart';
import '../../datasource/remote/nominatim_remote_data_source.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final NominatimRemoteDataSource _remoteDataSource;
  final LocationDeviceDataSource _deviceDataSource;

  LocationRepositoryImpl(
    this._remoteDataSource,
    this._deviceDataSource,
  );

  @override
  Future<String> reverseGeocode(LatLng position) {
    return _remoteDataSource.reverseGeocode(position);
  }

  @override
  Future<List<PickedLocation>> searchLocation(String query) {
    return _remoteDataSource.searchLocation(query);
  }

  @override
  Future<LatLng?> getCurrentLocation() {
    return _deviceDataSource.getCurrentLocation();
  }
}
