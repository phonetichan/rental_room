import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/domain.dart';
import '../../../extensions/l10n/l10n.dart';
import '../../../extensions/number/number.dart';
import '../../profile/edit_location/edit_location.dart';
import '../../room/tenant/saved_rooms_page.dart';
import '../widgets/dashboard_header.dart';

class TenantDashboardView extends StatelessWidget {
  final UserEntity user;

  const TenantDashboardView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardHeader(
            isOwner: false,
            address: user.address,
            user: user,
            onLocationPressed: () => context.push(EditLocationScreen.routePath),
            onSavedRoomsPressed: () =>
                context.push(SavedRoomsPage.routePath, extra: user),
          ),
          const SizedBox(height: 20),

          // Search Header
          TextField(
            decoration: InputDecoration(
              hintText: context.l10n.searchRoomsHint,
              prefixIcon: const Icon(Icons.search_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Categories
          Text(
            'Categories',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCategoryChip(context, icon: Icons.single_bed, label: 'Single Room'),
              _buildCategoryChip(context, icon: Icons.king_bed, label: 'Apartment'),
              _buildCategoryChip(context, icon: Icons.house, label: 'Full House'),
            ],
          ),
          const SizedBox(height: 24),

          // Featured Listings Placeholder
          Text(
            'Featured Listings',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(Icons.image, size: 48, color: Colors.grey),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cozy Studio Apartment',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      450.toKsFormat,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, {required IconData icon, required String label}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
