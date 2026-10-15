// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'အခန်းငှားရန်';

  @override
  String get home => 'အိမ်';

  @override
  String get rooms => 'အခန်းများ';

  @override
  String get booking => 'မှာယူမှုများ';

  @override
  String get profile => 'ပရိုဖိုင်';

  @override
  String get overview => 'အနှစ်ချုပ်';

  @override
  String get owner => 'ပိုင်ရှင်';

  @override
  String get tenant => 'အိမ်ငှားသူ';

  @override
  String get propertyOwner => 'အိမ်ခြံမြေပိုင်ရှင်';

  @override
  String get rentalRoomUser => 'Rental Room အသုံးပြုသူ';

  @override
  String get savedCount => 'သိမ်းဆည်းထားသူ အရေအတွက်';

  @override
  String get signOut => 'ထွက်ရန်';

  @override
  String get settings => 'ဆက်တင်များ';

  @override
  String get settingsPreferences => 'ဆက်တင်နှင့် ရွေးချယ်မှုများ';

  @override
  String get theme => 'အသွင်အပြင်';

  @override
  String get darkMode => 'အမှောင်မုဒ်';

  @override
  String get lightMode => 'အလင်းမုဒ်';

  @override
  String get language => 'ဘာသာစကား';

  @override
  String get english => 'အင်္ဂလိပ်';

  @override
  String get myanmar => 'မြန်မာ';

  @override
  String get editProfile => 'ပရိုဖိုင် ပြင်ဆင်ရန်';

  @override
  String get editPassword => 'စကားဝှက် ပြင်ဆင်ရန်';

  @override
  String get updateLocation => 'တည်နေရာ ပြင်ဆင်ရန်';

  @override
  String get termsAndConditions => 'စည်းမျဉ်းစည်းကမ်းများ';

  @override
  String get userGuidance => 'အသုံးပြုနည်းလမ်းညွှန်နှင့် အကူအညီ';

  @override
  String get exitApp => 'အက်ပ်မှ ထွက်ရန်';

  @override
  String get exitAppConfirm => 'အက်ပ်မှ ထွက်လိုသည်မှာ သေချာပါသလား။';

  @override
  String get exit => 'ထွက်မည်';

  @override
  String get cancel => 'မလုပ်တော့ပါ';

  @override
  String get availableRooms => 'ငှားရန်ရနိုင်သော အခန်းများ';

  @override
  String get pendingRequests => 'စောင့်ဆိုင်းဆဲ တောင်းဆိုမှုများ';

  @override
  String get totalOccupancy => 'စုစုပေါင်း နေထိုင်မှုနှုန်း';

  @override
  String get overallOccupancyRate =>
      'အခန်းအားလုံး၏ စုစုပေါင်း နေထိုင်မှုနှုန်း';

  @override
  String usersSavedListing(int count) {
    return 'သင့်စာရင်းကို အသုံးပြုသူ $count ဦး သိမ်းဆည်းထားသည်';
  }

  @override
  String roomsCurrentlyOccupied(int count) {
    return 'လက်ရှိ ငှားထားသော အခန်း $count ခန်း';
  }

  @override
  String pendingInquiries(int count) {
    return 'စောင့်ဆိုင်းဆဲ အိမ်ငှားသူ ကြိုတင်မှာယူမှု $count ခု';
  }

  @override
  String contractRevenueRange(String startMonth, String endMonth) {
    return '$startMonth - $endMonth စာချုပ်ဝင်ငွေ';
  }

  @override
  String totalRevenuePerMonth(String amount, int count) {
    return 'စုစုပေါင်း: $amount / လ (လက်ရှိငှားရမ်းမှု $count ခု)';
  }

  @override
  String get monthJan => 'ဇန်';

  @override
  String get monthFeb => 'ဖေ';

  @override
  String get monthMar => 'မတ်';

  @override
  String get monthApr => 'ဧပြီ';

  @override
  String get monthMay => 'မေ';

  @override
  String get monthJun => 'ဇွန်';

  @override
  String get monthJul => 'ဇူ';

  @override
  String get monthAug => 'ဩ';

  @override
  String get monthSep => 'စက်';

  @override
  String get monthOct => 'အောက်';

  @override
  String get monthNov => 'နို';

  @override
  String get monthDec => 'ဒီ';

  @override
  String get latestProperties => 'အခန်းများ';

  @override
  String get seeAll => 'အားလုံးကြည့်ရန်';

  @override
  String get all => 'အားလုံး';

  @override
  String get available => 'ငှားရန်ရနိုင်သည်';

  @override
  String get rented => 'ငှားထားပြီး';

  @override
  String get noAvailableRooms => 'ငှားရန်ရနိုင်သော အခန်း မတွေ့ပါ။';

  @override
  String get noRentedRooms => 'ငှားထားပြီးသော အခန်း မတွေ့ပါ။';

  @override
  String get noPropertiesYet => 'ထည့်သွင်းထားသော အခန်း မရှိသေးပါ။';

  @override
  String get categories => 'အမျိုးအစားများ';

  @override
  String get recommended => 'အကြံပြုချက်';

  @override
  String recommendedWithType(String type) {
    return 'အကြံပြုချက် · $type';
  }

  @override
  String get noRoomsAvailable => 'ငှားရန်ရနိုင်သော အခန်း မရှိပါ။';

  @override
  String noTypeAvailable(String type) {
    return '$type မရှိပါ။';
  }

  @override
  String get miniCondo => 'မီနီကွန်ဒို';

  @override
  String get noMiniCondos => 'ငှားရန်ရနိုင်သော မီနီကွန်ဒို မရှိပါ။';

  @override
  String errorLoadingRooms(String message) {
    return 'အခန်းများ ဖတ်ရာတွင် အမှား ဖြစ်ပွားသည်: $message';
  }

  @override
  String get promoCashback => '၂၀% ငွေပြန်အမ်း\nရယူလိုက်ပါ';

  @override
  String get promoExpired => '*၂၀၂၆ ဒီဇင်ဘာ ၂၅ တွင် ကုန်ဆုံးမည်';

  @override
  String visitorFavorited(int count) {
    return 'ဧည့်သည် $count ဦး ဤအခန်းကို နှစ်သက်သည်';
  }

  @override
  String visitorViewed(int count) {
    return 'ဧည့်သည် $count ဦး ဤအခန်းကို ကြည့်ရှုခဲ့သည်';
  }

  @override
  String get details => 'အသေးစိတ်';

  @override
  String get amenities => 'ဝန်ဆောင်မှုများ';

  @override
  String get photos => 'ဓာတ်ပုံများ';

  @override
  String get editRoomListing => 'အခန်းစာရင်း ပြင်ဆင်ရန်';

  @override
  String get editDetailRoom => 'အခန်းအသေးစိတ် ပြင်ဆင်ရန်';

  @override
  String get pending => 'စောင့်ဆိုင်းဆဲ';

  @override
  String get confirmed => 'အတည်ပြုပြီး';

  @override
  String get contracted => 'စာချုပ်ချုပ်ပြီး';

  @override
  String get expired => 'သက်တမ်းကုန်ပြီ';

  @override
  String get noPendingBookings => 'စောင့်ဆိုင်းဆဲ ကြိုတင်မှာယူမှု မရှိပါ။';

  @override
  String get noConfirmedBookings => 'အတည်ပြုပြီး ကြိုတင်မှာယူမှု မရှိပါ။';

  @override
  String get noContractedBookings => 'စာချုပ်ချုပ်ပြီး ကြိုတင်မှာယူမှု မရှိပါ။';

  @override
  String get contractExpired => 'စာချုပ်သက်တမ်းကုန်ပြီ';

  @override
  String daysLeft(int count) {
    return '$count ရက်ကျန်သည်';
  }

  @override
  String durationMonths(int count) {
    return '$count လ';
  }

  @override
  String get requested => 'တောင်းဆိုသည့်ရက်';

  @override
  String get roomPrice => 'အခန်းဈေးနှုန်း';

  @override
  String get contactPhone => 'ဆက်သွယ်ရန်ဖုန်း';

  @override
  String get acceptConfirm => 'လက်ခံပြီး အတည်ပြုမည်';

  @override
  String get description => 'ဖော်ပြချက်';

  @override
  String get noDescription => 'ဤအခန်းအတွက် ဖော်ပြချက် မရှိပါ။';

  @override
  String get showMore => 'ပိုမိုကြည့်ရန်';

  @override
  String get showLess => 'လျှော့ကြည့်ရန်';

  @override
  String get propertyHost => 'အိမ်ရှင်';

  @override
  String get locationMap => 'တည်နေရာ မြေပုံ';

  @override
  String get openMap => 'မြေပုံဖွင့်ရန်';

  @override
  String get locationNotProvided => 'တည်နေရာ မပေးထားပါ';

  @override
  String get loadingVisitorStats => 'ကြည့်ရှုသူ စာရင်းများ ရယူနေသည်...';

  @override
  String get visitorTrackText =>
      'ဤအခန်းစာရင်းအတွက် ကြည့်ရှုမှုနှင့် စိတ်ဝင်စားမှုကို ခြေရာခံပါ။';

  @override
  String beds(int count) {
    return 'အိပ်ခန်း $count ခန်း';
  }

  @override
  String guests(int count) {
    return 'ဧည့်သည် $count ဦး';
  }

  @override
  String sqft(String value) {
    return '$value စတုရန်းပေ';
  }

  @override
  String floorShort(String floor) {
    return '$floor ထပ်';
  }

  @override
  String errorOpeningMap(String error) {
    return 'မြေပုံဖွင့်ရာတွင် အမှား: $error';
  }

  @override
  String get deleteRoom => 'အခန်းဖျက်မည်';

  @override
  String get price => 'စျေးနှုန်း';

  @override
  String get editRoomDetails => 'အခန်းအသေးစိတ် ပြင်ဆင်ရန်';

  @override
  String get trackEngagement =>
      'သင်၏ အိမ်ခြံမြေ စာရင်းအတွက် စိတ်ဝင်စားမှုကို လေ့လာပါ။';

  @override
  String userFavoritedRoom(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'အသုံးပြုသူ $count ဦး ဒီအခန်းကို နှစ်သက်ထားသည်',
      one: 'အသုံးပြုသူ ၁ ဦး ဒီအခန်းကို နှစ်သက်ထားသည်',
    );
    return '$_temp0';
  }

  @override
  String get addRoomListing => 'အခန်းသစ် ထည့်သွင်းရန်';

  @override
  String get createRoom => 'အခန်းသစ် ဖန်တီးမည်';

  @override
  String get updateRoom => 'အခန်း ပြင်ဆင်မည်';

  @override
  String get next => 'ရှေ့သို့';

  @override
  String get roomLocation => 'အခန်း တည်နေရာ';

  @override
  String get latitude => 'လတ္တီတွဒ်';

  @override
  String get longitude => 'လောင်ဂျီတွဒ်';

  @override
  String get roomNameTitle => 'အခန်းအမည် / ခေါင်းစဉ်';

  @override
  String get roomNameHint => 'ဥပမာ - သာယာသော ဒီလက်စ် အခန်း ၁၀၁';

  @override
  String get roomNumber => 'အခန်းနံပါတ်';

  @override
  String get floor => 'အထပ်';

  @override
  String get roomType => 'အခန်းအမျိုးအစား';

  @override
  String get roomSqft => 'စတုရန်းပေ';

  @override
  String get pricePerMonth => '၁ လ စျေးနှုန်း';

  @override
  String get depositAmountOptional => 'စပါယ်ငွေ (စိတ်ကြိုက်)';

  @override
  String get depositReceiverNameOptional =>
      'စပါယ်ငွေ လက်ခံသူ အမည် (စိတ်ကြိုက်)';

  @override
  String get maxGuestsAllowed => 'လက်ခံနိုင်သော ဧည့်သည် အရေအတွက်';

  @override
  String get numberOfBedrooms => 'အိပ်ခန်း အရေအတွက်';

  @override
  String get descriptionOptional => 'ဖော်ပြချက် (စိတ်ကြိုက်)';

  @override
  String get descriptionHint =>
      'အခန်းအသေးစိတ်၊ စည်းကမ်းချက်များကို ရေးသားပါ...';

  @override
  String get roomPhotos => 'အခန်း ဓာတ်ပုံများ';

  @override
  String get pleaseEnterRoomName => 'ကျေးဇူးပြု၍ အခန်းအမည် ထည့်ပါ။';

  @override
  String get pleaseEnterRoomNumber => 'ကျေးဇူးပြု၍ အခန်းနံပါတ် ထည့်ပါ။';

  @override
  String get pleaseEnterFloorDetails => 'ကျေးဇူးပြု၍ အထပ် အချက်အလက် ထည့်ပါ။';

  @override
  String get pleaseSelectRoomType => 'ကျေးဇူးပြု၍ အခန်းအမျိုးအစား ရွေးပါ။';

  @override
  String get pleaseEnterSquareFootage => 'ကျေးဇူးပြု၍ စတုရန်းပေ ထည့်ပါ။';

  @override
  String get pleaseEnterRentalPrice => 'ကျေးဇူးပြု၍ အခန်းခ ထည့်ပါ။';

  @override
  String get pleaseChooseLocationOnMap =>
      'ကျေးဇူးပြု၍ မြေပုံပေါ်တွင် တည်နေရာ ရွေးပါ။';

  @override
  String get latitudeAndLongitudeRequired =>
      'လတ္တီကျုနှင့် လောင်ဂျီကျု လိုအပ်ပါသည်။';

  @override
  String get pleaseUploadPhoto => 'ကျေးဇူးပြု၍ အနည်းဆုံး ဓာတ်ပုံ ၁ ပုံ တင်ပါ။';

  @override
  String get chooseLocationOnMap => 'မြေပုံပေါ်တွင် တည်နေရာ ရွေးရန်';

  @override
  String get required => 'လိုအပ်ပါသည်';

  @override
  String get agreementDetails => 'သဘောတူညီချက် အသေးစိတ်';

  @override
  String get leaseDuration => 'ငှားရမ်းသည့် ကာလ';

  @override
  String get leaseExpiryDate => 'စာချုပ် ကုန်ဆုံးမည့်ရက်';

  @override
  String get financialSummary => 'ငွေကြေးဆိုင်ရာ အကျဉ်းချုပ်';

  @override
  String rentSubtotal(int count) {
    return 'ငှားရမ်းခ စုစုပေါင်း ($count လ)';
  }

  @override
  String get securityDeposit => 'စရံငွေ';

  @override
  String get depositReceiver => 'စရံငွေ လက်ခံသူ';

  @override
  String get totalPaymentDue => 'ပေးချေရမည့် စုစုပေါင်းငွေ';

  @override
  String get agreementFinalizedLocked => 'စာချုပ် အတည်ပြုပြီး & သော့ခတ်ထားသည်';

  @override
  String get acknowledgeConfirm => 'လက်ခံအတည်ပြုသည်';

  @override
  String get contractConfirmed => 'စာချုပ် အတည်ပြုပြီး';

  @override
  String get ownerConfirmedContract => 'ပိုင်ရှင် အတည်ပြုထားသော စာချုပ်';

  @override
  String get agreementFinalizedLockedDesc =>
      'ဤသဘောတူညီချက်ကို အတည်ပြုပြီး သော့ခတ်ထားသည်။';

  @override
  String get reviewTermsBeforeSaving =>
      'မသိမ်းဆည်းမီ ပိုင်ရှင် သတ်မှတ်ထားသော စည်းကမ်းချက်များကို စစ်ဆေးပါ။';

  @override
  String get rentalAgreementVoucher => 'အခန်းငှားရမ်းမှု စာချုပ်';

  @override
  String get contractId => 'စာချုပ် အမှတ်စဉ်';

  @override
  String get bookingId => 'ကြိုတင်မှာယူမှု အမှတ်စဉ်';

  @override
  String get termsAndNotes => 'စည်းကမ်းချက်များနှင့် မှတ်စုများ';

  @override
  String monthsCount(int count) {
    return '$count လ';
  }

  @override
  String get noContractFound =>
      'ဤကြိုတင်မှာယူမှုအတွက် စာချုပ်မတွေ့ပါ။ ပိုင်ရှင်မှ စာချုပ်ထုတ်ပေးရပါမည်။';

  @override
  String failedToUpdateContract(String reason) {
    return 'စာချုပ် အပ်ဒိတ်လုပ်ရန် မအောင်မြင်ပါ: $reason';
  }

  @override
  String get startDate => 'စတင်မည့် ရက်စွဲ';

  @override
  String get endDate => 'ကုန်ဆုံးမည့် ရက်စွဲ';

  @override
  String get monthlyRent => 'လစဉ်ငှားရမ်းခ';

  @override
  String get contractSaved => 'စာချုပ် သိမ်းဆည်းပြီးပါပြီ!';

  @override
  String get contractSuccessDesc =>
      'သင့်အခန်းငှားရမ်းမှု စာချုပ်ကို အောင်မြင်စွာ ဖန်တီးပြီး သိမ်းဆည်းပြီးပါပြီ။ သင့်စာချုပ်စာရင်းတွင် အသေးစိတ်ကို အချိန်မရွေး ပြန်လည်စစ်ဆေးနိုင်ပါသည်။';

  @override
  String get done => 'ပြီးပြီ';

  @override
  String get tenantTerms => 'ငှားရမ်းသူ စည်းမျဉ်းများ';

  @override
  String get ownerTerms => 'ပိုင်ရှင် စည်းမျဉ်းများ';

  @override
  String get tenantTerm1Title => 'အထွေထွေ အသုံးပြုမှုနှင့် အကောင့် တာဝန်ယူမှု';

  @override
  String get tenantTerm1Content =>
      'Rental Room အက်ပ်ကို အသုံးပြု၍ အကောင့်ဖန်တီးခြင်းဖြင့် ငှားရမ်းသူများသည် တိကျမှန်ကန်သော ကိုယ်ရေးအချက်အလက်များကို ပေးအပ်ရန် သဘောတူပါသည်။ ငှားရမ်းသူများသည် ၎င်းတို့၏ လော့ဂ်အင် အချက်အလက်များ လုံခြုံရေးအတွက် တာဝန်ရှိပြီး ခွင့်ပြုချက်မရှိသော တတိယပုဂ္ဂိုလ်များနှင့် မျှဝေခြင်းမပြုရပါ။';

  @override
  String get tenantTerm2Title =>
      'ငှားရမ်းမှု သဘောတူညီချက်များနှင့် တာဝန်ဝတ္တရားများ';

  @override
  String get tenantTerm2Content =>
      'ပြုလုပ်သမျှ ငှားရမ်းမှု သဘောတူညီချက်များသည် ငှားရမ်းသူနှင့် ပိုင်ရှင်တို့ကြား တရားဝင်စာချုပ် ဖြစ်ပါသည်။ Rental Room ပလပ်ဖောင်းသည် အချက်အလက်လမ်းညွှန်အဖြစ်သာ ဆောင်ရွက်ပြီး ငွေကြေးဆိုင်ရာ အငြင်းပွားမှုများ၊ စာချုပ်ဖောက်ဖျက်မှုများ သို့မဟုတ် ပစ္စည်းပျက်စီးမှုများအတွက် တာဝန်မရှိပါ။';

  @override
  String get tenantTerm3Title =>
      'အိမ်စည်းကမ်းများ၊ လေးစားမှုနှင့် တိတ်ဆိတ်ချိန်များ';

  @override
  String get tenantTerm3Content =>
      'ငှားရမ်းသူများသည် ပစ္စည်းစာရင်းတွင် ဖော်ပြထားသော အိမ်စည်းကမ်းများ၊ ဆူညံသံဆိုင်ရာ လမ်းညွှန်ချက်များ၊ ဧည့်သည် မူဝါဒများ၊ ကားပါကင် စည်းမျဉ်းများနှင့် အချိန်မီ အခန်းခပေးချေမှုများကို တိကျစွာ လိုက်နာရန် သဘောတူပါသည်။';

  @override
  String get tenantTerm4Title => 'ဖျက်သိမ်းခြင်းနှင့် ငွေပြန်အမ်းခြင်း မူဝါဒ';

  @override
  String get tenantTerm4Content =>
      'ကြိုတင်မှာယူမှု ဖျက်သိမ်းခြင်းနှင့် စရံငွေ ပြန်အမ်းခြင်းများသည် ပိုင်ရှင်မှ ဖော်ပြထားသော သီးသန့်စည်းကမ်းချက်များနှင့် သက်ဆိုင်ပါသည်။';

  @override
  String get ownerTerm1Title => 'စာရင်း တိကျမှုနှင့် ပွင့်လင်းမြင်သာမှု';

  @override
  String get ownerTerm1Content =>
      'ပိုင်ရှင်များသည် အခန်းဈေးနှုန်း၊ အသုံးအဆောင်များနှင့် ပစ္စည်းအခြေအနေတို့နှင့် ပတ်သက်၍ မှန်ကန်သော အသေးစိတ်အချက်အလက်များကို ပေးရမည်။ ရည်ရွယ်ချက်ရှိရှိ လှည့်စားသော အချက်အလက်များသည် အကောင့် معلق (ရပ်ဆိုင်းခြင်း) ဖြစ်စေနိုင်သည်။';

  @override
  String get ownerTerm2Title => 'တည်နေရာနှင့် မြေပုံ ကိုဩဒိနိတ်များ';

  @override
  String get ownerTerm2Content =>
      'တိကျသော လတ္တီကျုနှင့် လောင်ဂျီကျု မြေပုံ ကိုဩဒိနိတ်များ ပေးခြင်းသည် စိတ်ကြိုက်ဖြစ်ပါသည်။ တိကျသော ကိုဩဒိနိတ်များသည် ငှားရမ်းသူများအား အခန်းများကို လွယ်ကူစွာ ရှာဖွေတွေ့ရှိရန် ကူညီပေးသော်လည်း ပိုင်ရှင်များသည် မြေပုံတည်နေရာ ကွက်လပ်များကို ကွက်လပ်ထားခဲ့နိုင်ပါသည်။';

  @override
  String get ownerTerm3Title =>
      'ပစ္စည်းပိုင်ဆိုင်ခွင့်နှင့် ဘေးကင်းလုံခြုံရေး လိုက်နာမှု';

  @override
  String get ownerTerm3Content =>
      'ပိုင်ရှင်များသည် စာရင်းသွင်းထားသော ပစ္စည်းကို ငှားရမ်းခွင့် သို့မဟုတ် ခွဲငှားခွင့်ဆိုင်ရာ တရားဝင်အခွင့်အရေးများ ရှိကြောင်း ကိုယ်စားပြုပြီး ဒေသဆိုင်ရာ အိမ်ရာ ဘေးကင်းရေး ကုဒ်များနှင့် စည်းမျဉ်းများကို လိုက်နာပါသည်။';

  @override
  String get ownerTerm4Title =>
      'တရားမျှတစွာ ဆက်ဆံမှုနှင့် ခွဲခြားဆက်ဆံမှု မရှိစေရေး';

  @override
  String get ownerTerm4Content =>
      'ပိုင်ရှင်များသည် ငှားရမ်းလိုသူ လျှောက်ထားသူအားလုံးကို လူမျိုး၊ ကိုးကွယ်ရာဘာသာ၊ ကျား/မ သို့မဟုတ် နိုင်ငံသားအပေါ် မူတည်၍ ခွဲခြားဆက်ဆံခြင်းမရှိဘဲ တရားမျှတစွာ ဆက်ဆံရန် သဘောတူပါသည်။';

  @override
  String get agentFees => 'အေးဂျင့် အခကြေးငွေ';

  @override
  String get agentName => 'အေးဂျင့် အမည်';

  @override
  String get roomTypeApartment => 'တိုက်ခန်း';

  @override
  String get roomTypeMiniCondo => 'မီနီကွန်ဒို';

  @override
  String get roomTypeCondo => 'ကွန်ဒို အပြည့်အစုံ';

  @override
  String get roomTypeSingleRoom => 'တစ်ခန်းရပ် အခန်း';

  @override
  String get roomTypeDorm => 'အဆောင်ခန်း';

  @override
  String get roomTypeDouble => 'နှစ်ခန်းတွဲ အခန်း';

  @override
  String get amenityWifi => 'ဝိုင်ဖိုင် (WiFi)';

  @override
  String get amenityAc => 'လေအေးပေးစက် (AC)';

  @override
  String get amenityFan => 'ပန်ကာ';

  @override
  String get amenityBed => 'အိပ်ရာ';

  @override
  String get amenityStudyDesk => 'စာရေးစားပွဲ';

  @override
  String get amenityElevator => 'ဓာတ်လှေကား';

  @override
  String get amenityPowerbank => 'ပါဝါဘဏ်';

  @override
  String get amenityBalcony => 'ဝရံတာ';

  @override
  String get amenityFridge => 'ရေခဲသေတ္တာ';

  @override
  String get amenityKitchen => 'မီးဖိုချောင်';

  @override
  String get amenityShower => 'ရေချိုးခန်း';

  @override
  String get amenityToilet => 'အိမ်သာ';

  @override
  String get amenityWaterHeater => 'ရေပူစက်';

  @override
  String get amenityParking => 'ကားပါကင် အခမဲ့';

  @override
  String get amenityTv => 'စမတ် တီဗီ';

  @override
  String get amenityPool => 'ရေကူးကန်';

  @override
  String get amenityLaundry => 'အဝတ်လျှော် ဝန်ဆောင်မှု';

  @override
  String get stepContactOwner => 'အဆင့် ၁: ပိုင်ရှင်ထံ ဆက်သွယ်ရန်';

  @override
  String get stepContactOwnerDesc =>
      'အခန်းရရှိနိုင်မှုနှင့် အသေးစိတ်အချက်အလက်များကို ဆွေးနွေးရန် ပိုင်ရှင်ထံ ဖုန်းခေါ်ဆို၍ ဆက်သွယ်ပါ။ ဆက်သွယ်ပြီးသည်နှင့် သင့်ကြိုတင်မှာယူမှု မူကြမ်းကို အလိုအလျောက် ဖန်တီးပေးမည်ဖြစ်ပါသည်။';

  @override
  String get phoneContacted => 'ဖုန်းဖြင့် ဆက်သွယ်ပြီးပြီ';

  @override
  String get phoneContactedSubtitle =>
      'ပိုင်ရှင်နှင့် ဖုန်းဖြင့် ပြောဆိုပြီးပါပြီ';

  @override
  String get stepInspectRoom => 'အဆင့် ၂: အခန်း စစ်ဆေးရန်';

  @override
  String get stepInspectRoomDesc =>
      'သင့်ကြိုတင်မှာယူမှုကို အပြီးမသတ်မီ အခန်းကို ကိုယ်တိုင်သွားရောက် စစ်ဆေးပါ။';

  @override
  String get roomVisited => 'အခန်း သွားရောက်ကြည့်ပြီးပြီ';

  @override
  String get roomVisitedSubtitle => 'အခန်းကို သွားရောက် စစ်ဆေးပြီးပါပြီ';

  @override
  String get visitedBadge => 'ကြည့်ပြီး';

  @override
  String get stepReviewSubmit => 'အဆင့် ၃: စစ်ဆေးပြီး တင်သွင်းရန်';

  @override
  String get stepReviewSubmitDesc =>
      'သင့် စစ်ဆေးချက်စာရင်းကို ပြန်လည်စစ်ဆေးပြီး ပိုင်ရှင်ထံ ကြိုတင်မှာယူမှု တောင်းဆိုချက်ကို တင်သွင်းပါ။';

  @override
  String get viewRentalContractVoucher => 'စာချုပ်ကြည့်ရန်';

  @override
  String get completed => 'ပြီးစီးသည်';

  @override
  String get deleteDisabledSubmitted => 'ဖျက်၍မရပါ (တင်သွင်းပြီး)';

  @override
  String get deleteBooking => 'ကြိုတင်မှာယူမှု ဖျက်ရန်';

  @override
  String get contact => 'ဆက်သွယ်ရန်';

  @override
  String get visit => 'ကြည့်ရှုရန်';

  @override
  String get submit => 'တင်သွင်းရန်';

  @override
  String get bookingRequest => 'ကြိုတင်မှာယူမှု တောင်းဆိုချက်';

  @override
  String get submitRequest => 'တောင်းဆိုချက် တင်သွင်းရန်';

  @override
  String get requestSubmitted => 'တောင်းဆိုချက် တင်သွင်းပြီးပါပြီ';

  @override
  String get rentNow => 'ယခု ငှားရမ်းမည်';

  @override
  String get pleaseCompletePhoneContactFirst =>
      'ကျေးဇူးပြု၍ ဖုန်းဖြင့် ဆက်သွယ်မှုကို ဦးစွာ လုပ်ဆောင်ပါ။';

  @override
  String get pleaseCompleteRoomVisitedFirst =>
      'ကျေးဇူးပြု၍ အခန်း သွားရောက်ကြည့်ရှုမှုကို ဦးစွာ လုပ်ဆောင်ပါ။';

  @override
  String get bookingAlreadySubmitted =>
      'ကြိုတင်မှာယူမှု တောင်းဆိုချက်ကို တင်သွင်းပြီးဖြစ်၍ ပြုပြင်၍မရပါ။';

  @override
  String get deleteBookingConfirmation =>
      'ဤကြိုတင်မှာယူမှု တောင်းဆိုချက်ကို ဖျက်သိမ်းရန် သေချာပါသလား။';

  @override
  String get roomInspection => 'အခန်း စစ်ဆေးခြင်း';

  @override
  String get bookingStepsAndDetails =>
      'ကြိုတင်မှာယူမှု အဆင့်များနှင့် အသေးစိတ်';

  @override
  String get back => 'နောက်သို့';

  @override
  String get phoneCallDone => 'ဖုန်းဆက်သွယ်မှု ပြီးစီးပါပြီ';

  @override
  String get visitDone => 'သွားရောက်ကြည့်ရှုမှု ပြီးစီးပါပြီ';

  @override
  String get roomAlreadyRentedNotice =>
      'ဤအခန်းကို အခြားငှားရမ်းသူမှ ငှားရမ်းပြီးဖြစ်၍ ဤတောင်းဆိုချက်ကို ပယ်ဖျက်လိုက်ပါပြီ။';

  @override
  String get bookingRequestConfirmed =>
      'သင့်ကြိုတင်မှာယူမှု တောင်းဆိုချက်ကို အတည်ပြုပြီးပါပြီ!';

  @override
  String bookingNeedsApproval(String status) {
    return 'ဤကြိုတင်မှာယူမှု တောင်းဆိုချက်မှာ အခြေအနေ \"$status\" ဖြစ်ပြီး ပိုင်ရှင်၏ အတည်ပြုချက် လိုအပ်ပါသည်။';
  }

  @override
  String get yesDelete => 'ဟုတ်ကဲ့၊ ဖျက်မည်';

  @override
  String get favorites => 'အကြိုက်ဆုံးများ';

  @override
  String get savedRooms => 'သိမ်းဆည်းထားသော အခန်းများ';

  @override
  String get noMoreData => 'ဒေတာ ထပ်မရှိတော့ပါ';

  @override
  String get retry => 'ထပ်ကြိုးစားရန်';

  @override
  String get location => 'တည်နေရာ';

  @override
  String get selectLocation => 'တည်နေရာ ရွေးချယ်ပါ';

  @override
  String get nearby => 'အနီးအနား';

  @override
  String get noNearbyRooms => 'အနီးအနားတွင် အခန်းများ မရှိသေးပါ။';

  @override
  String get filterOptions => 'စစ်ထုတ်ရန် ရွေးချယ်မှုများ';

  @override
  String get filterClearAll => 'အကုန်ရှင်း';

  @override
  String get filterPriceRange => 'စျေးနှုန်း အကွာအဝေး';

  @override
  String get filterClear => 'ရှင်းလင်းရန်';

  @override
  String get filterFrom => 'မှ';

  @override
  String get filterTo => 'အထိ';

  @override
  String get filterRoomType => 'အခန်းအမျိုးအစား';

  @override
  String get filterAllTypes => 'အမျိုးအစားအားလုံး';

  @override
  String get filterRoomNumber => 'အခန်းအရေအတွက် (အိပ်ခန်း)';

  @override
  String get filterAny => 'ဘာဖြစ်ဖြစ်';

  @override
  String get filterMaxGuests => 'ဧည့်သည် အများဆုံး';

  @override
  String get filterApply => 'စစ်ထုတ်မှု အသုံးပြုရန်';

  @override
  String get searchRoomsHint => 'အခန်း၊ တည်နေရာ ရှာဖွေရန်...';

  @override
  String get bookingPriceDetails => 'စျေးနှုန်း အသေးစိတ်';

  @override
  String get bookingPeriodTime => 'ကာလ';

  @override
  String get bookingMonthlyPayment => 'လစဉ်ပေးချေမှု';

  @override
  String get bookingTax => 'အခွန်';

  @override
  String get bookingTotal => 'စုစုပေါင်း';

  @override
  String bookingMonthSingular(String count) {
    return '$count လ';
  }

  @override
  String bookingMonthPlural(String count) {
    return '$count လ';
  }

  @override
  String get bookingVoucher => 'ဘောက်ချာ';

  @override
  String get bookingPeriod => 'ကာလ';

  @override
  String get bookingDate => 'ရက်စွဲ';

  @override
  String get bookingCheckDateNote =>
      'ငွေပေးချေမှု မပြုလုပ်မီ သင့်ရက်စွဲကို စစ်ဆေးပါ';

  @override
  String get bookingTenantDetails => 'ငှားရမ်းသူ အသေးစိတ်';

  @override
  String get bookingOwnerDetails => 'ပိုင်ရှင် အသေးစိတ်';

  @override
  String get bookingPropertyName => 'ပစ္စည်းအမည်';

  @override
  String get bookingNotAvailable => 'မရှိပါ';

  @override
  String get itemPassword => 'စကားဝှက်';

  @override
  String get itemLocation => 'တည်နေရာ';

  @override
  String get editProfileTitle => 'ပရိုဖိုင် ပြင်ဆင်ရန်';

  @override
  String get chooseFromGallery => 'ဓာတ်ပုံပြခန်းမှ ရွေးရန်';

  @override
  String get takePhoto => 'ဓာတ်ပုံရိုက်ရန်';

  @override
  String get removePhoto => 'ဓာတ်ပုံ ဖယ်ရှားရန်';

  @override
  String get fullName => 'အမည်အပြည့်အစုံ';

  @override
  String get phoneNumber => 'ဖုန်းနံပါတ်';

  @override
  String get pleaseEnterName => 'သင့်အမည်ကို ထည့်ပါ';

  @override
  String get pleaseEnterPhone => 'သင့်ဖုန်းနံပါတ်ကို ထည့်ပါ';

  @override
  String get saveChanges => 'ပြောင်းလဲမှုများ သိမ်းရန်';

  @override
  String get userSessionNotFound => 'အသုံးပြုသူ session ကို မတွေ့ပါ။';

  @override
  String get unableToLoadProfile =>
      'ပရိုဖိုင်ကို ဖွင့်၍ မရပါ။ ပြန်လည် ဝင်ရောက်ပါ။';

  @override
  String failedToPickImage(String error) {
    return 'ဓာတ်ပုံ ရွေးချယ်၍ မရပါ - $error';
  }

  @override
  String failedToUploadImage(String error) {
    return 'ပရိုဖိုင်ဓာတ်ပုံ တင်၍ မရပါ - $error';
  }

  @override
  String get updatePasswordTitle => 'စကားဝှက် ပြောင်းရန်';

  @override
  String get passwordChangeNote =>
      'စကားဝှက်ပြောင်းလျှင် ပြန်လည် ဝင်ရောက်ရပါမည်။';

  @override
  String get currentPassword => 'လက်ရှိ စကားဝှက်';

  @override
  String get newPassword => 'စကားဝှက်အသစ်';

  @override
  String get confirmNewPassword => 'စကားဝှက်အသစ် အတည်ပြုရန်';

  @override
  String get pleaseEnterCurrentPassword => 'လက်ရှိ စကားဝှက်ကို ထည့်ပါ';

  @override
  String get pleaseEnterNewPassword => 'စကားဝှက်အသစ်ကို ထည့်ပါ';

  @override
  String get passwordMinLength => 'စကားဝှက်သည် အနည်းဆုံး ၆ လုံး ရှိရပါမည်';

  @override
  String get pleaseConfirmNewPassword => 'စကားဝှက်အသစ်ကို အတည်ပြုပါ';

  @override
  String get passwordsDoNotMatch => 'စကားဝှက်များ မကိုက်ညီပါ';

  @override
  String get myLocation => 'ကျွန်ုပ်၏ တည်နေရာ';

  @override
  String get tapChooseLocationHint =>
      'သင့်တည်နေရာ သတ်မှတ်ရန် \"မြေပုံပေါ်တွင် တည်နေရာရွေးရန်\" ကို နှိပ်ပါ။';

  @override
  String get change => 'ပြောင်းရန်';

  @override
  String get profileUpdatedSuccessfully =>
      'ပရိုဖိုင် ပြင်ဆင်မှု အောင်မြင်ပါသည်!';

  @override
  String get passwordUpdatedSuccessfully =>
      'စကားဝှက် ပြောင်းလဲမှု အောင်မြင်ပါသည်။ ပြန်လည် ဝင်ရောက်ပေးပါ။';

  @override
  String get locationUpdatedSuccessfully =>
      'တည်နေရာ ပြင်ဆင်မှု အောင်မြင်ပါသည်!';

  @override
  String errorSavingRoom(String error) {
    return 'အခန်း သိမ်းဆည်းရာတွင် အမှားဖြစ်ပွားပါသည် - $error';
  }

  @override
  String welcomeBack(String name) {
    return 'ပြန်လည်ကြိုဆိုပါသည်၊ $name!';
  }

  @override
  String get pleaseAcceptTerms =>
      'ဆက်လက်လုပ်ဆောင်ရန် စည်းမျဉ်းစည်းကမ်းများကို လက်ခံပေးပါ။';

  @override
  String accountCreated(String role) {
    return '$role အဖြစ် အကောင့်ဖန်တီးပြီးပါပြီ!';
  }

  @override
  String get roomCreatedSuccessfully => 'အခန်းသစ် ဖန်တီးမှု အောင်မြင်ပါသည်!';

  @override
  String get roomUpdatedSuccessfully =>
      'အခန်းအချက်အလက် ပြင်ဆင်မှု အောင်မြင်ပါသည်!';

  @override
  String get roomDeletedSuccessfully => 'အခန်း ဖျက်သိမ်းမှု အောင်မြင်ပါသည်!';

  @override
  String get bookingCreatedSuccessfully =>
      'ငှားရမ်းရန် တောင်းဆိုမှု အောင်မြင်ပါသည်!';

  @override
  String get bookingUpdatedSuccessfully =>
      'ငှားရမ်းမှု အခြေအနေ ပြောင်းလဲမှု အောင်မြင်ပါသည်!';

  @override
  String get bookingDeletedSuccessfully =>
      'ငှားရမ်းမှု တောင်းဆိုချက်ကို ဖျက်သိမ်းပြီးပါပြီ!';

  @override
  String get contractCreatedSuccessfully => 'စာချုပ် ဖန်တီးမှု အောင်မြင်ပါသည်!';

  @override
  String get contractUpdatedSuccessfully =>
      'စာချုပ် ပြင်ဆင်မှု အောင်မြင်ပါသည်!';

  @override
  String get ownersCannotFavoriteOwnRooms =>
      'အိမ်ရှင်များသည် မိမိ၏ အခန်းများကို သဘောကျသက်မှတ်၍ မရပါ';

  @override
  String get thisPhoneAlreadyRegistered =>
      'ဤဖုန်းနံပါတ်ကို အခြားသူတစ်ဦးမှ မှတ်ပုံတင်ထားပြီးဖြစ်သည်။';

  @override
  String get currentPasswordIncorrect =>
      'ထည့်သွင်းထားသော လက်ရှိ စကားဝှက် မှားယွင်းနေပါသည်။';

  @override
  String get invalidEmailOrPassword =>
      'အီးမေးလ် သို့မဟုတ် စကားဝှက် မှားယွင်းနေပါသည်။ ပြန်လည် ကြိုးစားပါ။';

  @override
  String get emailAlreadyInUse => 'ဤအီးမေးလ်ဖြင့် အကောင့်ဖွင့်ထားပြီး ဖြစ်သည်။';

  @override
  String get contractHistory => 'စာချုပ် မှတ်တမ်း';

  @override
  String get activeContracts => 'လက်ရှိ စာချုပ်များ';

  @override
  String get history => 'မှတ်တမ်း';

  @override
  String get submitBookingRequestConfirm =>
      'ဤငှားရမ်းရန် တောင်းဆိုချက်ကို ပိုင်ရှင်ထံသို့ တင်သွင်းရန် သေချာပါသလား?';

  @override
  String get voucherSavedSuccessfully =>
      'ဘောက်ချာကို ဂယ်လရီတွင် အောင်မြင်စွာ သိမ်းဆည်းပြီးပါပြီ!';

  @override
  String get failedToSaveVoucher => 'ဘောက်ချာ သိမ်းဆည်းခြင်း မအောင်မြင်ပါ။';
}
