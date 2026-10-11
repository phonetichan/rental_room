import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rental_room/presentation/pages/openstreetmap/picker_location.dart';

import 'location_picker_page.dart';

// ====================================================================
// SELF-WIDGET 1: Welcome/Onboarding Screen for Location Selection
// ====================================================================
class SelectLocationPage extends StatelessWidget {
  const SelectLocationPage({super.key});

  Future<void> _openPicker(BuildContext context, {LatLng? start}) async {
    final result = await Navigator.push<PickedLocation>(
      context,
      MaterialPageRoute(builder: (_) => LocationPickerPage(initial: start)),
    );
    if (result != null && context.mounted) {
      debugPrint('Picked Location: ${result.latLng} ${result.address}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text('Skip'),
                ),
              ),
              const Spacer(),
              const Icon(Icons.map_outlined, size: 160, color: kPrimary),
              const SizedBox(height: 32),
              const Text(
                'Hi, Nice to meet you !',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose your location to find property around you',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    final me = await GeoService.currentLocation();
                    if (!context.mounted) return;
                    if (me == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Location permission is required'),
                        ),
                      );
                      return;
                    }
                    _openPicker(context, start: me);
                  },
                  child: const Text(
                    'Use current location',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kPrimary,
                    side: const BorderSide(color: kPrimary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _openPicker(context),
                  child: const Text(
                    'Select it manually',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ====================================================================
// SELF-WIDGET 2: Tenant Read-Only Map Preview Widget
// Usage: RoomLocationMap(latLng: LatLng(lat, lng), address: "Yangon")
// ====================================================================
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

// ====================================================================
// SELF-WIDGET 3: Owner Location Form Selector Field Widget
// Usage inside form: LocationField(value: _loc, onChanged: (v) => ...)
// ====================================================================
class LocationField extends StatelessWidget {
  final PickedLocation? value;
  final ValueChanged<PickedLocation> onChanged;

  const LocationField({
    super.key,
    this.value,
    required this.onChanged,
  });

  Future<void> _pick(BuildContext context) async {
    final result = await Navigator.push<PickedLocation>(
      context,
      MaterialPageRoute(
        builder: (_) => LocationPickerPage(initial: value?.latLng),
      ),
    );
    if (result != null) onChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    final v = value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        if (v == null)
          OutlinedButton.icon(
            onPressed: () => _pick(context),
            icon: const Icon(Icons.add_location_alt_outlined),
            label: const Text('Choose location on map'),
            style: OutlinedButton.styleFrom(
              foregroundColor: kPrimary,
              side: const BorderSide(color: kPrimary),
              minimumSize: const Size.fromHeight(48),
            ),
          )
        else ...[
          GestureDetector(
            onTap: () => _pick(context),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 160,
                child: AbsorbPointer(
                  child: FlutterMap(
                    key: ValueKey(v.latLng),
                    options: MapOptions(
                      initialCenter: v.latLng,
                      initialZoom: 16,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: kUserAgent,
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: v.latLng,
                            width: 48,
                            height: 48,
                            alignment: Alignment.topCenter,
                            child: const Icon(
                              Icons.location_on,
                              size: 48,
                              color: kPin,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: kPrimary, size: 20),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  v.address,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () => _pick(context),
                child: const Text('Change'),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
