import 'package:flutter/material.dart';
import '../../../domain/domain.dart';

class PostView extends StatelessWidget {
  final UserEntity user;

  const PostView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isOwner = user.role == UserRole.owner;

    return Center(
      child: Text(
        isOwner ? 'Manage Property Listings' : 'Post Room Requirements',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}