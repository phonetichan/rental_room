import 'package:latlong2/latlong.dart';
import 'package:rental_room/domain/domain.dart';

extension UserLocationX on UserEntity {
  PickedLocation? get pickedLocation => hasLocation
      ? PickedLocation(LatLng(latitude!, longitude!), address ?? '')
      : null;
}