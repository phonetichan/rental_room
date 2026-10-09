import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entity/room/room_entity.dart';
import '../../../../domain/entity/room/room_image_entity.dart';

part 'room_model.freezed.dart';

@freezed
class RoomImageModel with _$RoomImageModel {
  const RoomImageModel._();

  const factory RoomImageModel({
    required String id,
    required String roomId,
    required String imageUrl,
    @Default(false) bool isPrimary,
  }) = _RoomImageModel;

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

@freezed
class RoomModel with _$RoomModel {
  const RoomModel._();

  const factory RoomModel({
    required String id,
    required String ownerId,
    required String roomTypeId,
    required String roomNumber,
    required String name,
    required String floor,
    required int maxGuests,
    required double pricePerMonth,
    required String location,
    required int numberBedrooms,
    required double roomSqft,
    String? description,
    @Default([]) List<String> amenityIds,
    @Default([]) List<RoomImageModel> images,
    double? latitude,
    double? longitude,
    @Default('available') String status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RoomModel;

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
