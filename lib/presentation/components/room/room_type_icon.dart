// presentation/.../widgets/room_type_icons.dart
import 'package:flutter/material.dart';

/// Room type IDs, matching the ones seeded in AuthDataSource.seedInitialData().
abstract final class RoomTypeIds {
  static const apartment = 'rt_apartment';
  static const miniCondo = 'rt_minicondo';
  static const condo = 'rt_condo';
  static const singleRoom = 'rt_single_room';
  static const dorm = 'rt_dorm';
  static const double = 'rt_double';
}

IconData roomTypeIcon(String roomTypeId) => switch (roomTypeId) {
  RoomTypeIds.apartment => Icons.home_work_outlined,     // Standard Apartment
  RoomTypeIds.miniCondo => Icons.apartment_outlined,     // Mini Condo
  RoomTypeIds.condo => Icons.location_city_outlined,     // Full Condominium
  RoomTypeIds.singleRoom => Icons.door_front_door_outlined, // Single Room Unit
  RoomTypeIds.dorm => Icons.single_bed_outlined,         // Dormitory
  RoomTypeIds.double => Icons.king_bed_outlined,         // Double Room
  _ => Icons.meeting_room_outlined,                      // Unknown / future types
};