import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/datasource/remote/nominatim_remote_data_source.dart';
import '../../../../domain/domain.dart';
import '../../../extensions/l10n/l10n.dart';
import '../../../extensions/color/string.dart';
import 'room_section_card.dart';

/// Location map preview and directions section widget.
class RoomLocationMapSection extends StatelessWidget {
  final RoomEntity room;

  const RoomLocationMapSection({super.key, required this.room});

  bool get _hasCoords => room.latitude != null && room.longitude != null;

  /// Opens the phone's map app (geo:) and falls back to openstreetmap.org
  Future<void> _openExternalMap(BuildContext context) async {
    if (!_hasCoords) return;
    final lat = room.latitude!;
    final lng = room.longitude!;

    final geoUrl = Uri.parse(
      'geo:$lat,$lng?q=$lat,$lng(${Uri.encodeComponent(room.name)})',
    );
    final osmUrl = Uri.parse(
      'https://www.openstreetmap.org/?mlat=$lat&mlon=$lng#map=17/$lat/$lng',
    );

    try {
      if (await canLaunchUrl(geoUrl)) {
        await launchUrl(geoUrl, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(osmUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.errorOpeningMap(e.toString())),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return RoomSectionCard(
      title: l10n.locationMap,
      icon: Icons.map_outlined,
      children: [
        if (_hasCoords) ...[
          // ---- Real OpenStreetMap preview ----
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: FlutterMap(
                key: ValueKey('${room.latitude},${room.longitude}'),
                options: MapOptions(
                  initialCenter: LatLng(room.latitude!, room.longitude!),
                  initialZoom: 16,
                  // preview only: no drag/zoom, tap opens the map app
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.none,
                  ),
                  onTap: (_, __) => _openExternalMap(context),
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
                        point: LatLng(room.latitude!, room.longitude!),
                        width: 48,
                        height: 48,
                        alignment: Alignment.topCenter,
                        child: Icon(
                          Icons.location_on_rounded,
                          size: 48,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution('© OpenStreetMap contributors'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 18, color: primaryColor),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  room.location.isNotEmpty
                      ? room.location.capitalizeWords
                      : '${room.latitude}, ${room.longitude}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () => _openExternalMap(context),
                icon: const Icon(Icons.directions_rounded, size: 18),
                label: Text(l10n.openMap),
              ),
            ],
          ),
        ] else
          // ---- No coordinates saved ----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: primaryColor.withValues(alpha: 0.25)),
            ),
            child: Text(
              room.location.isNotEmpty
                  ? room.location.capitalizeWords
                  : l10n.locationNotProvided,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
      ],
    );
  }
}
