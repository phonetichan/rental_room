class RoomFilter {
  final String? roomTypeId;
  final double? minPrice;
  final double? maxPrice;
  final int? bedrooms;
  final int? maxGuests;
  final bool isFavoriteOnly;

  const RoomFilter({
    this.roomTypeId,
    this.minPrice,
    this.maxPrice,
    this.bedrooms,
    this.maxGuests,
    this.isFavoriteOnly = false,
  });

  bool get hasActiveFilters {
    return (roomTypeId != null && roomTypeId!.isNotEmpty) ||
        minPrice != null ||
        maxPrice != null ||
        bedrooms != null ||
        maxGuests != null ||
        isFavoriteOnly;
  }

  int get activeCount {
    int count = 0;
    if (roomTypeId != null && roomTypeId!.isNotEmpty) count++;
    if (minPrice != null) count++;
    if (maxPrice != null) count++;
    if (bedrooms != null) count++;
    if (maxGuests != null) count++;
    if (isFavoriteOnly) count++;
    return count;
  }

  RoomFilter copyWith({
    String? roomTypeId,
    double? minPrice,
    double? maxPrice,
    int? bedrooms,
    int? maxGuests,
    bool? isFavoriteOnly,
  }) {
    return RoomFilter(
      roomTypeId: roomTypeId ?? this.roomTypeId,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      bedrooms: bedrooms ?? this.bedrooms,
      maxGuests: maxGuests ?? this.maxGuests,
      isFavoriteOnly: isFavoriteOnly ?? this.isFavoriteOnly,
    );
  }
}
