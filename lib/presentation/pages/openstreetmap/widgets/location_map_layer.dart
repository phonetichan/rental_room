import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../data/datasource/remote/nominatim_remote_data_source.dart';

/// Interactive OpenStreetMap tile container layer.
class LocationMapLayer extends StatelessWidget {
  final MapController mapController;
  final LatLng center;
  final VoidCallback onMapReady;
  final Function(MapCamera camera, bool hasGesture) onPositionChanged;

  const LocationMapLayer({
    super.key,
    required this.mapController,
    required this.center,
    required this.onMapReady,
    required this.onPositionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: center,
        initialZoom: 17,
        onMapReady: onMapReady,
        onPositionChanged: onPositionChanged,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: kUserAgent,
        ),
        const RichAttributionWidget(
          attributions: [
            TextSourceAttribution('© OpenStreetMap contributors')
          ],
        ),
      ],
    );
  }
}
