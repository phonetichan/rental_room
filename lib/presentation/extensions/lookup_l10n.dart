import '../../l10n/app_localizations.dart';

extension LookupL10nX on AppLocalizations {
  String localizedRoomType(String typeId) {
    switch (typeId) {
      case 'rt_apartment':
        return roomTypeApartment;
      case 'rt_minicondo':
        return roomTypeMiniCondo;
      case 'rt_condo':
        return roomTypeCondo;
      case 'rt_single_room':
        return roomTypeSingleRoom;
      case 'rt_dorm':
        return roomTypeDorm;
      case 'rt_double':
        return roomTypeDouble;
      default:
        return typeId;
    }
  }

  String localizedAmenity(String amenityId) {
    switch (amenityId) {
      case 'amenity_wifi':
        return amenityWifi;
      case 'amenity_ac':
        return amenityAc;
      case 'amenity_fan':
        return amenityFan;
      case 'amenity_bed':
        return amenityBed;
      case 'amenity_study_desk':
        return amenityStudyDesk;
      case 'amenity_elevator':
        return amenityElevator;
      case 'amenity_powerbank':
        return amenityPowerbank;
      case 'amenity_balcony':
        return amenityBalcony;
      case 'amenity_fridge':
        return amenityFridge;
      case 'amenity_kitchen':
        return amenityKitchen;
      case 'amenity_shower':
        return amenityShower;
      case 'amenity_toilet':
        return amenityToilet;
      case 'amenity_water_heater':
        return amenityWaterHeater;
      case 'amenity_parking':
        return amenityParking;
      case 'amenity_tv':
        return amenityTv;
      case 'amenity_pool':
        return amenityPool;
      case 'amenity_laundry':
        return amenityLaundry;
      default:
        return amenityId;
    }
  }

  String localizedStatus(String statusValue) {
    switch (statusValue.toLowerCase()) {
      case 'available':
        return available;
      case 'rented':
        return rented;
      case 'pending':
        return pending;
      case 'confirmed':
        return confirmed;
      case 'contracted':
        return contracted;
      case 'expired':
        return expired;
      default:
        return statusValue;
    }
  }
}
