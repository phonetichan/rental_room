import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';
import '../../../presentation.dart';

enum MetricType {
  activeProperties,
  availableRooms,
  pendingRequests,
  occupancy,
}

class MetricItemData {
  final MetricType type;
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  MetricItemData({
    required this.type,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class OwnerMetricsOverview extends StatefulWidget {
  final UserEntity user;

  const OwnerMetricsOverview({super.key, required this.user});

  @override
  State<OwnerMetricsOverview> createState() => _OwnerMetricsOverviewState();
}

class _OwnerMetricsOverviewState extends State<OwnerMetricsOverview> {
  MetricType _selectedHeroType = MetricType.activeProperties;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomState>(
      builder: (context, state) {
        return BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, favoriteState) {
            final List<RoomEntity> ownerRooms = state.maybeWhen(
              loaded: (rooms) =>
                  rooms.where((r) => r.ownerId == widget.user.id).toList(),
              orElse: () => [],
            );

            final int totalFavorites = ownerRooms.fold(
              0,
              (sum, room) => sum + favoriteState.getFavoriteCount(room.id),
            );

            final int activePropertiesCount = ownerRooms.length;
            final int availableRoomsCount = ownerRooms
                .where((r) => r.status.toLowerCase() == 'available')
                .toList()
                .length;

            final String occupancyRate = activePropertiesCount > 0
                ? '${(((activePropertiesCount - availableRoomsCount) / activePropertiesCount) * 100).toStringAsFixed(0)}%'
                : '0%';

            final List<MetricItemData> allMetrics = [
              MetricItemData(
                type: MetricType.activeProperties,
                title: 'Favourite Count',
                value: '$totalFavorites',
                subtitle:
                    '$totalFavorites ${totalFavorites == 1 ? 'user favorited your listings' : 'users favorited your listings'}',
                icon: Icons.favorite_rounded,
                color: AppColors.clrPrimary,
              ),
              MetricItemData(
                type: MetricType.availableRooms,
                title: 'Available Rooms',
                value: '$availableRoomsCount',
                subtitle:
                    '${activePropertiesCount - availableRoomsCount} rooms currently occupied',
                icon: Icons.meeting_room_outlined,
                color: AppColors.clrSuccess,
              ),
              MetricItemData(
                type: MetricType.pendingRequests,
                title: 'Pending Requests',
                value: '2',
                subtitle: '2 tenant booking inquiries pending',
                icon: Icons.pending_actions_rounded,
                color: AppColors.clrSecondary,
              ),
              MetricItemData(
                type: MetricType.occupancy,
                title: 'Total Occupancy',
                value: occupancyRate,
                subtitle: 'Overall occupancy rate across units',
                icon: Icons.pie_chart_outline_rounded,
                color: AppColors.clrBlue,
              ),
            ];

            final heroMetric = allMetrics.firstWhere(
              (m) => m.type == _selectedHeroType,
            );
            final miniMetrics = allMetrics
                .where((m) => m.type != _selectedHeroType)
                .toList();

            return Column(
              children: [
                // DYNAMIC HERO FEATURED CARD
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: HeroMetricCard(
                    key: ValueKey(heroMetric.type),
                    title: heroMetric.title,
                    value: heroMetric.value,
                    subtitle: heroMetric.subtitle,
                    icon: heroMetric.icon,
                  ),
                ),
                const SizedBox(height: 10),

                // DYNAMIC MINI METRICS ROW
                Row(
                  children: List.generate(miniMetrics.length, (index) {
                    final item = miniMetrics[index];
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: index == miniMetrics.length - 1 ? 0 : 8.0,
                        ),
                        child: MiniMetricCard(
                          title: item.title,
                          value: item.value,
                          icon: item.icon,
                          color: item.color,
                          onTap: () {
                            setState(() {
                              _selectedHeroType = item.type;
                            });
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class HeroMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;

  const HeroMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            AppColors.clrPrimary,
            AppColors.clrSecondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.clrWhite,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}

class MiniMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const MiniMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.clrWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.clrSoftGrey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, size: 16, color: color),
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.clrBlack,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.clrDarkGrey,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
