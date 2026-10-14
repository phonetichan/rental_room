extension AddressX on String {
  /// "Pyi Yeik Mon Housing Complex, Kamaryut, Kamayut District, Yangon City, Yangon, Myanmar"
  ///   -> "Kamayut, Yangon"
  /// "Pyay Road, Pyay Lan (West) Ward, Dagon, Kyauktada District, Yangon City, Yangon, 11191, Myanmar"
  ///   -> "Kyauktada, Yangon"
  String get shortAddress {
    if (trim().isEmpty) return this;

    final parts = split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty && !RegExp(r'^\d+$').hasMatch(e))
        .toList();

    if (parts.isEmpty) return this;

    final cleanedParts = parts.where((p) {
      final lower = p.toLowerCase();
      return lower != 'myanmar' && lower != 'burma' && lower != 'myanmar (burma)';
    }).toList();

    if (cleanedParts.isEmpty) cleanedParts.addAll(parts);

    String strip(String p, String suffix) => p
        .replaceAll(RegExp('\\s*$suffix\$', caseSensitive: false), '')
        .trim();

    bool endsWith(String p, String suffix) =>
        p.toLowerCase().endsWith(suffix);

    bool isAdmin(String p) => const [
      'district',
      'township',
      'region',
      'state',
      'division',
    ].any((s) => endsWith(p, s));

    // District (suffix removed)
    String? district;
    final districtIdx = cleanedParts.indexWhere((p) => endsWith(p, 'district'));
    if (districtIdx != -1) district = strip(cleanedParts[districtIdx], 'district');

    // City: a part ending in "City", else the part right before the region
    String? city;
    final cityIdx = cleanedParts.indexWhere((p) => endsWith(p, ' city'));
    if (cityIdx != -1) {
      city = strip(cleanedParts[cityIdx], 'city');
    } else {
      final regionIdx = cleanedParts.indexWhere((p) =>
      endsWith(p, 'region') ||
          endsWith(p, 'state') ||
          endsWith(p, 'division'));
      if (regionIdx > 0 && !isAdmin(cleanedParts[regionIdx - 1])) {
        city = cleanedParts[regionIdx - 1];
      }
    }

    final result = <String>[];
    for (final v in [district, city]) {
      if (v == null || v.isEmpty) continue;
      if (result.any((r) => r.toLowerCase() == v.toLowerCase())) continue;
      result.add(v);
    }

    if (result.isNotEmpty) return result.join(', ');

    // Fallback: take the last 2 significant parts (e.g. township and city/region)
    // instead of the first two parts (street/number).
    if (cleanedParts.length <= 2) {
      return cleanedParts.join(', ');
    }
    return '${cleanedParts[cleanedParts.length - 2]}, ${cleanedParts.last}';
  }
}