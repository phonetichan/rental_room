import 'package:flutter/material.dart';

class UserGuidancePage extends StatelessWidget {
  static const String routePath = '/user-guidance';
  static const String routeName = 'user-guidance';

  const UserGuidancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'User Guidance & Help',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          elevation: 0,
          bottom: const TabBar(
            indicatorWeight: 3,
            tabs: [
              Tab(icon: Icon(Icons.explore_outlined), text: 'Getting Started'),
              Tab(icon: Icon(Icons.map_outlined), text: 'Location Guide'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _GettingStartedTab(),
            _LocationGuideTab(),
          ],
        ),
      ),
    );
  }
}

class _GettingStartedTab extends StatelessWidget {
  const _GettingStartedTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: const [
        _GuideCard(
          icon: Icons.search_rounded,
          iconColor: Colors.teal,
          title: '1. Finding & Renting Rooms',
          description:
          'Browse available rooms by location, price, and amenities. Tap on any room listing to view photos, owner contact info, and detailed terms.',
        ),
        SizedBox(height: 12),
        _GuideCard(
          icon: Icons.add_home_work_rounded,
          iconColor: Colors.blue,
          title: '2. Posting a Rental Room (Owners)',
          description:
          'Property Owners can publish new listings by filling in room details, monthly rent, location, and uploading room photos from the "Post" tab.',
        ),
        SizedBox(height: 12),
        _GuideCard(
          icon: Icons.bookmark_added_rounded,
          iconColor: Colors.indigo,
          title: '3. Managing Bookings & Stays',
          description:
          'Track your active room rentals, pending applications, and past stays easily from the "Booking" tab on your main dashboard.',
        ),
        SizedBox(height: 12),
        _GuideCard(
          icon: Icons.security_rounded,
          iconColor: Colors.purple,
          title: '4. Account & Safety Preferences',
          description:
          'Manage your profile image, switch between Dark and Light themes, and view Terms & Conditions inside your Profile settings.',
        ),
      ],
    );
  }
}

class _LocationGuideTab extends StatelessWidget {
  const _LocationGuideTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.amber.withValues(alpha: 0.3),
            ),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline_rounded, color: Colors.amber, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Adding location coordinates is optional. You can leave Lat/Lng blank.',
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Using Mobile (Google Maps app):',
          maxLines: 2,
          softWrap: true,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const _GuideStep(
          number: '1',
          text:
          'Open Google Maps and press & hold on your room location to drop a Red Pin.',
        ),
        const _GuideStep(
          number: '2',
          text:
          'Look at the top search bar for two numbers (e.g., 16.8409, 96.1735).',
        ),
        const _GuideStep(
          number: '3',
          text: 'First number is Latitude, second is Longitude.',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Divider(
            color: colorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        Text(
          'Using Web Browser:',
          maxLines: 2,
          softWrap: true,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const _GuideStep(
          number: '1',
          text: 'Right-click your building location on maps.google.com.',
        ),
        const _GuideStep(
          number: '2',
          text:
          'Click the coordinates at the top of the menu to copy them into the app.',
        ),
      ],
    );
  }
}

class _GuideCard extends StatelessWidget {
  final IconData icon;
  final MaterialColor iconColor;
  final String title;
  final String description;

  const _GuideCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : colorScheme.shadow.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isDark
              ? colorScheme.outlineVariant.withValues(alpha: 0.15)
              : colorScheme.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor.shade700, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      maxLines: 6,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13.5,
                        height: 1.45,
                        color:
                        colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GuideStep extends StatelessWidget {
  final String number;
  final String text;

  const _GuideStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              maxLines: 4,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                height: 1.4,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LocationGuideDialog extends StatelessWidget {
  const LocationGuideDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const LocationGuideDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: const SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: _LocationGuideTab(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}