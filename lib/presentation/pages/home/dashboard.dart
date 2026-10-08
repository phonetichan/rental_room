// import 'package:flutter/material.dart';
//
// import '../../../domain/domain.dart';
// import 'widgets/dashboard_header.dart';
// import 'widgets/dashboard_content.dart';
// import 'widgets/tenant_dashboard_content.dart';
//
// class DashboardView extends StatelessWidget {
//   final UserEntity user;
//
//   const DashboardView({
//     super.key,
//     required this.user,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final isOwner = user.role == UserRole.owner;
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           DashboardHeader(
//             user: user,
//             isOwner: isOwner,
//           ),
//           const SizedBox(height: 20),
//           if (isOwner) ...[
//             OwnerDashboardContent(user: user),
//           ] else ...[
//             TenantDashboardContent(user: user),
//           ],
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../domain/domain.dart';
import 'widgets/dashboard_content.dart';
import 'widgets/dashboard_header.dart';

class DashboardView extends StatelessWidget {
  final UserEntity user;

  const DashboardView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final isOwner = user.role == UserRole.owner;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardHeader(
            user: user,
            isOwner: isOwner,
          ),
          const SizedBox(height: 20),
          DashboardContent(user: user),
        ],
      ),
    );
  }
}