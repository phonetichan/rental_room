import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/di.dart';
import '../../domain/domain.dart';
import '../blocs/authentication_cubit/authentication_cubit.dart';
import '../navigation/navigation_key_provider.dart';

import 'booking/booking_view.dart';
import 'home/dashboard.dart';
import 'post/post_view.dart';
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

  const IndexPage({
    super.key,
    this.initialTab = 0,
  });

  static const String routeName = "index";
  static const String routePath = "/";

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
  }

  void _changeTab(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    inject<INavigationKeyProvider>().scaffoldContext = context;

    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, authState) {
        final user = authState is AuthenticationAuthenticated
            ? authState.user
            : context.read<AuthenticationCubit>().user;

        if (user == null) {
          return const Scaffold(
            body: SizedBox.shrink(),
          );
        }

        final bool isOwner = user.role == UserRole.owner;

        // 1. Single Unified Home Dashboard View
        final Widget homeView = DashboardView(user: user);

        // 2. Navigation Views
        final List<Widget> pages = [
          homeView,
          PostView(user: user),
          BookingView(user: user),
          ProfileView(user: user),
        ];

        // 3. Dynamic AppBar Title per tab
        final String appBarTitle = switch (_currentIndex) {
          0 => isOwner ? 'Owner Dashboard' : 'Find Your Room',
          1 => isOwner ? 'Property Posts' : 'Post Demands',
          2 => 'My Bookings',
          3 => 'Account Profile',
          _ => 'Rental Portal',
        };

        const navItems = [
          NavItemData(
            icon: Icons.home_outlined,
            selectedIcon: Icons.home_rounded,
            label: "Home",
          ),
          NavItemData(
            icon: Icons.add_circle_outline_rounded,
            selectedIcon: Icons.add_circle_rounded,
            label: "Posts",
          ),
          NavItemData(
            icon: Icons.bookmark_border_rounded,
            selectedIcon: Icons.bookmark_rounded,
            label: "Bookings",
          ),
          NavItemData(
            icon: Icons.person_outline_rounded,
            selectedIcon: Icons.person_rounded,
            label: "Profile",
          ),
        ];

        return Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            centerTitle: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded),
                onPressed: () {},
              ),
            ],
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: pages,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _currentIndex,
            elevation: 3,
            onDestinationSelected: _changeTab,
            destinations: navItems
                .map(
                  (item) => NavigationDestination(
                label: item.label,
                icon: Icon(item.icon),
                selectedIcon: Icon(item.selectedIcon),
              ),
            )
                .toList(),
          ),
        );
      },
    );
  }
}
