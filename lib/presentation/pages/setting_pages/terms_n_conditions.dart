import 'package:flutter/material.dart';
import '../../extensions/l10n.dart';

class TermsAndConditionsPage extends StatelessWidget {
  static const String routePath = '/terms';
  static const String routeName = 'terms';

  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.termsAndConditions,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          elevation: 0,
          bottom: TabBar(
            indicatorWeight: 3,
            tabs: [
              Tab(icon: const Icon(Icons.person_outline_rounded), text: l10n.tenantTerms),
              Tab(icon: const Icon(Icons.home_work_outlined), text: l10n.ownerTerms),
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
    final l10n = context.l10n;
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        _TermCard(
          number: '1',
          title: l10n.tenantTerm1Title,
          content: l10n.tenantTerm1Content,
          badgeColor: Colors.blue,
        ),
        const SizedBox(height: 12),
        _TermCard(
          number: '2',
          title: l10n.tenantTerm2Title,
          content: l10n.tenantTerm2Content,
          badgeColor: Colors.teal,
        ),
        const SizedBox(height: 12),
        _TermCard(
          number: '3',
          title: l10n.tenantTerm3Title,
          content: l10n.tenantTerm3Content,
          badgeColor: Colors.indigo,
        ),
        const SizedBox(height: 12),
        _TermCard(
          number: '4',
          title: l10n.tenantTerm4Title,
          content: l10n.tenantTerm4Content,
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
    final l10n = context.l10n;
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        _TermCard(
          number: '1',
          title: l10n.ownerTerm1Title,
          content: l10n.ownerTerm1Content,
          badgeColor: Colors.deepOrange,
        ),
        const SizedBox(height: 12),
        _TermCard(
          number: '2',
          title: l10n.ownerTerm2Title,
          content: l10n.ownerTerm2Content,
          badgeColor: Colors.purple,
        ),
        const SizedBox(height: 12),
        _TermCard(
          number: '3',
          title: l10n.ownerTerm3Title,
          content: l10n.ownerTerm3Content,
          badgeColor: Colors.green,
        ),
        const SizedBox(height: 12),
        _TermCard(
          number: '4',
          title: l10n.ownerTerm4Title,
          content: l10n.ownerTerm4Content,
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
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
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
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13.5,
                  height: 1.5,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}