// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Rental Room';

  @override
  String get home => 'Home';

  @override
  String get rooms => 'Rooms';

  @override
  String get booking => 'Bookings';

  @override
  String get profile => 'Profile';

  @override
  String get overview => 'Overview';

  @override
  String get owner => 'Owner';

  @override
  String get tenant => 'Tenant';

  @override
  String get propertyOwner => 'Property Owner';

  @override
  String get rentalRoomUser => 'Rental Room User';

  @override
  String get savedCount => 'Saved Count';

  @override
  String get signOut => 'Sign Out';

  @override
  String get settings => 'Settings';

  @override
  String get settingsPreferences => 'Settings & Preferences';

  @override
  String get theme => 'Theme';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get myanmar => 'Myanmar';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get editPassword => 'Edit Password';

  @override
  String get updateLocation => 'Update Location';

  @override
  String get confirmUpdateLocationTitle => 'Update Location';

  @override
  String get confirmUpdateLocationMessage =>
      'Are you sure you want to update your location?';

  @override
  String get confirm => 'Confirm';

  @override
  String get termsAndConditions => 'Terms and Conditions';

  @override
  String get userGuidance => 'User Guidance & Help';

  @override
  String get exitApp => 'Exit App';

  @override
  String get exitAppConfirm => 'Are you sure you want to exit the application?';

  @override
  String get logoutConfirmTitle => 'Confirm Logout';

  @override
  String get logoutConfirmMessage =>
      'Are you sure you want to log out of your account?';

  @override
  String get exit => 'Exit';

  @override
  String get cancel => 'Cancel';

  @override
  String get availableRooms => 'Available Rooms';

  @override
  String get pendingRequests => 'Pending Requests';

  @override
  String get totalOccupancy => 'Total Occupancy';

  @override
  String get overallOccupancyRate => 'Overall occupancy rate across units';

  @override
  String usersSavedListing(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count users saved your listings',
      one: '1 user saved your listing',
    );
    return '$_temp0';
  }

  @override
  String roomsCurrentlyOccupied(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rooms currently occupied',
      one: '1 room currently occupied',
    );
    return '$_temp0';
  }

  @override
  String pendingInquiries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tenant booking inquiries pending',
      one: '1 tenant booking inquiry pending',
    );
    return '$_temp0';
  }

  @override
  String contractRevenueRange(String startMonth, String endMonth) {
    return '$startMonth - $endMonth Contract Revenue';
  }

  @override
  String totalRevenuePerMonth(String amount, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count active leases',
      one: '1 active lease',
    );
    return 'Total: $amount / mo ($_temp0)';
  }

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get latestProperties => 'Latest Properties';

  @override
  String get seeAll => 'See All';

  @override
  String get all => 'All';

  @override
  String get available => 'Available';

  @override
  String get rented => 'Rented';

  @override
  String get noAvailableRooms => 'No available rooms found.';

  @override
  String get noRentedRooms => 'No rented rooms found.';

  @override
  String get noPropertiesYet => 'No properties listed yet.';

  @override
  String get categories => 'Categories';

  @override
  String get recommended => 'Recommended';

  @override
  String recommendedWithType(String type) {
    return 'Recommended · $type';
  }

  @override
  String get noRoomsAvailable => 'No rooms available.';

  @override
  String noTypeAvailable(String type) {
    return 'No $type available.';
  }

  @override
  String get miniCondo => 'Mini Condo';

  @override
  String get noMiniCondos => 'No mini condos available.';

  @override
  String errorLoadingRooms(String message) {
    return 'Error loading rooms: $message';
  }

  @override
  String get promoCashback => 'GET YOUR 20%\nCASHBACK';

  @override
  String get promoExpired => '*Expired 25 Dec 2026';

  @override
  String visitorFavorited(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count visitors favorited this room',
      one: '1 visitor favorited this room',
    );
    return '$_temp0';
  }

  @override
  String visitorViewed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count visitors viewed this room',
      one: '1 visitor viewed this room',
    );
    return '$_temp0';
  }

  @override
  String get details => 'Details';

  @override
  String get amenities => 'Amenities';

  @override
  String get photos => 'Photos';

  @override
  String get editRoomListing => 'Edit Room Listing';

  @override
  String get editDetailRoom => 'Edit Detail Room';

  @override
  String get pending => 'Pending';

  @override
  String get confirmed => 'Confirmed';

  @override
  String get contracted => 'Contracted';

  @override
  String get expired => 'Expired';

  @override
  String get noPendingBookings => 'No pending booking requests.';

  @override
  String get noConfirmedBookings => 'No confirmed booking requests.';

  @override
  String get noContractedBookings => 'No contracted booking requests.';

  @override
  String get contractExpired => 'Contract expired';

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days left',
      one: '1 day left',
    );
    return '$_temp0';
  }

  @override
  String durationMonths(int count) {
    return '$count Months';
  }

  @override
  String get requested => 'Requested';

  @override
  String get roomPrice => 'Room Price';

  @override
  String get contactPhone => 'Contact Phone';

  @override
  String get acceptConfirm => 'Accept & Confirm';

  @override
  String get description => 'Description';

  @override
  String get noDescription => 'No description provided for this room.';

  @override
  String get showMore => 'Show More';

  @override
  String get showLess => 'Show Less';

  @override
  String get propertyHost => 'Property Host';

  @override
  String get locationMap => 'Location Map';

  @override
  String get openMap => 'Open Map';

  @override
  String get locationNotProvided => 'Location coordinates not provided';

  @override
  String get loadingVisitorStats => 'Loading visitor stats...';

  @override
  String get visitorTrackText =>
      'Track view engagement and interest for this property listing.';

  @override
  String beds(int count) {
    return '$count Beds';
  }

  @override
  String guests(int count) {
    return '$count Guests';
  }

  @override
  String sqft(String value) {
    return '$value sqft';
  }

  @override
  String floorShort(String floor) {
    return 'Fl. $floor';
  }

  @override
  String errorOpeningMap(String error) {
    return 'Error opening map: $error';
  }

  @override
  String get deleteRoom => 'Delete Room';

  @override
  String get price => 'Price';

  @override
  String get editRoomDetails => 'Edit Room Details';

  @override
  String get trackEngagement => 'Track engagement for your property listing.';

  @override
  String userFavoritedRoom(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Users Favorited This Room',
      one: '1 User Favorited This Room',
    );
    return '$_temp0';
  }

  @override
  String get addRoomListing => 'Add Room Listing';

  @override
  String get createRoom => 'Create Room';

  @override
  String get updateRoom => 'Update Room';

  @override
  String get next => 'Next';

  @override
  String get roomLocation => 'Room Location';

  @override
  String get latitude => 'Latitude';

  @override
  String get longitude => 'Longitude';

  @override
  String get roomNameTitle => 'Room Name / Title';

  @override
  String get roomNameHint => 'e.g. Cozy Deluxe Room 101';

  @override
  String get roomNumber => 'Room Number';

  @override
  String get floor => 'Floor';

  @override
  String get roomType => 'Room Type';

  @override
  String get roomSqft => 'Room Sqft';

  @override
  String get pricePerMonth => 'Price / Month';

  @override
  String get depositAmountOptional => 'Deposit Amount (Optional)';

  @override
  String get depositReceiverNameOptional => 'Deposit Receiver Name (Optional)';

  @override
  String get maxGuestsAllowed => 'Max Guests Allowed';

  @override
  String get numberOfBedrooms => 'Number of Bedrooms';

  @override
  String get descriptionOptional => 'Description (Optional)';

  @override
  String get descriptionHint =>
      'Enter room details, rules, amenities description...';

  @override
  String get roomPhotos => 'Room Photos';

  @override
  String get pleaseEnterRoomName => 'Please enter room name.';

  @override
  String get pleaseEnterRoomNumber => 'Please enter room number.';

  @override
  String get pleaseEnterFloorDetails => 'Please enter floor details.';

  @override
  String get pleaseSelectRoomType => 'Please select a room type.';

  @override
  String get pleaseEnterSquareFootage => 'Please enter square footage.';

  @override
  String get pleaseEnterRentalPrice => 'Please enter rental price.';

  @override
  String get pleaseChooseLocationOnMap =>
      'Please choose a location on the map.';

  @override
  String get latitudeAndLongitudeRequired =>
      'Latitude and longitude are required.';

  @override
  String get pleaseUploadPhoto => 'Please upload at least 1 room photo.';

  @override
  String get chooseLocationOnMap => 'Choose location on map';

  @override
  String get required => 'Required';

  @override
  String get agreementDetails => 'Agreement Details';

  @override
  String get leaseDuration => 'Lease Duration';

  @override
  String get leaseExpiryDate => 'Lease Expiry Date';

  @override
  String get financialSummary => 'Financial Summary';

  @override
  String rentSubtotal(int count) {
    return 'Rent Subtotal ($count mos)';
  }

  @override
  String get securityDeposit => 'Deposit';

  @override
  String get depositReceiver => 'Deposit Receiver';

  @override
  String get totalPaymentDue => 'Total Payment Due';

  @override
  String get agreementFinalizedLocked => 'Agreement Finalized & Locked';

  @override
  String get acknowledgeConfirm => 'Acknowledge & Confirm';

  @override
  String get contractConfirmed => 'Contract Confirmed';

  @override
  String get ownerConfirmedContract => 'Owner-Confirmed Contract';

  @override
  String get agreementFinalizedLockedDesc =>
      'This agreement is finalized and locked.';

  @override
  String get reviewTermsBeforeSaving =>
      'Review the terms set by the owner before saving.';

  @override
  String get rentalAgreementVoucher => 'RENTAL AGREEMENT VOUCHER';

  @override
  String get contractId => 'Contract ID';

  @override
  String get bookingId => 'Booking ID';

  @override
  String get termsAndNotes => 'Terms & Notes';

  @override
  String monthsCount(int count) {
    return '$count Months';
  }

  @override
  String get noContractFound => 'No contract founded';

  @override
  String failedToUpdateContract(String reason) {
    return 'Failed to update contract: $reason';
  }

  @override
  String get startDate => 'Start Date';

  @override
  String get endDate => 'End Date';

  @override
  String get monthlyRent => 'Monthly Rent';

  @override
  String get contractSaved => 'Contract Saved!';

  @override
  String get contractSuccessDesc =>
      'Your rental agreement voucher has been successfully created and saved. You can review the details anytime in your contract list.';

  @override
  String get done => 'Done';

  @override
  String get tenantTerms => 'Tenant Terms';

  @override
  String get ownerTerms => 'Owner Terms';

  @override
  String get tenantTerm1Title => 'General Usage & Account Responsibility';

  @override
  String get tenantTerm1Content =>
      'By creating an account and using the Rental Room application, Tenants agree to provide accurate, truthful identification information. Tenants are responsible for keeping their login credentials confidential and must not share their account with unauthorized third parties.';

  @override
  String get tenantTerm2Title => 'Rental Agreements & Lease Obligations';

  @override
  String get tenantTerm2Content =>
      'Any rental, lease, or sublease agreement entered into is strictly a legal contract between the Tenant and the Property Owner. The Rental Room platform acts solely as an informational directory and is not liable for monetary disputes, lease breaches, or property damages.';

  @override
  String get tenantTerm3Title => 'House Rules, Respect & Quiet Hours';

  @override
  String get tenantTerm3Content =>
      'Tenants agree to strictly follow all house rules specified in the property listing, including noise guidelines, visitor policies, parking regulations, and timely rent payment schedules.';

  @override
  String get tenantTerm4Title => 'Cancellation & Refund Policy';

  @override
  String get tenantTerm4Content =>
      'Booking cancellations and security deposit refunds are subject to the specific terms outlined by the Property Owner in the property listing agreement.';

  @override
  String get ownerTerm1Title => 'Listing Accuracy & Transparency';

  @override
  String get ownerTerm1Content =>
      'Property Owners must provide truthful details regarding room pricing, amenities, and property condition. Deliberately misleading information may lead to account suspension.';

  @override
  String get ownerTerm2Title => 'Location & Map Coordinates';

  @override
  String get ownerTerm2Content =>
      'Providing exact latitude and longitude map coordinates is optional. While exact coordinates help tenants locate rooms easily, owners may choose to leave map location fields empty without restriction.';

  @override
  String get ownerTerm3Title => 'Property Right & Safety Compliance';

  @override
  String get ownerTerm3Content =>
      'Property Owners represent that they hold legal rights to sublet or rent out the listed property and comply with all local housing safety codes and regulations.';

  @override
  String get ownerTerm4Title => 'Fair Treatment & Non-Discrimination';

  @override
  String get ownerTerm4Content =>
      'Property Owners agree to treat all tenant applicants fairly and without discrimination based on race, religion, gender, or nationality.';

  @override
  String get agentFees => 'Agent Fees';

  @override
  String get agentName => 'Agent Name';

  @override
  String get roomTypeApartment => 'Standard Apartment';

  @override
  String get roomTypeMiniCondo => 'Mini Condo';

  @override
  String get roomTypeCondo => 'Full Condominium';

  @override
  String get roomTypeSingleRoom => 'Single Room Unit';

  @override
  String get roomTypeDorm => 'Dormitory';

  @override
  String get roomTypeDouble => 'Double Room';

  @override
  String get amenityWifi => 'WiFi';

  @override
  String get amenityAc => 'Air Conditioning';

  @override
  String get amenityFan => 'Fan';

  @override
  String get amenityBed => 'Bed';

  @override
  String get amenityStudyDesk => 'Study Desk';

  @override
  String get amenityElevator => 'Elevator';

  @override
  String get amenityPowerbank => 'Powerbank';

  @override
  String get amenityBalcony => 'Balcony';

  @override
  String get amenityFridge => 'Refrigerator';

  @override
  String get amenityKitchen => 'Kitchen';

  @override
  String get amenityShower => 'Shower Room';

  @override
  String get amenityToilet => 'Toilet';

  @override
  String get amenityWaterHeater => 'Water Heater';

  @override
  String get amenityParking => 'Free Parking';

  @override
  String get amenityTv => 'Smart TV';

  @override
  String get amenityPool => 'Swimming Pool';

  @override
  String get amenityLaundry => 'Laundry Service';

  @override
  String get stepContactOwner => 'Step 1: Contact Owner';

  @override
  String get stepContactOwnerDesc =>
      'Reach out to the property owner via phone call to discuss room availability and details. Once contacted, your booking draft will be created automatically.';

  @override
  String get phoneContacted => 'Phone Contacted';

  @override
  String get phoneContactedSubtitle => 'I have spoken with the owner by phone';

  @override
  String get stepInspectRoom => 'Step 2: Inspect Room';

  @override
  String get stepInspectRoomDesc =>
      'Visit the property in person to inspect the room before finalizing your booking.';

  @override
  String get roomVisited => 'Room Visited';

  @override
  String get roomVisitedSubtitle => 'I have visited and inspected the room';

  @override
  String get visitedBadge => 'Visited';

  @override
  String get stepReviewSubmit => 'Step 3: Review & Submit';

  @override
  String get stepReviewSubmitDesc =>
      'Review your checklist and submit your booking request to the owner.';

  @override
  String get viewRentalContractVoucher => 'View Contract';

  @override
  String get completed => 'Completed';

  @override
  String get deleteDisabledSubmitted => 'Delete Disabled (Submitted)';

  @override
  String get deleteBooking => 'Delete Booking';

  @override
  String get contact => 'Contact';

  @override
  String get visit => 'Visit';

  @override
  String get submit => 'Submit';

  @override
  String get bookingRequest => 'Booking Request';

  @override
  String get submitRequest => 'Submit Request';

  @override
  String get requestSubmitted => 'Request Submitted';

  @override
  String get rentNow => 'Rent Now';

  @override
  String get pleaseCompletePhoneContactFirst =>
      'Please complete Phone Contact first.';

  @override
  String get pleaseCompleteRoomVisitedFirst =>
      'Please complete Room Visited first.';

  @override
  String get bookingAlreadySubmitted =>
      'Booking request is already submitted and cannot be changed.';

  @override
  String get deleteBookingConfirmation =>
      'Are you sure you want to cancel and delete this booking request?';

  @override
  String get roomInspection => 'Room Inspection';

  @override
  String get bookingStepsAndDetails => 'Booking Steps & Details';

  @override
  String get back => 'Back';

  @override
  String get phoneCallDone => 'Phone call done';

  @override
  String get visitDone => 'Visit done';

  @override
  String get roomAlreadyRentedNotice =>
      'This room has already been rented by another tenant. This request is cancelled.';

  @override
  String get bookingRequestConfirmed =>
      'Your booking request has been confirmed!';

  @override
  String bookingNeedsApproval(String status) {
    return 'This booking request has status \"$status\" and needs approval from owner.';
  }

  @override
  String get yesDelete => 'Yes, Delete';

  @override
  String get favorites => 'Favorites';

  @override
  String get savedRooms => 'Saved Rooms';

  @override
  String get noMoreData => 'No more data';

  @override
  String get retry => 'Retry';

  @override
  String get location => 'Location';

  @override
  String get selectLocation => 'Select location';

  @override
  String get nearby => 'Nearby';

  @override
  String get noNearbyRooms => 'No nearby rooms found.';

  @override
  String get filterOptions => 'Filter Options';

  @override
  String get filterClearAll => 'Clear All';

  @override
  String get filterPriceRange => 'Price Range';

  @override
  String get filterClear => 'Clear';

  @override
  String get filterFrom => 'from';

  @override
  String get filterTo => 'to';

  @override
  String get filterRoomType => 'Room Type';

  @override
  String get filterAllTypes => 'All Types';

  @override
  String get filterRoomNumber => 'Room Number (Bedrooms)';

  @override
  String get filterAny => 'Any';

  @override
  String get filterMaxGuests => 'Max Guests';

  @override
  String get filterApply => 'Apply Filters';

  @override
  String get searchRoomsHint => 'Search rooms, locations...';

  @override
  String get bookingPriceDetails => 'Price Details';

  @override
  String get bookingPeriodTime => 'Period time';

  @override
  String get bookingMonthlyPayment => 'Monthly payment';

  @override
  String get bookingTax => 'Tax';

  @override
  String get bookingTotal => 'Total';

  @override
  String bookingMonthSingular(String count) {
    return '$count Month';
  }

  @override
  String bookingMonthPlural(String count) {
    return '$count Months';
  }

  @override
  String get bookingVoucher => 'Voucher';

  @override
  String get bookingPeriod => 'Period';

  @override
  String get bookingDate => 'Date';

  @override
  String get bookingCheckDateNote =>
      'Make sure to check your date before making any sort of payments';

  @override
  String get bookingTenantDetails => 'Tenant Details';

  @override
  String get bookingOwnerDetails => 'Owner Details';

  @override
  String get bookingPropertyName => 'Property Name';

  @override
  String get bookingNotAvailable => 'N/A';

  @override
  String get itemPassword => 'Password';

  @override
  String get itemLocation => 'Location';

  @override
  String get editProfileTitle => 'Edit Profile';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get takePhoto => 'Take a Photo';

  @override
  String get removePhoto => 'Remove Photo';

  @override
  String get fullName => 'Full Name';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get pleaseEnterName => 'Please enter your name';

  @override
  String get pleaseEnterPhone => 'Please enter your phone number';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get userSessionNotFound => 'User session not found.';

  @override
  String get unableToLoadProfile =>
      'Unable to load user profile. Please re-login.';

  @override
  String failedToPickImage(String error) {
    return 'Failed to pick image: $error';
  }

  @override
  String failedToUploadImage(String error) {
    return 'Failed to upload profile image: $error';
  }

  @override
  String get updatePasswordTitle => 'Update Password';

  @override
  String get passwordChangeNote =>
      'Changing your password will require you to log in again.';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get pleaseEnterCurrentPassword => 'Please enter current password';

  @override
  String get pleaseEnterNewPassword => 'Please enter new password';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get pleaseConfirmNewPassword => 'Please confirm new password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get myLocation => 'My Location';

  @override
  String get tapChooseLocationHint =>
      'Tap \"Choose location on map\" to set your location.';

  @override
  String get change => 'Change';

  @override
  String get profileUpdatedSuccessfully => 'Profile updated successfully!';

  @override
  String get passwordUpdatedSuccessfully =>
      'Password updated successfully! Please log in again.';

  @override
  String get locationUpdatedSuccessfully => 'Location updated successfully!';

  @override
  String errorSavingRoom(String error) {
    return 'Error saving room: $error';
  }

  @override
  String welcomeBack(String name) {
    return 'Welcome back, $name!';
  }

  @override
  String get pleaseAcceptTerms =>
      'Please accept the Terms & Conditions to proceed.';

  @override
  String accountCreated(String role) {
    return 'Account created as $role!';
  }

  @override
  String get roomCreatedSuccessfully => 'Room created successfully!';

  @override
  String get roomUpdatedSuccessfully => 'Room updated successfully!';

  @override
  String get roomDeletedSuccessfully => 'Room deleted successfully!';

  @override
  String get bookingCreatedSuccessfully =>
      'Booking request created successfully!';

  @override
  String get bookingUpdatedSuccessfully => 'Booking updated successfully!';

  @override
  String get bookingDeletedSuccessfully =>
      'Booking request is successfully deleted!';

  @override
  String get contractCreatedSuccessfully => 'Contract created successfully!';

  @override
  String get contractUpdatedSuccessfully => 'Contract updated successfully!';

  @override
  String get ownersCannotFavoriteOwnRooms =>
      'Owners cannot favorite their own rooms.';

  @override
  String get thisPhoneAlreadyRegistered =>
      'This phone number is already registered by another user.';

  @override
  String get currentPasswordIncorrect =>
      'The current password you entered is incorrect.';

  @override
  String get invalidEmailOrPassword =>
      'Invalid email or password. Please try again.';

  @override
  String get emailAlreadyInUse => 'This email is already registered.';

  @override
  String get contractHistory => 'Contract History';

  @override
  String get activeContracts => 'Active Contracts';

  @override
  String get history => 'History';

  @override
  String get submitBookingRequestConfirm =>
      'Are you sure you want to submit this booking request to the owner?';

  @override
  String get voucherSavedSuccessfully =>
      'Voucher saved to Gallery successfully!';

  @override
  String get failedToSaveVoucher => 'Failed to save voucher.';
}
