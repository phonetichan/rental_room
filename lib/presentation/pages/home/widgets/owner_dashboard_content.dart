import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';

class OwnerDashboardContent extends StatelessWidget {
  final UserEntity user;

  const OwnerDashboardContent({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Row(
          children: const [
            Expanded(
              child: _MetricCard(
                title: 'Active Properties',
                value: '4',
                icon: Icons.apartment,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _MetricCard(
                title: 'Pending Requests',
                value: '2',
                icon: Icons.pending_actions,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        ListTile(
          leading: const Icon(Icons.add_business_rounded),
          title: const Text('Add New Property'),
          subtitle: const Text('List a new rental unit or room'),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.people_alt_rounded),
          title: const Text('Manage Tenants'),
          subtitle: const Text('View current active contracts'),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {},
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}