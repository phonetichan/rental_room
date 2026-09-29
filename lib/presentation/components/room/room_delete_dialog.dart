import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/room_cubit/room_cubit.dart';

void showRoomDeleteDialog({
  required BuildContext context,
  required String roomId,
  VoidCallback? onDeleted,
}) {
  final roomCubit = context.read<RoomCubit>();

  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Delete Room'),
      content: const Text(
        'Are you sure you want to delete this room?\nThis action is permanent and cannot be undone.',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () async {
            Navigator.pop(dialogContext);
            await roomCubit.deleteRoom(roomId);
            onDeleted?.call();
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}

