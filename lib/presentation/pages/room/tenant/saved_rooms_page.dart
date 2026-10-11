import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_room/presentation/pages/room/tenant/widgets/room_paginated_tab.dart';

import '../../../blocs/blocs.dart';
import '../../../../domain/domain.dart';
import '../../../extensions/l10n.dart';

class SavedRoomsPage extends StatelessWidget {
  final UserEntity user;

  const SavedRoomsPage({super.key, required this.user});

  static const String routePath = '/saved-rooms';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SavedRoomsCubit>();
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.savedRooms)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<FavoriteCubit, FavoriteState>(
            listenWhen: (prev, curr) =>
                !setEquals(prev.userFavoriteRoomIds, curr.userFavoriteRoomIds),
            listener: (context, state) => cubit.refresh(),
            child: RoomPaginatedTab(
              cubit: cubit,
              user: user,
              onRefresh: cubit.refresh,
              favoritesOnly: true,
              emptyIcon: Icons.bookmark_border_rounded,
              emptyMessage: 'No saved rooms found.',
            ),
          ),
        ),
      ),
    );
  }
}
