import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/domain.dart';
import '../../profile/edit_location/edit_location.dart';
import '../widgets/dashboard_header.dart';

class OwnerDashboardView extends StatelessWidget {
  final UserEntity user;

  const OwnerDashboardView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isOwner = user.role == UserRole.owner;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardHeader(
            isOwner: isOwner,
            address: user.address,
            onLocationPressed: () => context.push(EditLocationScreen.routePath),
          ),
          const SizedBox(height: 20),
          // Overview Metrics
          Text('Overview', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  context,
                  title: 'Active Properties',
                  value: '4',
                  icon: Icons.apartment,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  context,
                  title: 'Pending Requests',
                  value: '2',
                  icon: Icons.pending_actions,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          Text(value, style: Theme.of(context).textTheme.headlineMedium),
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
