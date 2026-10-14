import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../../../domain/domain.dart';
import '../../../l10n/app_localizations.dart';
import '../../presentation.dart';

class BookingView extends StatefulWidget {
  static const String routeName = 'booking-list';
  static const String routePath = '/booking-list';
  final UserEntity user;
  final bool isCurrentTab;

  const BookingView({super.key, required this.user, this.isCurrentTab = true});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  List<BookingEntity>? _cachedPendingBookings;
  List<BookingEntity>? _cachedConfirmedBookings;
  Set<String> _contractedBookingIds = {};

  bool get _isOwner => widget.user.role == UserRole.owner;

  List<String> get _filters => const ['pending', 'confirmed'];

  String _selectedFilter = 'pending';

  Future<void> _loadContracts() async {
    try {
      final repo = inject<ContractRepository>();
      final list = _isOwner
          ? await repo.getContractsByOwnerId(widget.user.id)
          : await repo.getContractsByTenantId(widget.user.id);
      if (!mounted) return;
      setState(() {
        _contractedBookingIds = list
            .where((c) => c.status == ContractStatus.active)
            .map((c) => c.bookingId)
            .toSet();
      });
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    final filters = _filters;
    _selectedFilter = filters.first;

    _tabController = TabController(length: filters.length, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedFilter = filters[_tabController.index];
        });
      }
    });
    _loadContracts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BookingView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isCurrentTab && widget.isCurrentTab) {
      _refreshData();
    }
  }

  Future<void> _refreshData() async {
    await context.read<BookingCubit>().fetchBookings(
      widget.user.id,
      userId: _isOwner ? null : widget.user.id,
      ownerId: _isOwner ? widget.user.id : null,
    );
    await _loadContracts();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    final contentWidget = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // SEGMENTED TAB BAR HEADER (Pending & Confirmed only)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 48,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : theme.dividerColor.withValues(alpha: 0.1),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelPadding: EdgeInsets.zero,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                labelColor: theme.colorScheme.primary,
                unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                ),
                tabs: [
                  Tab(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.hourglass_top_rounded, size: 18),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            l10n.pending,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_outline_rounded,
                            size: 18),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            l10n.confirmed,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // SINGLE STREAM VIEW DRIVEN BY THE SEGMENTED TAB BAR
          Expanded(
            child: BookingTabStreamView(
              contractedBookingIds: _contractedBookingIds,
              stream: context.read<BookingCubit>().watchBookings(
                userId: _isOwner ? null : widget.user.id,
                ownerId: _isOwner ? widget.user.id : null,
              ),
              cachedBookings: _selectedFilter == 'pending'
                  ? _cachedPendingBookings
                  : _cachedConfirmedBookings,
              onCacheUpdate: (list) {
                if (_selectedFilter == 'pending') {
                  _cachedPendingBookings = list;
                } else if (_selectedFilter == 'confirmed') {
                  _cachedConfirmedBookings = list;
                }
              },
              currentUser: widget.user,
              selectedFilter: _selectedFilter,
              showFilterChips: false,
              onFilterSelected: (val) {
                setState(() {
                  _selectedFilter = val;
                });
              },
              onRefresh: _refreshData,
            ),
          ),
        ],
      ),
    );

    final isStandalone = ModalRoute.of(context)?.canPop ?? false;

    Widget bodyWidget = contentWidget;
    try {
      context.read<BookingCubit>();
    } catch (_) {
      bodyWidget = BlocProvider<BookingCubit>(
        create: (context) => inject<BookingCubit>()
          ..fetchBookings(
            widget.user.id,
            userId: _isOwner ? null : widget.user.id,
            ownerId: _isOwner ? widget.user.id : null,
          ),
        child: Builder(builder: (nestedContext) => contentWidget),
      );
    }

    if (isStandalone) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.booking)),
        body: bodyWidget,
      );
    }

    return bodyWidget;
  }
}
