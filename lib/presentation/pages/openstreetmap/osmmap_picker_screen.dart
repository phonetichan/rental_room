import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class OSMMapPickerScreen extends StatefulWidget {
  @override
  _OSMMapPickerScreenState createState() => _OSMMapPickerScreenState();
}

class _OSMMapPickerScreenState extends State<OSMMapPickerScreen> {
  final MapController _mapController = MapController();
  LatLng _currentCenter = const LatLng(-7.7829, 110.3671); // Default to Yogyakarta[cite: 1]
  String _addressDetails = "Fetching address...";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _reverseGeocode(_currentCenter);
  }

  // Fetch address using OpenStreetMap Nominatim API
  Future<void> _reverseGeocode(LatLng location) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${location.latitude}&lon=${location.longitude}&zoom=18&addressdetails=1');

    try {
      final response = await http.get(url, headers: {'User-Agent': 'FlutterApp/1.0'});
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _addressDetails = data['display_name'] ?? "Unknown location";
        });
      }
    } catch (e) {
      setState(() {
        _addressDetails = "Failed to fetch address";
      });
    }
  }

  // Save coordinates and address to Firebase Firestore
  Future<void> _saveLocationToFirebase() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseFirestore.instance.collection('user_locations').add({
        'latitude': _currentCenter.latitude,
        'longitude': _currentCenter.longitude,
        'address': _addressDetails,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location saved successfully!")),
      );
      // Navigate to home/next screen here
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving location: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // OpenStreetMap Layer
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentCenter,
              initialZoom: 15.0,
              onPositionChanged: (position, hasGesture) {
                if (hasGesture && position.center != null) {
                  setState(() {
                    _currentCenter = position.center!;
                  });
                }
              },
              onMapEvent: (event) {
                if (event is MapEventMoveEnd) {
                  _reverseGeocode(_currentCenter);
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app', // Required by OSM policy
              ),
            ],
          ),

          // Fixed Center Pin Overlay (Matching your mockup UI)
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 40), // Offset for pin anchor
              child: Icon(
                Icons.location_pin,
                size: 50,
                color: Colors.orange,
              ),
            ),
          ),

          // Top Search Bar Mockup
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.purple),
                  hintText: "Search Location",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // Bottom Sheet with Location Details & Choose Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -2))
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Location Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.place, color: Colors.purple),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _addressDetails,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7C3AED), // Purple matching mockup
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isLoading ? null : _saveLocationToFirebase,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        "Choose location",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}