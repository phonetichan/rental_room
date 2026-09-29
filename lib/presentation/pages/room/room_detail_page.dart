import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/datasource/remote/auth_data_source.dart';
import '../../../di/di.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';
import '../../extensions/extensions.dart';
import 'widgets/room_metric_widget.dart';

class RoomDetailScreen extends StatefulWidget {
  static const String routeName = 'room-detail';
  static const String routePath = '/room-detail';

  final RoomEntity room;

  const RoomDetailScreen({super.key, required this.room});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  late RoomEntity _room;
  List<Map<String, dynamic>> _amenitiesList = [];

  @override
  void initState() {
    super.initState();
    _room = widget.room;
    _loadAmenities();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUser = context.read<AuthenticationCubit>().user;
      if (currentUser != null && mounted) {
        context.read<FavoriteCubit>().loadFavorites(currentUser.id);
      }
    });
  }

  Future<void> _loadAmenities() async {
    try {
      final repo = inject<RoomRepository>();
      final amenities = await repo.getAmenities();
      if (mounted) {
        setState(() {
          _amenitiesList = amenities;
        });
      }
    } catch (_) {}
  }

  Future<void> _refreshRoomData() async {
    final currentUser = context.read<AuthenticationCubit>().user;
    if (currentUser != null && mounted) {
      context.read<FavoriteCubit>().loadFavorites(currentUser.id);
    }

    try {
      final repo = inject<RoomRepository>();
      final updatedRoom = await repo.getRoomById(_room.id);
      if (updatedRoom != null && mounted) {
        setState(() {
          _room = updatedRoom;
        });
        return;
      }
    } catch (_) {}

    if (!mounted) return;
    await context.read<RoomCubit>().fetchRooms();
    if (!mounted) return;
    final state = context.read<RoomCubit>().state;
    state.maybeWhen(
      loaded: (rooms) {
        final updated = rooms.where((r) => r.id == _room.id).firstOrNull;
        if (updated != null && mounted) {
          setState(() {
            _room = updated;
          });
        }
      },
      orElse: () {},
    );
  }

  Future<void> _openGoogleMaps() async {
    final String query = (_room.latitude != null && _room.longitude != null)
        ? '${_room.latitude},${_room.longitude}'
        : Uri.encodeComponent(_room.location);

    final googleMapsUrl =
    Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    final geoUrl = (_room.latitude != null && _room.longitude != null)
        ? Uri.parse(
      'geo:${_room.latitude},${_room.longitude}?q=${_room.latitude},${_room.longitude}(${Uri.encodeComponent(_room.name)})',
    )
        : googleMapsUrl;

    try {
      if (await canLaunchUrl(geoUrl)) {
        await launchUrl(geoUrl, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening map: $e')),
      );
    }
  }

  void _confirmDelete(BuildContext context) {
    showRoomDeleteDialog(
      context: context,
      roomId: _room.id,
      onDeleted: () {
        if (mounted) {
          context.pop(true);
        }
      },
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = theme.primaryColor;
    final currentUser = context.read<AuthenticationCubit>().user;
    final bool isOwnerOfRoom =
        currentUser != null && _room.ownerId == currentUser.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(_room.name),
        elevation: 0,
        actions: [
          if (currentUser != null && !isOwnerOfRoom)
            BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, favoriteState) {
                final isFav = favoriteState.isFavorite(_room.id);
                return IconButton(
                  tooltip:
                  isFav ? 'Remove from Favorites' : 'Add to Favorites',
                  icon: Icon(
                    isFav
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isFav ? const Color(0xFFEF4444) : null,
                  ),
                  onPressed: () {
                    context.read<FavoriteCubit>().toggleFavorite(
                      roomId: _room.id,
                      userId: currentUser.id,
                      ownerId: _room.ownerId,
                    );
                  },
                );
              },
            ),
          if (isOwnerOfRoom)
            IconButton(
              tooltip: 'Delete Room',
              icon: Icon(
                Icons.delete_outline_rounded,
                color: Colors.red.shade600,
              ),
              onPressed: () => _confirmDelete(context),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGES CAROUSEL / BANNER
            if (_room.images.isNotEmpty)
              SizedBox(
                height: 220,
                child: PageView.builder(
                  itemCount: _room.images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(
                            _room.images[index].imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.hotel_rounded,
                  size: 60,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(height: 20),

            // TITLE & PRICE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _room.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  _room.pricePerMonth.toKsFormat,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // LOCATION
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    _room.location,
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ROOM KEY METRICS (Bedrooms, Guests, Sqft, Floor)
            Card(
              elevation: 0,
              color: primaryColor.withValues(alpha: 0.06),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RoomMetricWidget(
                      icon: Icons.king_bed_outlined,
                      label: '${_room.numberBedrooms} Beds',
                    ),
                    RoomMetricWidget(
                      icon: Icons.group_outlined,
                      label: '${_room.maxGuests} Guests',
                    ),
                    RoomMetricWidget(
                      icon: Icons.straighten_outlined,
                      label: '${_room.roomSqft.toStringAsFixed(0)} sqft',
                    ),
                    RoomMetricWidget(
                      icon: Icons.layers_outlined,
                      label: 'Fl. ${_room.floor}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // FAVORITES INFORMATION CARD FOR OWNER
            if (isOwnerOfRoom)
              BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, favoriteState) {
                  final favCount = favoriteState.getFavoriteCount(_room.id);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          color: Colors.red.shade600,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$favCount ${favCount == 1 ? 'User Favorited' : 'Users Favorited'} This Room',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade900,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Track engagement for your property listing.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

            // AMENITIES LIST
            if (_room.amenityIds.isNotEmpty)
              _buildSectionCard(
                title: 'Amenities',
                icon: Icons.star_outline,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _room.amenityIds.toSet().toList().map((
                        amenityId,
                        ) {
                      final matching = _amenitiesList
                          .where((a) => a['id'] == amenityId)
                          .firstOrNull;
                      final name = matching != null
                          ? (matching['name'] as String)
                          : amenityId
                          .replaceAll('amenity_', '')
                          .replaceAll('_', ' ')
                          .toUpperCase();
                      final iconName = matching != null
                          ? ((matching['icon'] as String?) ?? 'help_outline')
                          : amenityId.replaceFirst('amenity_', '');
                      final icon = inject<AuthDataSource>().getAmenityIcon(
                        iconName,
                      );

                      return Chip(
                        avatar: Icon(icon, size: 18),
                        label: Text(name),
                      );
                    }).toList(),
                  ),
                ],
              ),

            // STATUS BADGE
            _buildSectionCard(
              title: 'Status',
              icon: Icons.info_outline,
              children: [
                Row(
                  children: [
                    Chip(
                      side: BorderSide.none,
                      backgroundColor: _room.status == 'available'
                          ? primaryColor.withValues(alpha: 0.1)
                          : Colors.orange.shade100,
                      label: Text(
                        _room.status.toUpperCase(),
                        style: TextStyle(
                          color: _room.status == 'available'
                              ? primaryColor
                              : Colors.orange.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // DESCRIPTION SECTION (Formatted as Section Card)
            _buildSectionCard(
              title: 'Description',
              icon: Icons.description_outlined,
              children: [
                Text(
                  (_room.description != null &&
                      _room.description!.trim().isNotEmpty)
                      ? _room.description!
                      : 'No description provided for this room.',
                  softWrap: true,
                  maxLines: null,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 14,
                    color: (_room.description != null &&
                        _room.description!.trim().isNotEmpty)
                        ? Colors.grey.shade700
                        : Colors.grey.shade400,
                    height: 1.5,
                  ),
                ),
              ],
            ),

            // GOOGLE MAPS LOCATION CARD (Formatted as Section Card)
            _buildSectionCard(
              title: 'Location Map',
              icon: Icons.map_outlined,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _openGoogleMaps,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: primaryColor.withValues(alpha: 0.25),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // MAP PREVIEW BANNER
                          Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  primaryColor.withValues(alpha: 0.2),
                                  primaryColor.withValues(alpha: 0.05),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  right: -20,
                                  bottom: -20,
                                  child: Icon(
                                    Icons.map_rounded,
                                    size: 140,
                                    color:
                                    primaryColor.withValues(alpha: 0.1),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: primaryColor.withValues(
                                              alpha: 0.4,
                                            ),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _room.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // MAP DETAILS & ACTION BUTTON
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _room.location,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      if (_room.latitude != null &&
                                          _room.longitude != null) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          'Lat: ${_room.latitude}, Lng: ${_room.longitude}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                            colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.directions_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'Open Map',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // EDIT ACTION (ONLY VISIBLE TO ROOM OWNER)
            if (isOwnerOfRoom) ...[
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {
                    final updated = await context.push(
                      AddEditRoomScreen.routePath,
                      extra: _room,
                    );
                    if (updated is RoomEntity && mounted) {
                      setState(() {
                        _room = updated;
                      });
                    } else if (mounted) {
                      await _refreshRoomData();
                    }
                  },
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text(
                    'Edit Room Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}