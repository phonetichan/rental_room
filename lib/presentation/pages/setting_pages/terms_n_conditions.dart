import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  static const String routePath = '/terms';
  static const String routeName = 'terms';

  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Terms & Conditions',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          elevation: 0,
          bottom: const TabBar(
            indicatorWeight: 3,
            tabs: [
              Tab(icon: Icon(Icons.person_outline_rounded), text: 'Tenant Terms'),
              Tab(icon: Icon(Icons.home_work_outlined), text: 'Owner Terms'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _TenantTermsTab(),
            _OwnerTermsTab(),
          ],
        ),
      ),
    );
  }
}

class _TenantTermsTab extends StatelessWidget {
  const _TenantTermsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      children: const [
        _TermCard(
          number: '1',
          title: 'General Usage & Account Responsibility',
          content:
          'By creating an account and using the Rental Room application, Tenants agree to provide accurate, truthful identification information. Tenants are responsible for keeping their login credentials confidential and must not share their account with unauthorized third parties.',
          badgeColor: Colors.blue,
        ),
        SizedBox(height: 14),
        _TermCard(
          number: '2',
          title: 'Rental Agreements & Lease Obligations',
          content:
          'Any rental, lease, or sublease agreement entered into is strictly a legal contract between the Tenant and the Property Owner. The Rental Room platform acts solely as an informational directory and is not liable for monetary disputes, lease breaches, or property damages.',
          badgeColor: Colors.teal,
        ),
        SizedBox(height: 14),
        _TermCard(
          number: '3',
          title: 'House Rules, Respect & Quiet Hours',
          content:
          'Tenants agree to strictly follow all house rules specified in the property listing, including noise guidelines, visitor policies, parking regulations, and timely rent payment schedules.',
          badgeColor: Colors.indigo,
        ),
        SizedBox(height: 14),
        _TermCard(
          number: '4',
          title: 'Cancellation & Refund Policy',
          content:
          'Booking cancellations and security deposit refunds are subject to the specific terms outlined by the Property Owner in the property listing agreement.',
          badgeColor: Colors.amber,
        ),
      ],
    );
  }
}

class _OwnerTermsTab extends StatelessWidget {
  const _OwnerTermsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      children: const [
        _TermCard(
          number: '1',
          title: 'Listing Accuracy & Transparency',
          content:
          'Property Owners must provide truthful details regarding room pricing, amenities, and property condition. Deliberately misleading information may lead to account suspension.',
          badgeColor: Colors.deepOrange,
        ),
        SizedBox(height: 14),
        _TermCard(
          number: '2',
          title: 'Location & Map Coordinates',
          content:
          'Providing exact latitude and longitude map coordinates is optional. While exact coordinates help tenants locate rooms easily, owners may choose to leave map location fields empty without restriction.',
          badgeColor: Colors.purple,
        ),
        SizedBox(height: 14),
        _TermCard(
          number: '3',
          title: 'Property Right & Safety Compliance',
          content:
          'Property Owners represent that they hold legal rights to sublet or rent out the listed property and comply with all local housing safety codes and regulations.',
          badgeColor: Colors.green,
        ),
        SizedBox(height: 14),
        _TermCard(
          number: '4',
          title: 'Fair Treatment & Non-Discrimination',
          content:
          'Property Owners agree to treat all tenant applicants fairly and without discrimination based on race, religion, gender, or nationality.',
          badgeColor: Colors.pink,
        ),
      ],
    );
  }
}

class _TermCard extends StatelessWidget {
  final String number;
  final String title;
  final String content;
  final MaterialColor badgeColor;

  const _TermCard({
    required this.number,
    required this.title,
    required this.content,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          width: 1,
        ),
      ),
      color: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      number,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: badgeColor.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              maxLines: 10,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.5,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}