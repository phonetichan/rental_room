import 'package:flutter/material.dart';
import '../../../../domain/entity/location/picked_location.dart';
import 'location_constants.dart';

/// Back button, search field, and auto-complete search results overlay.
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
