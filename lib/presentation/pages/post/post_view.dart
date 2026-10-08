import 'package:flutter/material.dart';
import 'widgets/tenant_post_view_content.dart';
import 'widgets/owner_post_view_content.dart';

import '../../../domain/domain.dart';

class PostView extends StatelessWidget {
  final UserEntity user;
  final String? initialRoomTypeId;

  const PostView({
    super.key,
    required this.user,
    this.initialRoomTypeId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: user.role == UserRole.owner
          ? OwnerPostViewContent(user: user)
          : TenantPostViewContent(
              user: user,
              initialRoomTypeId: initialRoomTypeId,
            ),
    );
  }
}
