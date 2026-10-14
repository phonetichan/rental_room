import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_room/presentation/pages/room/post_view.dart';

import '../../di/di.dart';
import '../../domain/domain.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/blocs.dart';
import '../components/button/confirm_cancel_button.dart';
import 'package:rental_room/presentation/extensions/contract/contract_extensions.dart';
import '../navigation/navigation_key_provider.dart';

import 'booking/booking_list_view.dart';
import 'dashboard/dashboard.dart';
import 'profile/profile_view.dart';

class NavItemData {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const NavItemData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

class IndexPage extends StatefulWidget {
  final int initialTab;
  final String? initialRoomTypeId;

  const IndexPage({super.key, this.initialTab = 0, this.initialRoomTypeId});

  static const String routeName = "index";
  static const String routePath = "/";

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late int _currentIndex;
  int _contractBadgeCount = 0;
  String? _loadedUserId;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
  }

  @override
  void didUpdateWidget(covariant IndexPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialTab != widget.initialTab) {
      setState(() => _currentIndex = widget.initialTab);
    }
  }

  Future<void> _loadContractCount(UserEntity user) async {
    try {
      final repo = inject<ContractRepository>();
      final isOwner = user.role == UserRole.owner;
      final list = isOwner
          ? await repo.getContractsByOwnerId(user.id)
          : await repo.getContractsByTenantId(user.id);
      if (mounted) {
        setState(() {
          _contractBadgeCount = list.where((c) => ContractStatusX(c).countsForBadge).length;
        });
      }
    } catch (_) {}
  }

  void _changeTab(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      final uri = Uri(
        path: IndexPage.routePath,
        queryParameters: {if (index != 0) 'tab': '$index'},
      );
      context.go(uri.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    inject<INavigationKeyProvider>().scaffoldContext = context;
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, authState) {
        final user = authState is AuthenticationAuthenticated
            ? authState.user
            : context.read<AuthenticationCubit>().user;

        if (user == null) {
          return const Scaffold(body: SizedBox.shrink());
        }

        _loadContractCount(user);

        // 1. Single Unified Home Dashboard View
        final Widget homeView = DashboardView(user: user);

        // 2. Navigation Views
        final List<Widget> pages = [
          homeView,
          PostView(user: user, initialRoomTypeId: widget.initialRoomTypeId),
          BookingView(user: user, isCurrentTab: _currentIndex == 2),
          ProfileView(user: user),
        ];

        final navItems = [
          NavItemData(
            icon: Icons.home_outlined,
            selectedIcon: Icons.home_rounded,
            label: l10n.home,
          ),
          NavItemData(
            icon: Icons.add_circle_outline_rounded,
            selectedIcon: Icons.add_circle_rounded,
            label: l10n.rooms,
          ),
          NavItemData(
            icon: Icons.calendar_today_outlined,
            selectedIcon: Icons.calendar_today_rounded,
            label: l10n.booking,
          ),
          NavItemData(
            icon: Icons.person_outline_rounded,
            selectedIcon: Icons.person_rounded,
            label: l10n.profile,
          ),
        ];

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => inject<RoomCubit>()),
            BlocProvider(
              create: (context) =>
              inject<FavoriteCubit>()..loadFavorites(user.id),
            ),
            BlocProvider(
              create: (context) {
                final isOwner = user.role == UserRole.owner;
                return inject<BookingCubit>()..fetchBookings(
                  user.id,
                  userId: isOwner ? null : user.id,
                  ownerId: isOwner ? user.id : null,
                );
              },
            ),
          ],
          child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) return;

              if (_currentIndex != 0) {
                _changeTab(0);
                return;
              }

              final shouldExit = await showDialog<bool>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text(
                    l10n.exitApp,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                    l10n.exitAppConfirm,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 14),
                  ),
                  actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  actions: [
                    ConfirmCancelButtons(
                      confirmText: l10n.exit,
                      cancelText: l10n.cancel,
                      confirmColor: Colors.red.shade600,
                      onConfirm: () => Navigator.of(dialogContext).pop(true),
                      onCancel: () => Navigator.of(dialogContext).pop(false),
                    ),
                  ],
                ),
              );

              if (shouldExit == true) {
                await SystemNavigator.pop();
              }
            },
            child: Scaffold(
              body: SafeArea(
                top: true,
                child: IndexedStack(index: _currentIndex, children: pages),
              ),
              bottomNavigationBar: NavigationBar(
                selectedIndex: _currentIndex,
                elevation: 3,
                onDestinationSelected: _changeTab,
                destinations: navItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isProfileTab = index == 3;

                  Widget iconWidget = Icon(item.icon);
                  Widget selectedIconWidget = Icon(item.selectedIcon);

                  if (isProfileTab && _contractBadgeCount > 0) {
                    iconWidget = Badge(
                      label: Text('$_contractBadgeCount'),
                      child: iconWidget,
                    );
                    selectedIconWidget = Badge(
                      label: Text('$_contractBadgeCount'),
                      child: selectedIconWidget,
                    );
                  }

                  return NavigationDestination(
                    label: item.label,
                    icon: iconWidget,
                    selectedIcon: selectedIconWidget,
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}