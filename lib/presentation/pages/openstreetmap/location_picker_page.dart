import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:rental_room/presentation/pages/openstreetmap/picker_location.dart';

const kPrimary = Color(0xFF7B52D6);
const kPin = Color(0xFFFFB020);
const kDefaultCenter = LatLng(16.8409, 96.1735); // Yangon, Myanmar
const kUserAgent = 'com.example.rental_room';

/// ---------- Services (OpenStreetMap / Nominatim) ----------
class GeoService {
  static const _headers = {'User-Agent': kUserAgent};

  static Future<String> reverse(LatLng p) async {
    try {
      final uri = Uri.https('nominatim.openstreetmap.org', '/reverse', {
        'format': 'jsonv2',
        'lat': '${p.latitude}',
        'lon': '${p.longitude}',
        'accept-language': 'en',
      });
      final res = await http.get(uri, headers: _headers);
      if (res.statusCode != 200) return 'Unknown location';
      return (jsonDecode(res.body)['display_name'] as String?) ??
          'Unknown location';
    } catch (_) {
      return 'Unknown location';
    }
  }

  static Future<List<PickedLocation>> search(String q) async {
    try {
      final uri = Uri.https('nominatim.openstreetmap.org', '/search', {
        'format': 'jsonv2',
        'q': q,
        'limit': '5',
        'accept-language': 'en',
      });
      final res = await http.get(uri, headers: _headers);
      if (res.statusCode != 200) return [];
      return (jsonDecode(res.body) as List)
          .map((e) => PickedLocation(
                LatLng(double.parse(e['lat']), double.parse(e['lon'])),
                e['display_name'] as String,
              ))
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// Returns null if permission denied / service off / timeout.
  static Future<LatLng?> currentLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;
      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        return null;
      }
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          timeLimit: Duration(seconds: 10),
        ),
      );
      return LatLng(pos.latitude, pos.longitude);
    } catch (_) {
      return null;
    }
  }
}

/// ---------- Main Location Picker Page ----------
class LocationPickerPage extends StatefulWidget {
  static const String routeName = 'location_picker';
  static const String routePath = '/location_picker';

  final LatLng? initial;
  const LocationPickerPage({super.key, this.initial});

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  final _map = MapController();
  final _searchCtrl = TextEditingController();
  Timer? _reverseDebounce, _searchDebounce;

  late LatLng _center = widget.initial ?? kDefaultCenter;
  String _address = '';
  bool _loadingAddress = false;
  List<PickedLocation> _results = [];

  @override
  void dispose() {
    _reverseDebounce?.cancel();
    _searchDebounce?.cancel();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _loadAddress() {
    _reverseDebounce?.cancel();
    setState(() => _loadingAddress = true);
    // Nominatim policy: max 1 request/second -> debounce
    _reverseDebounce = Timer(const Duration(milliseconds: 700), () async {
      final addr = await GeoService.reverse(_center);
      if (!mounted) return;
      setState(() {
        _address = addr;
        _loadingAddress = false;
      });
    });
  }

  void _onSearchChanged(String text) {
    _searchDebounce?.cancel();
    if (text.trim().length < 3) {
      setState(() => _results = []);
      return;
    }
    _searchDebounce = Timer(const Duration(milliseconds: 900), () async {
      final r = await GeoService.search(text);
      if (mounted) setState(() => _results = r);
    });
  }

  void _selectResult(PickedLocation r) {
    FocusScope.of(context).unfocus();
    _searchCtrl.text = r.address;
    _reverseDebounce?.cancel();
    setState(() {
      _results = [];
      _center = r.latLng;
      _address = r.address; // already known, no extra request needed
      _loadingAddress = false;
    });
    _map.move(r.latLng, 17);
  }

  Future<void> _goToMe() async {
    final me = await GeoService.currentLocation();
    if (me == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not get your location')),
      );
      return;
    }
    _center = me;
    _map.move(me, 17);
    _loadAddress();
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final bottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Map Layer (Self-Widget)
          LocationMapLayer(
            mapController: _map,
            center: _center,
            onMapReady: _loadAddress,
            onPositionChanged: (camera, hasGesture) {
              _center = camera.center;
              if (hasGesture) _loadAddress();
            },
          ),

          // 2. Fixed Center Pin Overlay (Self-Widget)
          const CenterPinOverlay(),

          // 3. Top Search Bar & Action Layer (Self-Widget)
          Positioned(
            top: top + 8,
            left: 16,
            right: 16,
            child: LocationSearchBar(
              controller: _searchCtrl,
              results: _results,
              onSearchChanged: _onSearchChanged,
              onSelectResult: _selectResult,
              onBackPressed: () => Navigator.pop(context),
            ),
          ),

          // 4. My Location Floating Action Button (Self-Widget)
          Positioned(
            right: 16,
            bottom: 250,
            child: MyLocationFab(onPressed: _goToMe),
          ),

          // 5. Bottom Details Card & Action Button (Self-Widget)
          Positioned(
            left: 16,
            right: 16,
            bottom: bottom + 16,
            child: LocationDetailsCard(
              address: _address,
              isLoading: _loadingAddress,
              onConfirm: () => Navigator.pop(
                context,
                PickedLocation(_center, _address),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ====================================================================
// SELF-WIDGETS: Extracted components for clear UI & single functions
// ====================================================================

/// Self-Widget 1: Interactive OpenStreetMap tile container
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

/// Self-Widget 2: Fixed Pin indicator located precisely in map center
class CenterPinOverlay extends StatelessWidget {
  const CenterPinOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 48),
          child: Icon(Icons.location_on, size: 56, color: kPin),
        ),
      ),
    );
  }
}

/// Self-Widget 3: Back button, search field, and auto-complete results list
class LocationSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final List<PickedLocation> results;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<PickedLocation> onSelectResult;
  final VoidCallback onBackPressed;

  const LocationSearchBar({
    super.key,
    required this.controller,
    required this.results,
    required this.onSearchChanged,
    required this.onSelectResult,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: onBackPressed,
          ),
        ),
        const SizedBox(height: 12),
        Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(12),
          child: TextField(
            controller: controller,
            onChanged: onSearchChanged,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Search Location',
              prefixIcon: const Icon(Icons.search, color: kPrimary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        if (results.isNotEmpty)
          Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(12),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: results.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, i) => ListTile(
                dense: true,
                leading: const Icon(Icons.place_outlined, color: kPrimary),
                title: Text(
                  results[i].address,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => onSelectResult(results[i]),
              ),
            ),
          ),
      ],
    );
  }
}

/// Self-Widget 4: Floating Action Button for GPS current location jump
class MyLocationFab extends StatelessWidget {
  final VoidCallback onPressed;

  const MyLocationFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: Colors.white,
      onPressed: onPressed,
      child: const Icon(Icons.my_location, color: kPrimary),
    );
  }
}

/// Self-Widget 5: Card displaying address details and location confirm button
class LocationDetailsCard extends StatelessWidget {
  final String address;
  final bool isLoading;
  final VoidCallback onConfirm;

  const LocationDetailsCard({
    super.key,
    required this.address,
    required this.isLoading,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Location Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: kPrimary.withValues(alpha: .1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on_outlined,
                        color: kPrimary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        isLoading
                            ? 'Finding address...'
                            : (address.isEmpty ? '-' : address),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
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
            onPressed: isLoading ? null : onConfirm,
            child: const Text(
              'Choose location',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
