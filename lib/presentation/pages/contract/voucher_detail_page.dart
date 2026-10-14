import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rental_room/l10n/app_localizations.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../di/di.dart';
import '../../../domain/domain.dart';
import '../../extensions/contract/contract_extensions.dart';
import '../../extensions/l10n/number_l10n.dart';
import '../../extensions/number/phone.dart';
import '../../presentation.dart';
import 'widgets/contract_countdown_banner.dart';

class VoucherDetailPage extends StatefulWidget {
  static const String routeName = 'voucher-detail-page';
  static const String routePath = '/voucher-detail-page';

  final BookingEntity booking;
  final UserEntity currentUser;

  const VoucherDetailPage({
    super.key,
    required this.booking,
    required this.currentUser,
  });

  @override
  State<VoucherDetailPage> createState() => _VoucherDetailPageState();
}

class _VoucherDetailPageState extends State<VoucherDetailPage> {
  late BookingEntity _currentBooking;

  ContractEntity? _contract;
  RoomEntity? _room;
  UserModel? _tenantUser;
  UserModel? _ownerUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentBooking = widget.booking;
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    try {
      final getContractUseCase = inject<GetContractByBookingUseCase>();
      final roomRepo = inject<RoomRepository>();
      final authDataSource = inject<AuthDataSource>();

      // 1. Fetch Contract & Room Data in parallel
      final results = await Future.wait([
        getContractUseCase(_currentBooking.id),
        roomRepo.getRoomById(_currentBooking.roomId),
      ]);

      final contractResult = results[0] as DataState<ContractEntity?>;
      final fetchedRoom = results[1] as RoomEntity?;

      ContractEntity? fetchedContract;
      contractResult.onSuccess((contract) {
        fetchedContract = contract;
      });

      // Persist "expired" status when end date has passed
      final current = fetchedContract;
      if (current != null &&
          current.status == ContractStatus.active &&
          current.isExpired) {
        try {
          fetchedContract = await inject<ExpireContractUseCase>()(current);
        } catch (_) {
          // Ignore: the UI still shows expired through effectiveStatus
        }
      }

      final tenantId = fetchedContract?.tenantId ?? _currentBooking.userId;
      final ownerId = fetchedContract?.ownerId ?? _currentBooking.ownerId;

      // 2. Fetch Tenant & Owner Profiles in parallel
      final userResults = await Future.wait([
        authDataSource.getUserById(tenantId),
        if (ownerId != null && ownerId.isNotEmpty)
          authDataSource.getUserById(ownerId)
        else
          Future.value(null),
      ]);

      if (mounted) {
        setState(() {
          _contract = fetchedContract;
          _room = fetchedRoom;
          _tenantUser = userResults[0];
          _ownerUser = userResults[1];
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final localeCode = Localizations.localeOf(context).languageCode;

    final favCount = context.select<FavoriteCubit, int>(
          (cubit) => cubit.state.getFavoriteCount(_currentBooking.roomId),
    );

    String dateRangeText = l10n.bookingNotAvailable;
    if (_contract != null) {
      // Use 'en' for the formatter so month names stay stable, then convert digits.
      final fmt =
      DateFormat('dd MMM yyyy', localeCode == 'my' ? 'en' : localeCode);
      final startDateStr = fmt.format(_contract!.startDate);
      final endDateStr = fmt.format(_contract!.endDate);
      dateRangeText = context.localizedNumber('$startDateStr - $endDateStr');
    }

    final price = _contract?.monthlyRent ?? _currentBooking.roomPrice ?? 0.0;
    final durationMonths = _contract?.durationMonth ?? 1;

    return Scaffold(
      backgroundColor: AppColors.clrWhite,
      appBar: AppBar(
        backgroundColor: AppColors.clrWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        title: Text(
          l10n.bookingVoucher,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          children: [
            // 1. ROOM HEADER CARD
            BookingPropertyHeaderCard(
              roomName:
              _currentBooking.roomName ?? l10n.bookingPropertyName,
              roomImageUrl: _currentBooking.roomImageUrl,
              price: price,
              favCount: favCount,
            ),
            if (_contract != null &&
                (_contract!.isExpired || _contract!.isOneMonthLeft)) ...[
              const SizedBox(height: 12),
              ContractCountdownBanner(contract: _contract!),
            ],
            const SizedBox(height: 24),

            // 2. PERIOD DURATION SECTION
            BookingPeriodSection(dateRangeText: dateRangeText),
            const SizedBox(height: 24),

            // 3. TENANT INFO CARD
            if (_tenantUser != null) ...[
              BookingUserCard(
                title: l10n.bookingTenantDetails,
                userName: _tenantUser!.name,
                userImage: _tenantUser!.image,
                phoneNumber: _tenantUser!.phoneNumber,
                icon: Icons.person_outline,
                onCallPressed: _tenantUser!.phoneNumber.isNotEmpty
                    ? () => _tenantUser!.phoneNumber
                    .makeCall(context: context)
                    : null,
              ),
              const SizedBox(height: 24),
            ],

            // 4. OWNER INFO CARD
            if (_ownerUser != null) ...[
              BookingUserCard(
                title: l10n.bookingOwnerDetails,
                userName: _ownerUser!.name,
                userImage: _ownerUser!.image,
                phoneNumber: _ownerUser!.phoneNumber,
                icon: Icons.real_estate_agent_outlined,
                onCallPressed: _ownerUser!.phoneNumber.isNotEmpty
                    ? () => _ownerUser!.phoneNumber
                    .makeCall(context: context)
                    : null,
              ),
              const SizedBox(height: 24),
            ],

            // 5. PRICE DETAILS SECTION
            BookingPriceDetailsSection(
              durationMonths: durationMonths,
              monthlyRent: price,
              depositAmount: _room?.depositeAmount,
              agentFees: _room?.agentFees,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
