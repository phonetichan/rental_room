import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';
import '../../../presentation.dart';

class TenantDashboardContent extends StatefulWidget {
  final UserEntity user;

  const TenantDashboardContent({super.key, required this.user});

  @override
  State<TenantDashboardContent> createState() => _TenantDashboardContentState();
}

class _TenantDashboardContentState extends State<TenantDashboardContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoomCubit>().fetchRooms(status: 'available');
    });
  }

  void _refreshData() {
    context.read<RoomCubit>().fetchRooms(status: 'available');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Static Promo Hero Card
          const StaticPromoCard(
            title: 'GET YOUR 20%\nCASHBACK',
            expirationText: '*Expired 25 Aug 2026',
            imageAssetPath: 'assets/images/unsplash_RFDP7_80v5A.png',
          ),
          const SizedBox(height: 24),

          // 2. Section Header
          Text(
            'Available Listings',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // 3. Available Rooms List (No Filters/Search)
          BlocBuilder<RoomCubit, RoomState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
                loaded: (rooms) {
                  final availableRooms = rooms.where((r) => r.status == 'available').toList();

                  if (availableRooms.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.hotel_outlined,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No available rooms at the moment',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: availableRooms.length,
                    itemBuilder: (context, index) {
                      final room = availableRooms[index];
                      return RoomCard(
                        room: room,
                        currentUser: widget.user,
                        showOwnerActions: false,
                        onRoomUpdated: _refreshData,
                      );
                    },
                  );
                },
                failure: (message) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      'Error loading rooms: $message',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Static Promo Banner Widget
class StaticPromoCard extends StatelessWidget {
  final String title;
  final String expirationText;
  final String imageAssetPath;

  const StaticPromoCard({
    super.key,
    required this.title,
    required this.expirationText,
    required this.imageAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: const Color(0xFF432C81), // Deep purple background
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Static yellow background accent curve
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 170,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFCB021),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                  ),
                ),
              ),
            ),

            // Content Layout
            Row(
              children: [
                // Left text section
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          expirationText,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Right PNG building graphic section
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(16),
                      ),
                      child: Image.asset(
                        imageAssetPath,
                        height: 110,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.apartment_rounded,
                            size: 68,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}