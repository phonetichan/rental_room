import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../../../domain/domain.dart';
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
  List<BookingEntity>? _cachedContractedBookings;


  bool get _isOwner => widget.user.role == UserRole.owner;

  List<String> get _filters => const ['pending', 'confirmed', 'contracted'];

  String _selectedFilter = 'pending';

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
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final contentWidget = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // SEGMENTED TAB BAR HEADER (All/Pending/Confirmed for Owner, Pending/Confirmed for Tenant)
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
                tabs: const [
                  Tab(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.hourglass_top_rounded, size: 18),
                        SizedBox(width: 8),
                        Text('Pending'),
                      ],
                    ),
                  ),
                  Tab(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text('Confirmed'),
                      ],
                    ),
                  ),
                  Tab(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.handshake_outlined,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text('Contracted'),
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
              stream: context.read<BookingCubit>().watchBookings(
                userId: _isOwner ? null : widget.user.id,
                ownerId: _isOwner ? widget.user.id : null,
              ),
              cachedBookings: _selectedFilter == 'pending'
                  ? _cachedPendingBookings
                  : _selectedFilter == 'confirmed'
                  ? _cachedConfirmedBookings
                  : _cachedContractedBookings,
              onCacheUpdate: (list) {
                if (_selectedFilter == 'pending') {
                  _cachedPendingBookings = list;
                } else if (_selectedFilter == 'confirmed') {
                  _cachedConfirmedBookings = list;
                } else if (_selectedFilter == 'contracted') {
                  _cachedContractedBookings = list;
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
        appBar: AppBar(
          title: const Text('Bookings'),
        ),
        body: bodyWidget,
      );
    }

    return bodyWidget;
  }
}
