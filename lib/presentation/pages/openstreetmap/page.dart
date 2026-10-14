import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/services/geo_service.dart';
import '../../../domain/entity/location/picked_location.dart';
import 'widgets/widgets.dart';

const kDefaultCenter = LatLng(16.8409, 96.1735); // Yangon, Myanmar

/// ---------- Location Picker Screen ----------
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
      _address = r.address;
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
          // 1. Map Layer
          LocationMapLayer(
            mapController: _map,
            center: _center,
            onMapReady: _loadAddress,
            onPositionChanged: (camera, hasGesture) {
              _center = camera.center;
              if (hasGesture) _loadAddress();
            },
          ),

          // 2. Fixed Center Pin Overlay
          const CenterPinOverlay(),

          // 3. Top Search Bar & Action Layer
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

          // 4. My Location FAB
          Positioned(
            right: 16,
            bottom: 250,
            child: MyLocationFab(onPressed: _goToMe),
          ),

          // 5. Bottom Details Card & Confirm Button
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

/// ---------- Select / Onboarding Location Page ----------
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
