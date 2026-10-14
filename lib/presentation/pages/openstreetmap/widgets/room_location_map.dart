import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../data/datasource/remote/nominatim_remote_data_source.dart';
import 'location_constants.dart';

/// Read-Only Map Preview Widget for Room Details.
class RoomLocationMap extends StatelessWidget {
  final LatLng latLng;
  final String? address;

  const RoomLocationMap({
    super.key,
    required this.latLng,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        if (address != null)
          Text(address!, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 180,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: latLng,
                initialZoom: 16,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.none,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: kUserAgent,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: latLng,
                      width: 48,
                      height: 48,
                      alignment: Alignment.topCenter,
                      child: const Icon(Icons.location_on, size: 48, color: kPin),
                    ),
                  ],
                ),
                const RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution('© OpenStreetMap contributors')
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
