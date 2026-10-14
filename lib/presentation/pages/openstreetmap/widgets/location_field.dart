import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../../../data/datasource/remote/nominatim_remote_data_source.dart';
import '../../../../domain/entity/location/picked_location.dart';
import '../../../../l10n/app_localizations.dart';
import '../page.dart';
import 'location_constants.dart';

/// Form Field Selector for selecting a location on map.
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
    final l10n = AppLocalizations.of(context)!;
    final v = value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        if (v == null)
          OutlinedButton.icon(
            onPressed: () => _pick(context),
            icon: const Icon(Icons.add_location_alt_outlined),
            label: Text(l10n.chooseLocationOnMap),
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
                child: Text(l10n.change),
              ),
            ],
          ),
        ],
      ],
    );
  }
}