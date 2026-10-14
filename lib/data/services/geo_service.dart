import 'package:latlong2/latlong.dart';
import '../../domain/entity/location/picked_location.dart';
import '../datasource/local/location_device_data_source.dart';
import '../datasource/remote/nominatim_remote_data_source.dart';

/// Legacy Service Facade for OpenStreetMap / Nominatim & Geolocator operations.
/// Delegates to remote and device datasources.
class GeoService {
  static final _nominatimSource = NominatimRemoteDataSourceImpl();
  static final _deviceSource = LocationDeviceDataSourceImpl();

  static Future<String> reverse(LatLng p) {
    return _nominatimSource.reverseGeocode(p);
  }

  static Future<List<PickedLocation>> search(String q) {
    return _nominatimSource.searchLocation(q);
  }

  static Future<LatLng?> currentLocation() {
    return _deviceSource.getCurrentLocation();
  }
}
