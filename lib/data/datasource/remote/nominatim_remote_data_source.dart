import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import '../../../domain/entity/location/picked_location.dart';

const kUserAgent = 'com.example.rental_room';

abstract class NominatimRemoteDataSource {
  Future<String> reverseGeocode(LatLng position);
  Future<List<PickedLocation>> searchLocation(String query);
}

@LazySingleton(as: NominatimRemoteDataSource)
class NominatimRemoteDataSourceImpl implements NominatimRemoteDataSource {
  static const _headers = {'User-Agent': kUserAgent};

  @override
  Future<String> reverseGeocode(LatLng position) async {
    try {
      final uri = Uri.https('nominatim.openstreetmap.org', '/reverse', {
        'format': 'jsonv2',
        'lat': '${position.latitude}',
        'lon': '${position.longitude}',
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

  @override
  Future<List<PickedLocation>> searchLocation(String query) async {
    try {
      final uri = Uri.https('nominatim.openstreetmap.org', '/search', {
        'format': 'jsonv2',
        'q': query,
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
}
