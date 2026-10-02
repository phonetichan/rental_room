import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';
import '../../../presentation.dart';

class TenantDashboardContent extends StatefulWidget {
  final UserEntity user;

  const TenantDashboardContent({super.key, required this.user});

  @override
  State<TenantDashboardContent> createState() => _TenantDashboardContentState();
}

class _TenantDashboardContentState extends State<TenantDashboardContent> {
  String? _selectedRoomTypeId;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoomCubit>().fetchRooms(status: 'available');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting & Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.user.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 24,
                backgroundColor: colorScheme.primaryContainer,
                backgroundImage: widget.user.image != null &&
                        widget.user.image!.isNotEmpty
                    ? NetworkImage(widget.user.image!)
                    : null,
                child: widget.user.image == null || widget.user.image!.isEmpty
                    ? Text(
                        widget.user.name.isNotEmpty
                            ? widget.user.name[0].toUpperCase()
                            : 'T',
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Search Bar
          TextField(
            controller: _searchController,
            onChanged: (val) {
              setState(() {
                _searchQuery = val.trim().toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search rooms by name, location...',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: colorScheme.surfaceContainerHighest.withAlpha(100),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          const SizedBox(height: 24),

          // Categories / Room Types
          Text(
            'Categories',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryChip(
                  context,
                  label: 'All',
                  isSelected: _selectedRoomTypeId == null,
                  onSelected: (_) {
                    setState(() {
                      _selectedRoomTypeId = null;
                    });
                    context.read<RoomCubit>().fetchRooms(status: 'available');
                  },
                ),
                ...LookupConstants.roomTypes.entries.map((entry) {
                  final isSelected = _selectedRoomTypeId == entry.key;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: _buildCategoryChip(
                      context,
                      label: entry.value,
                      isSelected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          _selectedRoomTypeId = entry.key;
                        });
                        context.read<RoomCubit>().fetchRooms(
                              roomTypeId: entry.key,
                              status: 'available',
                            );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Listings Header
          Text(
            'Available Listings',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          // Room List BlocBuilder
          BlocBuilder<RoomCubit, RoomState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
                loaded: (rooms) {
                  final filteredRooms = rooms.where((room) {
                    final matchesSearch = room.name.toLowerCase().contains(_searchQuery) ||
                        room.location.toLowerCase().contains(_searchQuery) ||
                        (room.description?.toLowerCase().contains(_searchQuery) ?? false);
                    return matchesSearch;
                  }).toList();

                  if (filteredRooms.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(Icons.hotel_outlined, size: 48, color: Colors.grey.shade400),
                            const SizedBox(height: 12),
                            Text(
                              'No rooms found',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredRooms.length,
                    itemBuilder: (context, index) {
                      final room = filteredRooms[index];
                      return RoomCard(
                        room: room,
                        currentUser: widget.user,
                        showOwnerActions: false,
                        onRoomUpdated: () {
                          context.read<RoomCubit>().fetchRooms(status: 'available');
                        },
                      );
                    },
                  );
                },
                failure: (message) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      'Error loading rooms: $message',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
      BuildContext context, {
        required String label,
        required bool isSelected,
        required ValueChanged<bool> onSelected,
      }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: colorScheme.primary,
      backgroundColor: colorScheme.surfaceContainerHighest.withAlpha(80),
      labelStyle: TextStyle(
        color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
