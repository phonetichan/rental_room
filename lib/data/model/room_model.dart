import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/room_entity.dart';
import '../../domain/entity/room_image_entity.dart';

class RoomImageModel {
  final String id;
  final String roomId;
  final String imageUrl;
  final bool isPrimary;

  RoomImageModel({
    required this.id,
    required this.roomId,
    required this.imageUrl,
    this.isPrimary = false,
  });

  factory RoomImageModel.fromMap(Map<String, dynamic> map) {
    return RoomImageModel(
      id: map['id'] as String? ?? '',
      roomId: map['roomId'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      isPrimary: map['isPrimary'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roomId': roomId,
      'imageUrl': imageUrl,
      'isPrimary': isPrimary,
    };
  }

  RoomImageEntity toEntity() {
    return RoomImageEntity(
      id: id,
      roomId: roomId,
      imageUrl: imageUrl,
      isPrimary: isPrimary,
    );
  }

  factory RoomImageModel.fromEntity(RoomImageEntity entity) {
    return RoomImageModel(
      id: entity.id,
      roomId: entity.roomId,
      imageUrl: entity.imageUrl,
      isPrimary: entity.isPrimary,
    );
  }
}

class RoomModel {
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
  final List<RoomImageModel> images;
  final double? latitude;
  final double? longitude;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RoomModel({
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

  factory RoomModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    final imagesData = data['images'] as List<dynamic>? ?? [];
    final imagesList = imagesData
        .map((img) => RoomImageModel.fromMap(img as Map<String, dynamic>))
        .toList();

    final amenityIdsData = data['amenityIds'] as List<dynamic>? ?? [];
    final amenityIdsList = amenityIdsData.map((e) => e.toString()).toList();

    return RoomModel(
      id: doc.id,
      ownerId: data['ownerId'] as String? ?? '',
      roomTypeId: data['roomTypeId'] as String? ?? '',
      roomNumber: data['roomNumber'] as String? ?? '',
      name: data['name'] as String? ?? '',
      floor: data['floor'] as String? ?? '',
      maxGuests: (data['maxGuests'] as num?)?.toInt() ?? 1,
      pricePerMonth: (data['pricePerMonth'] as num?)?.toDouble() ?? 0.0,
      location: data['location'] as String? ?? '',
      numberBedrooms: (data['numberBedrooms'] as num?)?.toInt() ?? 1,
      roomSqft: (data['roomSqft'] as num?)?.toDouble() ?? 0.0,
      description: data['description'] as String?,
      amenityIds: amenityIdsList,
      images: imagesList,
      latitude: (data['latitude'] as num?)?.toDouble(),
      longitude: (data['longitude'] as num?)?.toDouble(),
      status: data['status'] as String? ?? 'available',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'roomTypeId': roomTypeId,
      'roomNumber': roomNumber,
      'name': name,
      'floor': floor,
      'maxGuests': maxGuests,
      'pricePerMonth': pricePerMonth,
      'location': location,
      'numberBedrooms': numberBedrooms,
      'roomSqft': roomSqft,
      'description': description,
      'amenityIds': amenityIds,
      'images': images.map((img) => img.toMap()).toList(),
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      'status': status,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  RoomEntity toEntity() {
    return RoomEntity(
      id: id,
      ownerId: ownerId,
      roomTypeId: roomTypeId,
      roomNumber: roomNumber,
      name: name,
      floor: floor,
      maxGuests: maxGuests,
      pricePerMonth: pricePerMonth,
      location: location,
      numberBedrooms: numberBedrooms,
      roomSqft: roomSqft,
      description: description,
      amenityIds: amenityIds,
      images: images.map((img) => img.toEntity()).toList(),
      latitude: latitude,
      longitude: longitude,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory RoomModel.fromEntity(RoomEntity entity) {
    return RoomModel(
      id: entity.id,
      ownerId: entity.ownerId,
      roomTypeId: entity.roomTypeId,
      roomNumber: entity.roomNumber,
      name: entity.name,
      floor: entity.floor,
      maxGuests: entity.maxGuests,
      pricePerMonth: entity.pricePerMonth,
      location: entity.location,
      numberBedrooms: entity.numberBedrooms,
      roomSqft: entity.roomSqft,
      description: entity.description,
      amenityIds: entity.amenityIds,
      images: entity.images.map((e) => RoomImageModel.fromEntity(e)).toList(),
      latitude: entity.latitude,
      longitude: entity.longitude,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
