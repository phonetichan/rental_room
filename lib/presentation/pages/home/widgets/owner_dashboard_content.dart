import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';
import '../../../presentation.dart';
import 'owner_metric_cards.dart';
import 'owner_monthly_revenue_card.dart';

class OwnerDashboardContent extends StatefulWidget {
  final UserEntity user;

  const OwnerDashboardContent({super.key, required this.user});

  @override
  State<OwnerDashboardContent> createState() => _OwnerDashboardContentState();
}

class _OwnerDashboardContentState extends State<OwnerDashboardContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoomCubit>().fetchRooms();
      context.read<FavoriteCubit>().loadFavorites(widget.user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. OVERVIEW & METRIC CARDS
          Text(
            'Overview',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.clrBlack,
            ),
          ),
          const SizedBox(height: 12),
          OwnerMetricsOverview(user: widget.user),

          const SizedBox(height: 28),

          // 2. MONTHLY REVENUE BAR CHART CARD
          const OwnerMonthlyRevenueCard(),
        ],
      ),
    );
  }
}
