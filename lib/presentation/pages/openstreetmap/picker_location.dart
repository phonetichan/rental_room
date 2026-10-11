import 'package:latlong2/latlong.dart';

class PickedLocation {
  final LatLng latLng;
  final String address;
  const PickedLocation(this.latLng, this.address);
}