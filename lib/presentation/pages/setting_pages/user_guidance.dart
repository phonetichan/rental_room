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
          bottom: const TabBar(
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
      padding: const EdgeInsets.all(20.0),
      children: const [
        _GuideCard(
          icon: Icons.search_rounded,
          iconColor: Colors.teal,
          title: '1. Finding & Renting Rooms',
          description:
          'Browse available rooms by location, price, and amenities. Tap on any room listing to view photos, owner contact info, and detailed terms.',
        ),
        SizedBox(height: 16),
        _GuideCard(
          icon: Icons.add_home_work_rounded,
          iconColor: Colors.blue,
          title: '2. Posting a Rental Room (Owners)',
          description:
          'Property Owners can publish new listings by filling in room details, monthly rent, location, and uploading room photos from the "Post" tab.',
        ),
        SizedBox(height: 16),
        _GuideCard(
          icon: Icons.bookmark_added_rounded,
          iconColor: Colors.indigo,
          title: '3. Managing Bookings & Stays',
          description:
          'Track your active room rentals, pending applications, and past stays easily from the "Booking" tab on your main dashboard.',
        ),
        SizedBox(height: 16),
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
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20.0),
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Adding location coordinates is optional. You can leave Lat/Lng blank.',
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const _GuideStep(
          number: '1',
          text: 'Open Google Maps and press & hold on your room location to drop a Red Pin.',
        ),
        const _GuideStep(
          number: '2',
          text: 'Look at the top search bar for two numbers (e.g., 16.8409, 96.1735).',
        ),
        const _GuideStep(
          number: '3',
          text: 'First number is Latitude, second is Longitude.',
        ),
        const Divider(height: 32),
        Text(
          'Using Web Browser:',
          maxLines: 2,
          softWrap: true,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const _GuideStep(
          number: '1',
          text: 'Right-click your building location on maps.google.com.',
        ),
        const _GuideStep(
          number: '2',
          text: 'Click the coordinates at the top of the menu to copy them into the app.',
        ),
      ],
    );
  }
}

class _GuideCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
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
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 26),
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
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    maxLines: 4,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              maxLines: 4,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, height: 1.4),
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
      content: SizedBox(
        width: double.maxFinite,
        child: const SingleChildScrollView(
          child: _LocationGuideTab(),
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