import 'package:flutter/material.dart';

import '../../../../../domain/domain.dart';
import '../../../../extensions/l10n/l10n.dart';
import '../../../../extensions/number/number.dart';

/// Bottom action bar for room owner (shows room price and Edit details button).
// class OwnerRoomBottomActionBar extends StatelessWidget {
//   final RoomEntity room;
//   final Future<void> Function() onEditRoom;
//
//   const OwnerRoomBottomActionBar({
//     super.key,
//     required this.room,
//     required this.onEditRoom,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final primaryColor = theme.primaryColor;
//     final l10n = context.l10n;
//
//     return Container(
//       padding: EdgeInsets.only(
//         left: 16,
//         right: 16,
//         top: 12,
//         bottom: MediaQuery.of(context).padding.bottom + 12,
//       ),
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.08),
//             blurRadius: 10,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 l10n.price,
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//               Text(
//                 room.pricePerMonth.toKsFormat,
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                   color: primaryColor,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: SizedBox(
//               height: 48,
//               child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: primaryColor,
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                 ),
//                 onPressed: () => onEditRoom(),
//                 icon: const Icon(Icons.edit_outlined, size: 20),
//                 label: Text(
//                   l10n.editRoomDetails,
//                   style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class OwnerRoomBottomActionBar extends StatelessWidget {
  final RoomEntity room;
  final Future<void> Function() onEditRoom;

  const OwnerRoomBottomActionBar({
    super.key,
    required this.room,
    required this.onEditRoom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final l10n = context.l10n;

    final isRented = room.status.toLowerCase() == 'rented';

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.price,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  room.pricePerMonth.toKsFormat,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          if (isRented) ...[
            const SizedBox(width: 12),
            const Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 18,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Room is rented',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: onEditRoom,
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 20,
                  ),
                  label: Text(
                    l10n.editRoomDetails,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}