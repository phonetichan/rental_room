import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Rental Room'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @rooms.
  ///
  /// In en, this message translates to:
  /// **'Rooms'**
  String get rooms;

  /// No description provided for @booking.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get booking;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @tenant.
  ///
  /// In en, this message translates to:
  /// **'Tenant'**
  String get tenant;

  /// No description provided for @propertyOwner.
  ///
  /// In en, this message translates to:
  /// **'Property Owner'**
  String get propertyOwner;

  /// No description provided for @rentalRoomUser.
  ///
  /// In en, this message translates to:
  /// **'Rental Room User'**
  String get rentalRoomUser;

  /// No description provided for @savedCount.
  ///
  /// In en, this message translates to:
  /// **'Saved Count'**
  String get savedCount;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Settings & Preferences'**
  String get settingsPreferences;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @myanmar.
  ///
  /// In en, this message translates to:
  /// **'Myanmar'**
  String get myanmar;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @editPassword.
  ///
  /// In en, this message translates to:
  /// **'Edit Password'**
  String get editPassword;

  /// No description provided for @updateLocation.
  ///
  /// In en, this message translates to:
  /// **'Update Location'**
  String get updateLocation;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @userGuidance.
  ///
  /// In en, this message translates to:
  /// **'User Guidance & Help'**
  String get userGuidance;

  /// No description provided for @exitApp.
  ///
  /// In en, this message translates to:
  /// **'Exit App'**
  String get exitApp;

  /// No description provided for @exitAppConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit the application?'**
  String get exitAppConfirm;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @availableRooms.
  ///
  /// In en, this message translates to:
  /// **'Available Rooms'**
  String get availableRooms;

  /// No description provided for @pendingRequests.
  ///
  /// In en, this message translates to:
  /// **'Pending Requests'**
  String get pendingRequests;

  /// No description provided for @totalOccupancy.
  ///
  /// In en, this message translates to:
  /// **'Total Occupancy'**
  String get totalOccupancy;

  /// No description provided for @overallOccupancyRate.
  ///
  /// In en, this message translates to:
  /// **'Overall occupancy rate across units'**
  String get overallOccupancyRate;

  /// No description provided for @usersSavedListing.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 user saved your listing} other{{count} users saved your listings}}'**
  String usersSavedListing(int count);

  /// No description provided for @roomsCurrentlyOccupied.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 room currently occupied} other{{count} rooms currently occupied}}'**
  String roomsCurrentlyOccupied(int count);

  /// No description provided for @pendingInquiries.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 tenant booking inquiry pending} other{{count} tenant booking inquiries pending}}'**
  String pendingInquiries(int count);

  /// No description provided for @contractRevenueRange.
  ///
  /// In en, this message translates to:
  /// **'{startMonth} - {endMonth} Contract Revenue'**
  String contractRevenueRange(String startMonth, String endMonth);

  /// No description provided for @totalRevenuePerMonth.
  ///
  /// In en, this message translates to:
  /// **'Total: {amount} / mo ({count, plural, =1{1 active lease} other{{count} active leases}})'**
  String totalRevenuePerMonth(String amount, int count);

  /// No description provided for @monthJan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get monthJan;

  /// No description provided for @monthFeb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get monthFeb;

  /// No description provided for @monthMar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get monthMar;

  /// No description provided for @monthApr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get monthApr;

  /// No description provided for @monthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthMay;

  /// No description provided for @monthJun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get monthJun;

  /// No description provided for @monthJul.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get monthJul;

  /// No description provided for @monthAug.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get monthAug;

  /// No description provided for @monthSep.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get monthSep;

  /// No description provided for @monthOct.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get monthOct;

  /// No description provided for @monthNov.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get monthNov;

  /// No description provided for @monthDec.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get monthDec;

  /// No description provided for @latestProperties.
  ///
  /// In en, this message translates to:
  /// **'Latest Properties'**
  String get latestProperties;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @rented.
  ///
  /// In en, this message translates to:
  /// **'Rented'**
  String get rented;

  /// No description provided for @noAvailableRooms.
  ///
  /// In en, this message translates to:
  /// **'No available rooms found.'**
  String get noAvailableRooms;

  /// No description provided for @noRentedRooms.
  ///
  /// In en, this message translates to:
  /// **'No rented rooms found.'**
  String get noRentedRooms;

  /// No description provided for @noPropertiesYet.
  ///
  /// In en, this message translates to:
  /// **'No properties listed yet.'**
  String get noPropertiesYet;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// No description provided for @recommendedWithType.
  ///
  /// In en, this message translates to:
  /// **'Recommended · {type}'**
  String recommendedWithType(String type);

  /// No description provided for @noRoomsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No rooms available.'**
  String get noRoomsAvailable;

  /// No description provided for @noTypeAvailable.
  ///
  /// In en, this message translates to:
  /// **'No {type} available.'**
  String noTypeAvailable(String type);

  /// No description provided for @miniCondo.
  ///
  /// In en, this message translates to:
  /// **'Mini Condo'**
  String get miniCondo;

  /// No description provided for @noMiniCondos.
  ///
  /// In en, this message translates to:
  /// **'No mini condos available.'**
  String get noMiniCondos;

  /// No description provided for @errorLoadingRooms.
  ///
  /// In en, this message translates to:
  /// **'Error loading rooms: {message}'**
  String errorLoadingRooms(String message);

  /// No description provided for @promoCashback.
  ///
  /// In en, this message translates to:
  /// **'GET YOUR 20%\nCASHBACK'**
  String get promoCashback;

  /// No description provided for @promoExpired.
  ///
  /// In en, this message translates to:
  /// **'*Expired 25 Dec 2026'**
  String get promoExpired;

  /// No description provided for @visitorFavorited.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 visitor favorited this room} other{{count} visitors favorited this room}}'**
  String visitorFavorited(int count);

  /// No description provided for @visitorViewed.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 visitor viewed this room} other{{count} visitors viewed this room}}'**
  String visitorViewed(int count);

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @amenities.
  ///
  /// In en, this message translates to:
  /// **'Amenities'**
  String get amenities;

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @editRoomListing.
  ///
  /// In en, this message translates to:
  /// **'Edit Room Listing'**
  String get editRoomListing;

  /// No description provided for @editDetailRoom.
  ///
  /// In en, this message translates to:
  /// **'Edit Detail Room'**
  String get editDetailRoom;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @contracted.
  ///
  /// In en, this message translates to:
  /// **'Contracted'**
  String get contracted;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @noPendingBookings.
  ///
  /// In en, this message translates to:
  /// **'No pending booking requests.'**
  String get noPendingBookings;

  /// No description provided for @noConfirmedBookings.
  ///
  /// In en, this message translates to:
  /// **'No confirmed booking requests.'**
  String get noConfirmedBookings;

  /// No description provided for @noContractedBookings.
  ///
  /// In en, this message translates to:
  /// **'No contracted booking requests.'**
  String get noContractedBookings;

  /// No description provided for @contractExpired.
  ///
  /// In en, this message translates to:
  /// **'Contract expired'**
  String get contractExpired;

  /// No description provided for @daysLeft.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day left} other{{count} days left}}'**
  String daysLeft(int count);

  /// No description provided for @durationMonths.
  ///
  /// In en, this message translates to:
  /// **'{count} Months'**
  String durationMonths(int count);

  /// No description provided for @requested.
  ///
  /// In en, this message translates to:
  /// **'Requested'**
  String get requested;

  /// No description provided for @roomPrice.
  ///
  /// In en, this message translates to:
  /// **'Room Price'**
  String get roomPrice;

  /// No description provided for @contactPhone.
  ///
  /// In en, this message translates to:
  /// **'Contact Phone'**
  String get contactPhone;

  /// No description provided for @acceptConfirm.
  ///
  /// In en, this message translates to:
  /// **'Accept & Confirm'**
  String get acceptConfirm;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description provided for this room.'**
  String get noDescription;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get showLess;

  /// No description provided for @propertyHost.
  ///
  /// In en, this message translates to:
  /// **'Property Host'**
  String get propertyHost;

  /// No description provided for @locationMap.
  ///
  /// In en, this message translates to:
  /// **'Location Map'**
  String get locationMap;

  /// No description provided for @openMap.
  ///
  /// In en, this message translates to:
  /// **'Open Map'**
  String get openMap;

  /// No description provided for @locationNotProvided.
  ///
  /// In en, this message translates to:
  /// **'Location coordinates not provided'**
  String get locationNotProvided;

  /// No description provided for @loadingVisitorStats.
  ///
  /// In en, this message translates to:
  /// **'Loading visitor stats...'**
  String get loadingVisitorStats;

  /// No description provided for @visitorTrackText.
  ///
  /// In en, this message translates to:
  /// **'Track view engagement and interest for this property listing.'**
  String get visitorTrackText;

  /// No description provided for @beds.
  ///
  /// In en, this message translates to:
  /// **'{count} Beds'**
  String beds(int count);

  /// No description provided for @guests.
  ///
  /// In en, this message translates to:
  /// **'{count} Guests'**
  String guests(int count);

  /// No description provided for @sqft.
  ///
  /// In en, this message translates to:
  /// **'{value} sqft'**
  String sqft(String value);

  /// No description provided for @floorShort.
  ///
  /// In en, this message translates to:
  /// **'Fl. {floor}'**
  String floorShort(String floor);

  /// No description provided for @errorOpeningMap.
  ///
  /// In en, this message translates to:
  /// **'Error opening map: {error}'**
  String errorOpeningMap(String error);

  /// No description provided for @deleteRoom.
  ///
  /// In en, this message translates to:
  /// **'Delete Room'**
  String get deleteRoom;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @editRoomDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit Room Details'**
  String get editRoomDetails;

  /// No description provided for @trackEngagement.
  ///
  /// In en, this message translates to:
  /// **'Track engagement for your property listing.'**
  String get trackEngagement;

  /// No description provided for @userFavoritedRoom.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 User Favorited This Room} other{{count} Users Favorited This Room}}'**
  String userFavoritedRoom(int count);

  /// No description provided for @addRoomListing.
  ///
  /// In en, this message translates to:
  /// **'Add Room Listing'**
  String get addRoomListing;

  /// No description provided for @createRoom.
  ///
  /// In en, this message translates to:
  /// **'Create Room'**
  String get createRoom;

  /// No description provided for @updateRoom.
  ///
  /// In en, this message translates to:
  /// **'Update Room'**
  String get updateRoom;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @roomLocation.
  ///
  /// In en, this message translates to:
  /// **'Room Location'**
  String get roomLocation;

  /// No description provided for @latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitude;

  /// No description provided for @longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitude;

  /// No description provided for @roomNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Room Name / Title'**
  String get roomNameTitle;

  /// No description provided for @roomNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Cozy Deluxe Room 101'**
  String get roomNameHint;

  /// No description provided for @roomNumber.
  ///
  /// In en, this message translates to:
  /// **'Room Number'**
  String get roomNumber;

  /// No description provided for @floor.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get floor;

  /// No description provided for @roomType.
  ///
  /// In en, this message translates to:
  /// **'Room Type'**
  String get roomType;

  /// No description provided for @roomSqft.
  ///
  /// In en, this message translates to:
  /// **'Room Sqft'**
  String get roomSqft;

  /// No description provided for @pricePerMonth.
  ///
  /// In en, this message translates to:
  /// **'Price / Month'**
  String get pricePerMonth;

  /// No description provided for @depositAmountOptional.
  ///
  /// In en, this message translates to:
  /// **'Deposit Amount (Optional)'**
  String get depositAmountOptional;

  /// No description provided for @depositReceiverNameOptional.
  ///
  /// In en, this message translates to:
  /// **'Deposit Receiver Name (Optional)'**
  String get depositReceiverNameOptional;

  /// No description provided for @maxGuestsAllowed.
  ///
  /// In en, this message translates to:
  /// **'Max Guests Allowed'**
  String get maxGuestsAllowed;

  /// No description provided for @numberOfBedrooms.
  ///
  /// In en, this message translates to:
  /// **'Number of Bedrooms'**
  String get numberOfBedrooms;

  /// No description provided for @descriptionOptional.
  ///
  /// In en, this message translates to:
  /// **'Description (Optional)'**
  String get descriptionOptional;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Enter room details, rules, amenities description...'**
  String get descriptionHint;

  /// No description provided for @roomPhotos.
  ///
  /// In en, this message translates to:
  /// **'Room Photos'**
  String get roomPhotos;

  /// No description provided for @pleaseEnterRoomName.
  ///
  /// In en, this message translates to:
  /// **'Please enter room name.'**
  String get pleaseEnterRoomName;

  /// No description provided for @pleaseEnterRoomNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter room number.'**
  String get pleaseEnterRoomNumber;

  /// No description provided for @pleaseEnterFloorDetails.
  ///
  /// In en, this message translates to:
  /// **'Please enter floor details.'**
  String get pleaseEnterFloorDetails;

  /// No description provided for @pleaseSelectRoomType.
  ///
  /// In en, this message translates to:
  /// **'Please select a room type.'**
  String get pleaseSelectRoomType;

  /// No description provided for @pleaseEnterSquareFootage.
  ///
  /// In en, this message translates to:
  /// **'Please enter square footage.'**
  String get pleaseEnterSquareFootage;

  /// No description provided for @pleaseEnterRentalPrice.
  ///
  /// In en, this message translates to:
  /// **'Please enter rental price.'**
  String get pleaseEnterRentalPrice;

  /// No description provided for @pleaseChooseLocationOnMap.
  ///
  /// In en, this message translates to:
  /// **'Please choose a location on the map.'**
  String get pleaseChooseLocationOnMap;

  /// No description provided for @latitudeAndLongitudeRequired.
  ///
  /// In en, this message translates to:
  /// **'Latitude and longitude are required.'**
  String get latitudeAndLongitudeRequired;

  /// No description provided for @pleaseUploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Please upload at least 1 room photo.'**
  String get pleaseUploadPhoto;

  /// No description provided for @chooseLocationOnMap.
  ///
  /// In en, this message translates to:
  /// **'Choose location on map'**
  String get chooseLocationOnMap;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @agreementDetails.
  ///
  /// In en, this message translates to:
  /// **'Agreement Details'**
  String get agreementDetails;

  /// No description provided for @leaseDuration.
  ///
  /// In en, this message translates to:
  /// **'Lease Duration'**
  String get leaseDuration;

  /// No description provided for @leaseExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Lease Expiry Date'**
  String get leaseExpiryDate;

  /// No description provided for @financialSummary.
  ///
  /// In en, this message translates to:
  /// **'Financial Summary'**
  String get financialSummary;

  /// No description provided for @rentSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Rent Subtotal ({count} mos)'**
  String rentSubtotal(int count);

  /// No description provided for @securityDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get securityDeposit;

  /// No description provided for @depositReceiver.
  ///
  /// In en, this message translates to:
  /// **'Deposit Receiver'**
  String get depositReceiver;

  /// No description provided for @totalPaymentDue.
  ///
  /// In en, this message translates to:
  /// **'Total Payment Due'**
  String get totalPaymentDue;

  /// No description provided for @agreementFinalizedLocked.
  ///
  /// In en, this message translates to:
  /// **'Agreement Finalized & Locked'**
  String get agreementFinalizedLocked;

  /// No description provided for @acknowledgeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Acknowledge & Confirm'**
  String get acknowledgeConfirm;

  /// No description provided for @contractConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Contract Confirmed'**
  String get contractConfirmed;

  /// No description provided for @ownerConfirmedContract.
  ///
  /// In en, this message translates to:
  /// **'Owner-Confirmed Contract'**
  String get ownerConfirmedContract;

  /// No description provided for @agreementFinalizedLockedDesc.
  ///
  /// In en, this message translates to:
  /// **'This agreement is finalized and locked.'**
  String get agreementFinalizedLockedDesc;

  /// No description provided for @reviewTermsBeforeSaving.
  ///
  /// In en, this message translates to:
  /// **'Review the terms set by the owner before saving.'**
  String get reviewTermsBeforeSaving;

  /// No description provided for @rentalAgreementVoucher.
  ///
  /// In en, this message translates to:
  /// **'RENTAL AGREEMENT VOUCHER'**
  String get rentalAgreementVoucher;

  /// No description provided for @contractId.
  ///
  /// In en, this message translates to:
  /// **'Contract ID'**
  String get contractId;

  /// No description provided for @bookingId.
  ///
  /// In en, this message translates to:
  /// **'Booking ID'**
  String get bookingId;

  /// No description provided for @termsAndNotes.
  ///
  /// In en, this message translates to:
  /// **'Terms & Notes'**
  String get termsAndNotes;

  /// No description provided for @monthsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Months'**
  String monthsCount(int count);

  /// No description provided for @noContractFound.
  ///
  /// In en, this message translates to:
  /// **'No contract founded'**
  String get noContractFound;

  /// No description provided for @failedToUpdateContract.
  ///
  /// In en, this message translates to:
  /// **'Failed to update contract: {reason}'**
  String failedToUpdateContract(String reason);

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @monthlyRent.
  ///
  /// In en, this message translates to:
  /// **'Monthly Rent'**
  String get monthlyRent;

  /// No description provided for @contractSaved.
  ///
  /// In en, this message translates to:
  /// **'Contract Saved!'**
  String get contractSaved;

  /// No description provided for @contractSuccessDesc.
  ///
  /// In en, this message translates to:
  /// **'Your rental agreement voucher has been successfully created and saved. You can review the details anytime in your contract list.'**
  String get contractSuccessDesc;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @tenantTerms.
  ///
  /// In en, this message translates to:
  /// **'Tenant Terms'**
  String get tenantTerms;

  /// No description provided for @ownerTerms.
  ///
  /// In en, this message translates to:
  /// **'Owner Terms'**
  String get ownerTerms;

  /// No description provided for @tenantTerm1Title.
  ///
  /// In en, this message translates to:
  /// **'General Usage & Account Responsibility'**
  String get tenantTerm1Title;

  /// No description provided for @tenantTerm1Content.
  ///
  /// In en, this message translates to:
  /// **'By creating an account and using the Rental Room application, Tenants agree to provide accurate, truthful identification information. Tenants are responsible for keeping their login credentials confidential and must not share their account with unauthorized third parties.'**
  String get tenantTerm1Content;

  /// No description provided for @tenantTerm2Title.
  ///
  /// In en, this message translates to:
  /// **'Rental Agreements & Lease Obligations'**
  String get tenantTerm2Title;

  /// No description provided for @tenantTerm2Content.
  ///
  /// In en, this message translates to:
  /// **'Any rental, lease, or sublease agreement entered into is strictly a legal contract between the Tenant and the Property Owner. The Rental Room platform acts solely as an informational directory and is not liable for monetary disputes, lease breaches, or property damages.'**
  String get tenantTerm2Content;

  /// No description provided for @tenantTerm3Title.
  ///
  /// In en, this message translates to:
  /// **'House Rules, Respect & Quiet Hours'**
  String get tenantTerm3Title;

  /// No description provided for @tenantTerm3Content.
  ///
  /// In en, this message translates to:
  /// **'Tenants agree to strictly follow all house rules specified in the property listing, including noise guidelines, visitor policies, parking regulations, and timely rent payment schedules.'**
  String get tenantTerm3Content;

  /// No description provided for @tenantTerm4Title.
  ///
  /// In en, this message translates to:
  /// **'Cancellation & Refund Policy'**
  String get tenantTerm4Title;

  /// No description provided for @tenantTerm4Content.
  ///
  /// In en, this message translates to:
  /// **'Booking cancellations and security deposit refunds are subject to the specific terms outlined by the Property Owner in the property listing agreement.'**
  String get tenantTerm4Content;

  /// No description provided for @ownerTerm1Title.
  ///
  /// In en, this message translates to:
  /// **'Listing Accuracy & Transparency'**
  String get ownerTerm1Title;

  /// No description provided for @ownerTerm1Content.
  ///
  /// In en, this message translates to:
  /// **'Property Owners must provide truthful details regarding room pricing, amenities, and property condition. Deliberately misleading information may lead to account suspension.'**
  String get ownerTerm1Content;

  /// No description provided for @ownerTerm2Title.
  ///
  /// In en, this message translates to:
  /// **'Location & Map Coordinates'**
  String get ownerTerm2Title;

  /// No description provided for @ownerTerm2Content.
  ///
  /// In en, this message translates to:
  /// **'Providing exact latitude and longitude map coordinates is optional. While exact coordinates help tenants locate rooms easily, owners may choose to leave map location fields empty without restriction.'**
  String get ownerTerm2Content;

  /// No description provided for @ownerTerm3Title.
  ///
  /// In en, this message translates to:
  /// **'Property Right & Safety Compliance'**
  String get ownerTerm3Title;

  /// No description provided for @ownerTerm3Content.
  ///
  /// In en, this message translates to:
  /// **'Property Owners represent that they hold legal rights to sublet or rent out the listed property and comply with all local housing safety codes and regulations.'**
  String get ownerTerm3Content;

  /// No description provided for @ownerTerm4Title.
  ///
  /// In en, this message translates to:
  /// **'Fair Treatment & Non-Discrimination'**
  String get ownerTerm4Title;

  /// No description provided for @ownerTerm4Content.
  ///
  /// In en, this message translates to:
  /// **'Property Owners agree to treat all tenant applicants fairly and without discrimination based on race, religion, gender, or nationality.'**
  String get ownerTerm4Content;

  /// No description provided for @agentFees.
  ///
  /// In en, this message translates to:
  /// **'Agent Fees'**
  String get agentFees;

  /// No description provided for @agentName.
  ///
  /// In en, this message translates to:
  /// **'Agent Name'**
  String get agentName;

  /// No description provided for @roomTypeApartment.
  ///
  /// In en, this message translates to:
  /// **'Standard Apartment'**
  String get roomTypeApartment;

  /// No description provided for @roomTypeMiniCondo.
  ///
  /// In en, this message translates to:
  /// **'Mini Condo'**
  String get roomTypeMiniCondo;

  /// No description provided for @roomTypeCondo.
  ///
  /// In en, this message translates to:
  /// **'Full Condominium'**
  String get roomTypeCondo;

  /// No description provided for @roomTypeSingleRoom.
  ///
  /// In en, this message translates to:
  /// **'Single Room Unit'**
  String get roomTypeSingleRoom;

  /// No description provided for @roomTypeDorm.
  ///
  /// In en, this message translates to:
  /// **'Dormitory'**
  String get roomTypeDorm;

  /// No description provided for @roomTypeDouble.
  ///
  /// In en, this message translates to:
  /// **'Double Room'**
  String get roomTypeDouble;

  /// No description provided for @amenityWifi.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get amenityWifi;

  /// No description provided for @amenityAc.
  ///
  /// In en, this message translates to:
  /// **'Air Conditioning'**
  String get amenityAc;

  /// No description provided for @amenityFan.
  ///
  /// In en, this message translates to:
  /// **'Fan'**
  String get amenityFan;

  /// No description provided for @amenityBed.
  ///
  /// In en, this message translates to:
  /// **'Bed'**
  String get amenityBed;

  /// No description provided for @amenityStudyDesk.
  ///
  /// In en, this message translates to:
  /// **'Study Desk'**
  String get amenityStudyDesk;

  /// No description provided for @amenityElevator.
  ///
  /// In en, this message translates to:
  /// **'Elevator'**
  String get amenityElevator;

  /// No description provided for @amenityPowerbank.
  ///
  /// In en, this message translates to:
  /// **'Powerbank'**
  String get amenityPowerbank;

  /// No description provided for @amenityBalcony.
  ///
  /// In en, this message translates to:
  /// **'Balcony'**
  String get amenityBalcony;

  /// No description provided for @amenityFridge.
  ///
  /// In en, this message translates to:
  /// **'Refrigerator'**
  String get amenityFridge;

  /// No description provided for @amenityKitchen.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get amenityKitchen;

  /// No description provided for @amenityShower.
  ///
  /// In en, this message translates to:
  /// **'Shower Room'**
  String get amenityShower;

  /// No description provided for @amenityToilet.
  ///
  /// In en, this message translates to:
  /// **'Toilet'**
  String get amenityToilet;

  /// No description provided for @amenityWaterHeater.
  ///
  /// In en, this message translates to:
  /// **'Water Heater'**
  String get amenityWaterHeater;

  /// No description provided for @amenityParking.
  ///
  /// In en, this message translates to:
  /// **'Free Parking'**
  String get amenityParking;

  /// No description provided for @amenityTv.
  ///
  /// In en, this message translates to:
  /// **'Smart TV'**
  String get amenityTv;

  /// No description provided for @amenityPool.
  ///
  /// In en, this message translates to:
  /// **'Swimming Pool'**
  String get amenityPool;

  /// No description provided for @amenityLaundry.
  ///
  /// In en, this message translates to:
  /// **'Laundry Service'**
  String get amenityLaundry;

  /// No description provided for @stepContactOwner.
  ///
  /// In en, this message translates to:
  /// **'Step 1: Contact Owner'**
  String get stepContactOwner;

  /// No description provided for @stepContactOwnerDesc.
  ///
  /// In en, this message translates to:
  /// **'Reach out to the property owner via phone call to discuss room availability and details. Once contacted, your booking draft will be created automatically.'**
  String get stepContactOwnerDesc;

  /// No description provided for @phoneContacted.
  ///
  /// In en, this message translates to:
  /// **'Phone Contacted'**
  String get phoneContacted;

  /// No description provided for @phoneContactedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'I have spoken with the owner by phone'**
  String get phoneContactedSubtitle;

  /// No description provided for @stepInspectRoom.
  ///
  /// In en, this message translates to:
  /// **'Step 2: Inspect Room'**
  String get stepInspectRoom;

  /// No description provided for @stepInspectRoomDesc.
  ///
  /// In en, this message translates to:
  /// **'Visit the property in person to inspect the room before finalizing your booking.'**
  String get stepInspectRoomDesc;

  /// No description provided for @roomVisited.
  ///
  /// In en, this message translates to:
  /// **'Room Visited'**
  String get roomVisited;

  /// No description provided for @roomVisitedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'I have visited and inspected the room'**
  String get roomVisitedSubtitle;

  /// No description provided for @visitedBadge.
  ///
  /// In en, this message translates to:
  /// **'Visited'**
  String get visitedBadge;

  /// No description provided for @stepReviewSubmit.
  ///
  /// In en, this message translates to:
  /// **'Step 3: Review & Submit'**
  String get stepReviewSubmit;

  /// No description provided for @stepReviewSubmitDesc.
  ///
  /// In en, this message translates to:
  /// **'Review your checklist and submit your booking request to the owner.'**
  String get stepReviewSubmitDesc;

  /// No description provided for @viewRentalContractVoucher.
  ///
  /// In en, this message translates to:
  /// **'View Contract'**
  String get viewRentalContractVoucher;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @deleteDisabledSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Delete Disabled (Submitted)'**
  String get deleteDisabledSubmitted;

  /// No description provided for @deleteBooking.
  ///
  /// In en, this message translates to:
  /// **'Delete Booking'**
  String get deleteBooking;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @visit.
  ///
  /// In en, this message translates to:
  /// **'Visit'**
  String get visit;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @bookingRequest.
  ///
  /// In en, this message translates to:
  /// **'Booking Request'**
  String get bookingRequest;

  /// No description provided for @submitRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submitRequest;

  /// No description provided for @requestSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Request Submitted'**
  String get requestSubmitted;

  /// No description provided for @rentNow.
  ///
  /// In en, this message translates to:
  /// **'Rent Now'**
  String get rentNow;

  /// No description provided for @pleaseCompletePhoneContactFirst.
  ///
  /// In en, this message translates to:
  /// **'Please complete Phone Contact first.'**
  String get pleaseCompletePhoneContactFirst;

  /// No description provided for @pleaseCompleteRoomVisitedFirst.
  ///
  /// In en, this message translates to:
  /// **'Please complete Room Visited first.'**
  String get pleaseCompleteRoomVisitedFirst;

  /// No description provided for @bookingAlreadySubmitted.
  ///
  /// In en, this message translates to:
  /// **'Booking request is already submitted and cannot be changed.'**
  String get bookingAlreadySubmitted;

  /// No description provided for @deleteBookingConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel and delete this booking request?'**
  String get deleteBookingConfirmation;

  /// No description provided for @roomInspection.
  ///
  /// In en, this message translates to:
  /// **'Room Inspection'**
  String get roomInspection;

  /// No description provided for @bookingStepsAndDetails.
  ///
  /// In en, this message translates to:
  /// **'Booking Steps & Details'**
  String get bookingStepsAndDetails;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @phoneCallDone.
  ///
  /// In en, this message translates to:
  /// **'Phone call done'**
  String get phoneCallDone;

  /// No description provided for @visitDone.
  ///
  /// In en, this message translates to:
  /// **'Visit done'**
  String get visitDone;

  /// No description provided for @roomAlreadyRentedNotice.
  ///
  /// In en, this message translates to:
  /// **'This room has already been rented by another tenant. This request is cancelled.'**
  String get roomAlreadyRentedNotice;

  /// No description provided for @bookingRequestConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Your booking request has been confirmed!'**
  String get bookingRequestConfirmed;

  /// No description provided for @bookingNeedsApproval.
  ///
  /// In en, this message translates to:
  /// **'This booking request has status \"{status}\" and needs approval from owner.'**
  String bookingNeedsApproval(String status);

  /// No description provided for @yesDelete.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete'**
  String get yesDelete;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @savedRooms.
  ///
  /// In en, this message translates to:
  /// **'Saved Rooms'**
  String get savedRooms;

  /// No description provided for @noMoreData.
  ///
  /// In en, this message translates to:
  /// **'No more data'**
  String get noMoreData;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Small label above the selected place name in the dashboard header
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Shown in the header when no location is chosen
  ///
  /// In en, this message translates to:
  /// **'Select location'**
  String get selectLocation;

  /// No description provided for @nearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get nearby;

  /// No description provided for @noNearbyRooms.
  ///
  /// In en, this message translates to:
  /// **'No nearby rooms found.'**
  String get noNearbyRooms;

  /// No description provided for @filterOptions.
  ///
  /// In en, this message translates to:
  /// **'Filter Options'**
  String get filterOptions;

  /// No description provided for @filterClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get filterClearAll;

  /// No description provided for @filterPriceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get filterPriceRange;

  /// No description provided for @filterClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get filterClear;

  /// No description provided for @filterFrom.
  ///
  /// In en, this message translates to:
  /// **'from'**
  String get filterFrom;

  /// No description provided for @filterTo.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get filterTo;

  /// No description provided for @filterRoomType.
  ///
  /// In en, this message translates to:
  /// **'Room Type'**
  String get filterRoomType;

  /// No description provided for @filterAllTypes.
  ///
  /// In en, this message translates to:
  /// **'All Types'**
  String get filterAllTypes;

  /// No description provided for @filterRoomNumber.
  ///
  /// In en, this message translates to:
  /// **'Room Number (Bedrooms)'**
  String get filterRoomNumber;

  /// No description provided for @filterAny.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get filterAny;

  /// No description provided for @filterMaxGuests.
  ///
  /// In en, this message translates to:
  /// **'Max Guests'**
  String get filterMaxGuests;

  /// No description provided for @filterApply.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get filterApply;

  /// No description provided for @searchRoomsHint.
  ///
  /// In en, this message translates to:
  /// **'Search rooms, locations...'**
  String get searchRoomsHint;

  /// No description provided for @bookingPriceDetails.
  ///
  /// In en, this message translates to:
  /// **'Price Details'**
  String get bookingPriceDetails;

  /// No description provided for @bookingPeriodTime.
  ///
  /// In en, this message translates to:
  /// **'Period time'**
  String get bookingPeriodTime;

  /// No description provided for @bookingMonthlyPayment.
  ///
  /// In en, this message translates to:
  /// **'Monthly payment'**
  String get bookingMonthlyPayment;

  /// No description provided for @bookingTax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get bookingTax;

  /// No description provided for @bookingTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get bookingTotal;

  /// No description provided for @bookingMonthSingular.
  ///
  /// In en, this message translates to:
  /// **'{count} Month'**
  String bookingMonthSingular(String count);

  /// No description provided for @bookingMonthPlural.
  ///
  /// In en, this message translates to:
  /// **'{count} Months'**
  String bookingMonthPlural(String count);

  /// No description provided for @bookingVoucher.
  ///
  /// In en, this message translates to:
  /// **'Voucher'**
  String get bookingVoucher;

  /// No description provided for @bookingPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get bookingPeriod;

  /// No description provided for @bookingDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get bookingDate;

  /// No description provided for @bookingCheckDateNote.
  ///
  /// In en, this message translates to:
  /// **'Make sure to check your date before making any sort of payments'**
  String get bookingCheckDateNote;

  /// No description provided for @bookingTenantDetails.
  ///
  /// In en, this message translates to:
  /// **'Tenant Details'**
  String get bookingTenantDetails;

  /// No description provided for @bookingOwnerDetails.
  ///
  /// In en, this message translates to:
  /// **'Owner Details'**
  String get bookingOwnerDetails;

  /// No description provided for @bookingPropertyName.
  ///
  /// In en, this message translates to:
  /// **'Property Name'**
  String get bookingPropertyName;

  /// No description provided for @bookingNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get bookingNotAvailable;

  /// No description provided for @itemPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get itemPassword;

  /// No description provided for @itemLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get itemLocation;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a Photo'**
  String get takePhoto;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove Photo'**
  String get removePhoto;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterName;

  /// No description provided for @pleaseEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterPhone;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @userSessionNotFound.
  ///
  /// In en, this message translates to:
  /// **'User session not found.'**
  String get userSessionNotFound;

  /// No description provided for @unableToLoadProfile.
  ///
  /// In en, this message translates to:
  /// **'Unable to load user profile. Please re-login.'**
  String get unableToLoadProfile;

  /// No description provided for @failedToPickImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image: {error}'**
  String failedToPickImage(String error);

  /// No description provided for @failedToUploadImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload profile image: {error}'**
  String failedToUploadImage(String error);

  /// No description provided for @updatePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePasswordTitle;

  /// No description provided for @passwordChangeNote.
  ///
  /// In en, this message translates to:
  /// **'Changing your password will require you to log in again.'**
  String get passwordChangeNote;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @pleaseEnterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter current password'**
  String get pleaseEnterCurrentPassword;

  /// No description provided for @pleaseEnterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter new password'**
  String get pleaseEnterNewPassword;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @pleaseConfirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm new password'**
  String get pleaseConfirmNewPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @myLocation.
  ///
  /// In en, this message translates to:
  /// **'My Location'**
  String get myLocation;

  /// No description provided for @tapChooseLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Choose location on map\" to set your location.'**
  String get tapChooseLocationHint;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @passwordUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully! Please log in again.'**
  String get passwordUpdatedSuccessfully;

  /// No description provided for @locationUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Location updated successfully!'**
  String get locationUpdatedSuccessfully;

  /// No description provided for @errorSavingRoom.
  ///
  /// In en, this message translates to:
  /// **'Error saving room: {error}'**
  String errorSavingRoom(String error);

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}!'**
  String welcomeBack(String name);

  /// No description provided for @pleaseAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'Please accept the Terms & Conditions to proceed.'**
  String get pleaseAcceptTerms;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account created as {role}!'**
  String accountCreated(String role);

  /// No description provided for @roomCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Room created successfully!'**
  String get roomCreatedSuccessfully;

  /// No description provided for @roomUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Room updated successfully!'**
  String get roomUpdatedSuccessfully;

  /// No description provided for @roomDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Room deleted successfully!'**
  String get roomDeletedSuccessfully;

  /// No description provided for @bookingCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Booking request created successfully!'**
  String get bookingCreatedSuccessfully;

  /// No description provided for @bookingUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Booking updated successfully!'**
  String get bookingUpdatedSuccessfully;

  /// No description provided for @bookingDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Booking request is successfully deleted!'**
  String get bookingDeletedSuccessfully;

  /// No description provided for @contractCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Contract created successfully!'**
  String get contractCreatedSuccessfully;

  /// No description provided for @contractUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Contract updated successfully!'**
  String get contractUpdatedSuccessfully;

  /// No description provided for @ownersCannotFavoriteOwnRooms.
  ///
  /// In en, this message translates to:
  /// **'Owners cannot favorite their own rooms.'**
  String get ownersCannotFavoriteOwnRooms;

  /// No description provided for @thisPhoneAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'This phone number is already registered by another user.'**
  String get thisPhoneAlreadyRegistered;

  /// No description provided for @currentPasswordIncorrect.
  ///
  /// In en, this message translates to:
  /// **'The current password you entered is incorrect.'**
  String get currentPasswordIncorrect;

  /// No description provided for @invalidEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password. Please try again.'**
  String get invalidEmailOrPassword;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered.'**
  String get emailAlreadyInUse;

  /// No description provided for @contractHistory.
  ///
  /// In en, this message translates to:
  /// **'Contract History'**
  String get contractHistory;

  /// No description provided for @activeContracts.
  ///
  /// In en, this message translates to:
  /// **'Active Contracts'**
  String get activeContracts;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
