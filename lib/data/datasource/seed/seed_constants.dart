final List<Map<String, dynamic>> initialAmenities = [
  // Connectivity & Tech
  {'id': 'amenity_wifi', 'name': 'WiFi', 'icon': 'wifi'},
  {'id': 'amenity_tv', 'name': 'Smart TV', 'icon': 'tv'},
  {
    'id': 'amenity_fingerprint_lock',
    'name': 'Smart Lock',
    'icon': 'door_sliding',
  },
  {
    'id': 'amenity_generator',
    'name': 'Backup Generator',
    'icon': 'electric_bolt',
  },
  {
    'id': 'amenity_powerbank',
    'name': 'Powerbank / UPS',
    'icon': 'battery_charging_full',
  },

  // Climate & Cooling
  {'id': 'amenity_ac', 'name': 'Air Conditioning', 'icon': 'ac_unit'},
  {'id': 'amenity_fan', 'name': 'Fan', 'icon': 'air'},

  // Bedroom & Furniture
  {'id': 'amenity_bed', 'name': 'Bed', 'icon': 'king_bed'},
  {
    'id': 'amenity_wardrobe',
    'name': 'Wardrobe / Closet',
    'icon': 'checkroom',
  },
  {
    'id': 'amenity_study_desk',
    'name': 'Study Desk',
    'icon': 'table_restaurant',
  },
  {
    'id': 'amenity_curtains',
    'name': 'Blackout Curtains',
    'icon': 'blinds',
  },

  // Kitchen & Dining
  {'id': 'amenity_fridge', 'name': 'Refrigerator', 'icon': 'kitchen'},
  {'id': 'amenity_kitchen', 'name': 'Kitchen', 'icon': 'soup_kitchen'},
  {
    'id': 'amenity_water_filter',
    'name': 'Water Purifier',
    'icon': 'water_drop',
  },

  // Bathroom & Utility
  {'id': 'amenity_shower', 'name': 'Shower Room', 'icon': 'shower'},
  {'id': 'amenity_toilet', 'name': 'Toilet', 'icon': 'sanitation'},
  {
    'id': 'amenity_water_heater',
    'name': 'Water Heater',
    'icon': 'hot_tub',
  },
  {
    'id': 'amenity_laundry',
    'name': 'Washing Machine',
    'icon': 'local_laundry_service',
  },
  {'id': 'amenity_iron', 'name': 'Ironing Facilities', 'icon': 'iron'},

  // Building & Security
  {'id': 'amenity_elevator', 'name': 'Elevator', 'icon': 'elevator'},
  {
    'id': 'amenity_security_24h',
    'name': '24/7 Security Guard',
    'icon': 'security',
  },
  {'id': 'amenity_cctv', 'name': 'CCTV Surveillance', 'icon': 'videocam'},
  {'id': 'amenity_balcony', 'name': 'Balcony', 'icon': 'balcony'},
  {
    'id': 'amenity_trash_chute',
    'name': 'Garbage Disposal',
    'icon': 'delete_outline',
  },

  // Outdoor & Facilities
  {
    'id': 'amenity_parking',
    'name': 'Car Parking',
    'icon': 'local_parking',
  },
  {
    'id': 'amenity_motorcycle_parking',
    'name': 'Motorcycle Parking',
    'icon': 'two_wheeler',
  },
  {'id': 'amenity_gym', 'name': 'Fitness Gym', 'icon': 'fitness_center'},
  {'id': 'amenity_pool', 'name': 'Swimming Pool', 'icon': 'pool'},
  {'id': 'amenity_rooftop', 'name': 'Rooftop Garden', 'icon': 'deck'},
];

final List<Map<String, dynamic>> initialRoomTypes = [
  {
    'id': 'rt_apartment',
    'typeName': 'Standard Apartment',
    'description': 'Traditional apartment in a low-rise or mid-rise building.',
  },
  {
    'id': 'rt_minicondo',
    'typeName': 'Mini Condo',
    'description':
        'Modern apartment building with essential facilities like elevator and backup generator.',
  },
  {
    'id': 'rt_condo',
    'typeName': 'Full Condominium',
    'description':
        'High-rise luxury residence with full facilities (gym, pool, 24/7 security, car parking).',
  },
  {
    'id': 'rt_single_room',
    'typeName': 'Single Room Unit',
    'description':
        'Private single room within a shared housing or hostel arrangement.',
  },
  {
    'id': 'rt_dorm',
    'typeName': 'Dormitory',
    'description':
        'Shared dormitory room with bunk beds ideal for students or budget travelers.',
  },
  {
    'id': 'rt_double',
    'typeName': 'Double Room',
    'description':
        'Comfortable room featuring one double bed or two single beds suitable for two guests.',
  },
];
