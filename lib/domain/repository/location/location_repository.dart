import 'package:latlong2/latlong.dart';
import '../../entity/location/picked_location.dart';

abstract class LocationRepository {
  Future<String> reverseGeocode(LatLng position);
  Future<List<PickedLocation>> searchLocation(String query);
  Future<LatLng?> getCurrentLocation();
}
