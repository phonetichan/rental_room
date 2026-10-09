// import 'room_image_entity.dart';
//
// class RoomEntity {
//   final String id;
//   final String ownerId;
//   final String roomTypeId;
//   final String roomNumber;
//   final String name;
//   final String floor;
//   final int maxGuests;
//   final double pricePerMonth;
//   final String location;
//   final int numberBedrooms;
//   final double roomSqft;
//   final String? description;
//   final List<String> amenityIds;
//   final List<RoomImageEntity> images;
//   final double? latitude;
//   final double? longitude;
//   final String status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   const RoomEntity({
//     required this.id,
//     required this.ownerId,
//     required this.roomTypeId,
//     required this.roomNumber,
//     required this.name,
//     required this.floor,
//     required this.maxGuests,
//     required this.pricePerMonth,
//     required this.location,
//     required this.numberBedrooms,
//     required this.roomSqft,
//     this.description,
//     this.amenityIds = const [],
//     this.images = const [],
//     this.latitude,
//     this.longitude,
//     this.status = 'available',
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   RoomEntity copyWith({
//     String? id,
//     String? ownerId,
//     String? roomTypeId,
//     String? roomNumber,
//     String? name,
//     String? floor,
//     int? maxGuests,
//     double? pricePerMonth,
//     String? location,
//     int? numberBedrooms,
//     double? roomSqft,
//     String? description,
//     List<String>? amenityIds,
//     List<RoomImageEntity>? images,
//     double? latitude,
//     double? longitude,
//     String? status,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return RoomEntity(
//       id: id ?? this.id,
//       ownerId: ownerId ?? this.ownerId,
//       roomTypeId: roomTypeId ?? this.roomTypeId,
//       roomNumber: roomNumber ?? this.roomNumber,
//       name: name ?? this.name,
//       floor: floor ?? this.floor,
//       maxGuests: maxGuests ?? this.maxGuests,
//       pricePerMonth: pricePerMonth ?? this.pricePerMonth,
//       location: location ?? this.location,
//       numberBedrooms: numberBedrooms ?? this.numberBedrooms,
//       roomSqft: roomSqft ?? this.roomSqft,
//       description: description ?? this.description,
//       amenityIds: amenityIds ?? this.amenityIds,
//       images: images ?? this.images,
//       latitude: latitude ?? this.latitude,
//       longitude: longitude ?? this.longitude,
//       status: status ?? this.status,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }
// }

import 'room_image_entity.dart';

class RoomEntity {
  final String id;
  final String ownerId;
  final String roomTypeId;
  final String roomNumber;
  final String name;
  final String floor;
  final int maxGuests;
  final double pricePerMonth;
  final String location;
  final int numberBedrooms;
  final double roomSqft;
  final String? description;
  final List<String> amenityIds;
  final List<RoomImageEntity> images;
  final double? latitude;
  final double? longitude;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const RoomEntity({
    required this.id,
    required this.ownerId,
    required this.roomTypeId,
    required this.roomNumber,
    required this.name,
    required this.floor,
    required this.maxGuests,
    required this.pricePerMonth,
    required this.location,
    required this.numberBedrooms,
    required this.roomSqft,
    this.description,
    this.amenityIds = const [],
    this.images = const [],
    this.latitude,
    this.longitude,
    this.status = 'available',
    this.createdAt,
    this.updatedAt,
  });

  /// Safely extracts and sanitizes string fields from raw dynamic values.
  /// Prevents `null.toString()` from producing `"null"`.
  static String _parseString(dynamic value, {String fallback = ''}) {
    if (value == null) return fallback;
    final str = value.toString().trim();
    if (str.isEmpty || str == 'null') return fallback;
    return str;
  }

  /// Factory to safely deserialize from JSON / Firestore Map
  factory RoomEntity.fromMap(Map<String, dynamic> map, {String? id}) {
    return RoomEntity(
      id: id ?? _parseString(map['id']),
      ownerId: _parseString(map['ownerId'] ?? map['owner_id'] ?? map['userId']),
      roomTypeId: _parseString(map['roomTypeId'] ?? map['room_type_id']),
      roomNumber: _parseString(map['roomNumber'] ?? map['room_number']),
      name: _parseString(map['name']),
      floor: _parseString(map['floor']),
      maxGuests: (map['maxGuests'] ?? map['max_guests'] ?? 0) as int,
      pricePerMonth: ((map['pricePerMonth'] ?? map['price_per_month'] ?? 0.0) as num).toDouble(),
      location: _parseString(map['location']),
      numberBedrooms: (map['numberBedrooms'] ?? map['number_bedrooms'] ?? 0) as int,
      roomSqft: ((map['roomSqft'] ?? map['room_sqft'] ?? 0.0) as num).toDouble(),
      description: map['description'] != null ? _parseString(map['description']) : null,
      amenityIds: (map['amenityIds'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
      status: _parseString(map['status'], fallback: 'available'),
      createdAt: map['createdAt'] != null ? DateTime.tryParse(map['createdAt'].toString()) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.tryParse(map['updatedAt'].toString()) : null,
    );
  }

  RoomEntity copyWith({
    String? id,
    String? ownerId,
    String? roomTypeId,
    String? roomNumber,
    String? name,
    String? floor,
    int? maxGuests,
    double? pricePerMonth,
    String? location,
    int? numberBedrooms,
    double? roomSqft,
    String? description,
    List<String>? amenityIds,
    List<RoomImageEntity>? images,
    double? latitude,
    double? longitude,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RoomEntity(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      roomTypeId: roomTypeId ?? this.roomTypeId,
      roomNumber: roomNumber ?? this.roomNumber,
      name: name ?? this.name,
      floor: floor ?? this.floor,
      maxGuests: maxGuests ?? this.maxGuests,
      pricePerMonth: pricePerMonth ?? this.pricePerMonth,
      location: location ?? this.location,
      numberBedrooms: numberBedrooms ?? this.numberBedrooms,
      roomSqft: roomSqft ?? this.roomSqft,
      description: description ?? this.description,
      amenityIds: amenityIds ?? this.amenityIds,
      images: images ?? this.images,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
