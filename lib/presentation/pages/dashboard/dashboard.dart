import 'package:flutter/material.dart';
import 'package:rental_room/presentation/pages/dashboard/widgets/dashboard_content.dart';
import 'package:rental_room/presentation/pages/dashboard/widgets/dashboard_header.dart';
import '../../../domain/domain.dart';

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