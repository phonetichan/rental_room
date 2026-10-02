// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../di/di.dart';
// import '../../../domain/domain.dart';
// import '../../presentation.dart';
//
// class BookingView extends StatefulWidget {
//   static const String routeName = 'booking-list';
//   static const String routePath = '/booking-list';
//   final UserEntity user;
//   final bool isCurrentTab;
//
//   const BookingView({
//     super.key,
//     required this.user,
//     this.isCurrentTab = true,
//   });
//
//   @override
//   State<BookingView> createState() => _BookingViewState();
// }
//
// class _BookingViewState extends State<BookingView>
//     with SingleTickerProviderStateMixin {
//   late final TabController _tabController;
//   List<BookingEntity>? _cachedAllBookings;
//   List<BookingEntity>? _cachedMyBookings;
//   List<BookingEntity>? _cachedPendingBookings;
//   List<BookingEntity>? _cachedConfirmedBookings;
//   String _selectedFilter = 'all';
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didUpdateWidget(covariant BookingView oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (!oldWidget.isCurrentTab && widget.isCurrentTab) {
//       _refreshData();
//     }
//   }
//
//   Future<void> _refreshData() async {
//     final isOwner = widget.user.role == UserRole.owner;
//     await context.read<BookingCubit>().fetchBookings(
//       widget.user.id,
//       userId: isOwner ? null : widget.user.id,
//       ownerId: isOwner ? widget.user.id : null,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final isOwner = widget.user.role == UserRole.owner;
//
//     final contentWidget = Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           // SEGMENTED TAB BAR HEADER (All/My for Owner, Pending/Confirmed for Tenant)
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: Container(
//               height: 48,
//               padding: const EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                 color: isDark
//                     ? Colors.white.withValues(alpha: 0.06)
//                     : theme.colorScheme.surfaceContainerHighest
//                         .withValues(alpha: 0.5),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: isDark
//                       ? Colors.white.withValues(alpha: 0.08)
//                       : theme.dividerColor.withValues(alpha: 0.1),
//                 ),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 dividerColor: Colors.transparent,
//                 labelPadding: EdgeInsets.zero,
//                 labelStyle: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 unselectedLabelStyle: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 labelColor: theme.colorScheme.primary,
//                 unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
//                 indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: theme.colorScheme.primary.withValues(alpha: 0.12),
//                 ),
//                 tabs: isOwner
//                     ? const [
//                         Tab(
//                           height: 40,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.calendar_month_outlined, size: 18),
//                               SizedBox(width: 8),
//                               Text('All Bookings'),
//                             ],
//                           ),
//                         ),
//                         Tab(
//                           height: 40,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.bookmark_outline_rounded, size: 18),
//                               SizedBox(width: 8),
//                               Text('My Bookings'),
//                             ],
//                           ),
//                         ),
//                       ]
//                     : const [
//                         Tab(
//                           height: 40,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.hourglass_top_rounded, size: 18),
//                               SizedBox(width: 8),
//                               Text('Pending'),
//                             ],
//                           ),
//                         ),
//                         Tab(
//                           height: 40,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.check_circle_outline_rounded, size: 18),
//                               SizedBox(width: 8),
//                               Text('Confirmed'),
//                             ],
//                           ),
//                         ),
//                       ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: isOwner
//                   ? [
//                       // Owner Tab 1: All Bookings
//                       BookingTabStreamView(
//                         stream: context.read<BookingCubit>().watchBookings(
//                               userId: null,
//                               ownerId: widget.user.id,
//                             ),
//                         cachedBookings: _cachedAllBookings,
//                         onCacheUpdate: (list) => _cachedAllBookings = list,
//                         currentUser: widget.user,
//                         selectedFilter: _selectedFilter,
//                         onFilterSelected: (val) => setState(() => _selectedFilter = val),
//                         onRefresh: _refreshData,
//                       ),
//                       // Owner Tab 2: My Bookings
//                       BookingTabStreamView(
//                         stream: context.read<BookingCubit>().watchBookings(
//                               userId: null,
//                               ownerId: widget.user.id,
//                             ),
//                         cachedBookings: _cachedMyBookings,
//                         onCacheUpdate: (list) => _cachedMyBookings = list,
//                         currentUser: widget.user,
//                         selectedFilter: _selectedFilter,
//                         onFilterSelected: (val) => setState(() => _selectedFilter = val),
//                         onRefresh: _refreshData,
//                       ),
//                     ]
//                   : [
//                       // Tenant Tab 1: Pending Bookings
//                       BookingTabStreamView(
//                         stream: context.read<BookingCubit>().watchBookings(
//                               userId: widget.user.id,
//                               ownerId: null,
//                             ),
//                         cachedBookings: _cachedPendingBookings,
//                         onCacheUpdate: (list) => _cachedPendingBookings = list,
//                         currentUser: widget.user,
//                         selectedFilter: 'pending',
//                         onFilterSelected: (_) {},
//                         onRefresh: _refreshData,
//                       ),
//                       // Tenant Tab 2: Confirmed Bookings
//                       BookingTabStreamView(
//                         stream: context.read<BookingCubit>().watchBookings(
//                               userId: widget.user.id,
//                               ownerId: null,
//                             ),
//                         cachedBookings: _cachedConfirmedBookings,
//                         onCacheUpdate: (list) => _cachedConfirmedBookings = list,
//                         currentUser: widget.user,
//                         selectedFilter: 'confirmed',
//                         onFilterSelected: (_) {},
//                         onRefresh: _refreshData,
//                       ),
//                     ],
//             ),
//           ),
//         ],
//       ),
//     );
//
//     // Provide BookingCubit safely if missing higher in the widget tree
//     try {
//       context.read<BookingCubit>();
//       return contentWidget;
//     } catch (_) {
//       return BlocProvider<BookingCubit>(
//         create: (context) => inject<BookingCubit>()
//           ..fetchBookings(
//             widget.user.id,
//             userId: isOwner ? null : widget.user.id,
//             ownerId: isOwner ? widget.user.id : null,
//           ),
//         child: Builder(
//           builder: (nestedContext) => contentWidget,
//         ),
//       );
//     }
//   }
// }

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
  List<BookingEntity>? _cachedAllBookings;
  List<BookingEntity>? _cachedPendingBookings;
  List<BookingEntity>? _cachedConfirmedBookings;

  bool get _isOwner => widget.user.role == UserRole.owner;

  List<String> get _ownerFilters => const ['all', 'pending', 'confirmed'];

  List<String> get _tenantFilters => const ['pending', 'confirmed'];

  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    final filters = _isOwner ? _ownerFilters : _tenantFilters;
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
                tabs: _isOwner
                    ? const [
                        Tab(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month_outlined, size: 18),
                              SizedBox(width: 6),
                              Text('All'),
                            ],
                          ),
                        ),
                        Tab(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.hourglass_top_rounded, size: 18),
                              SizedBox(width: 6),
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
                              SizedBox(width: 6),
                              Text('Confirmed'),
                            ],
                          ),
                        ),
                      ]
                    : const [
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
              cachedBookings: _selectedFilter == 'all'
                  ? _cachedAllBookings
                  : _selectedFilter == 'pending'
                  ? _cachedPendingBookings
                  : _cachedConfirmedBookings,
              onCacheUpdate: (list) {
                if (_selectedFilter == 'all') {
                  _cachedAllBookings = list;
                } else if (_selectedFilter == 'pending') {
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

    try {
      context.read<BookingCubit>();
      return contentWidget;
    } catch (_) {
      return BlocProvider<BookingCubit>(
        create: (context) => inject<BookingCubit>()
          ..fetchBookings(
            widget.user.id,
            userId: _isOwner ? null : widget.user.id,
            ownerId: _isOwner ? widget.user.id : null,
          ),
        child: Builder(builder: (nestedContext) => contentWidget),
      );
    }
  }
}
