import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_room/presentation/pages/room/owner/widgets/counter_selector_widget.dart';
import 'package:rental_room/presentation/pages/room/owner/widgets/room_amenities_selector_widget.dart';
import 'package:rental_room/presentation/pages/room/owner/widgets/room_photo_selector_widget.dart';

import '../../../../data/data.dart';
import '../../../../data/services/image_kit.dart';
import '../../../../di/injector.dart';
import '../../../../domain/domain.dart';
import '../../../blocs/blocs.dart';
import '../../../components/components.dart';
import '../../setting_pages/user_guidance.dart';

class AddEditRoomScreen extends StatefulWidget {
  static const String routeName = 'add-edit-room';
  static const String routePath = '/add-edit-room';

  final RoomEntity? room;

  const AddEditRoomScreen({super.key, this.room});

  @override
  State<AddEditRoomScreen> createState() => _AddEditRoomScreenState();
}

class _AddEditRoomScreenState extends State<AddEditRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final ISnackShower _snackShower = inject<ISnackShower>();

  int _activeStep = 0;

  late final TextEditingController _nameController;
  late final TextEditingController _roomNumberController;
  late final TextEditingController _floorController;
  late final TextEditingController _priceController;
  late final TextEditingController _locationController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _sqftController;
  late final TextEditingController _latController;
  late final TextEditingController _lngController;

  int _maxGuests = 1;
  int _numberBedrooms = 1;
  String? _selectedRoomType;
  final String _selectedStatus = 'available';

  final List<String> _selectedAmenityIds = [];
  final List<RoomImageEntity> _existingImages = [];
  final List<XFile> _selectedImages = [];
  bool _isUploading = false;
  bool _isLoadingMasterData = true;

  List<Map<String, dynamic>> _roomTypes = [];
  List<Map<String, dynamic>> _amenitiesList = [];

  bool get _isEditing => widget.room != null;

  @override
  void initState() {
    super.initState();
    final r = widget.room;
    _nameController = TextEditingController(text: r?.name ?? '');
    _roomNumberController = TextEditingController(text: r?.roomNumber ?? '');
    _floorController = TextEditingController(text: r?.floor ?? '');
    _priceController = TextEditingController(
      text: r?.pricePerMonth.toString() ?? '',
    );
    _locationController = TextEditingController(text: r?.location ?? '');
    _descriptionController = TextEditingController(text: r?.description ?? '');
    _sqftController = TextEditingController(text: r?.roomSqft.toString() ?? '');
    _latController = TextEditingController(text: r?.latitude?.toString() ?? '');
    _lngController = TextEditingController(
      text: r?.longitude?.toString() ?? '',
    );

    if (r != null) {
      _selectedRoomType = r.roomTypeId;
      _maxGuests = r.maxGuests;
      _numberBedrooms = r.numberBedrooms;
      _selectedAmenityIds.addAll(r.amenityIds);
      _existingImages.addAll(r.images);
    }

    _loadMasterData();
  }

  Future<void> _loadMasterData() async {
    try {
      final repo = inject<RoomRepository>();
      final types = await repo.getRoomTypes();
      final amenities = await repo.getAmenities();

      if (mounted) {
        setState(() {
          _roomTypes = types;
          _amenitiesList = amenities;
          if (_selectedRoomType == null && _roomTypes.isNotEmpty) {
            _selectedRoomType = _roomTypes.first['id'] as String;
          }
          _isLoadingMasterData = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingMasterData = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roomNumberController.dispose();
    _floorController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _sqftController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage(
      imageQuality: 80,
    );
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(pickedFiles);
      });
    }
  }

  void _navigateToUserGuidance() {
    context.push(UserGuidancePage.routePath);
  }

  bool _validateCurrentStep() {
    FocusScope.of(context).unfocus();
    switch (_activeStep) {
      case 0: // Basic Details, Pricing & Location
        if (_nameController.text.trim().isEmpty) {
          _snackShower.error(
            context: context,
            message: 'Please enter room name.',
          );
          return false;
        }
        if (_roomNumberController.text.trim().isEmpty) {
          _snackShower.error(
            context: context,
            message: 'Please enter room number.',
          );
          return false;
        }
        if (_floorController.text.trim().isEmpty) {
          _snackShower.error(
            context: context,
            message: 'Please enter floor details.',
          );
          return false;
        }
        if (_selectedRoomType == null || _selectedRoomType!.isEmpty) {
          _snackShower.error(
            context: context,
            message: 'Please select a room type.',
          );
          return false;
        }
        if (_sqftController.text.trim().isEmpty) {
          _snackShower.error(
            context: context,
            message: 'Please enter square footage.',
          );
          return false;
        }
        if (_priceController.text.trim().isEmpty) {
          _snackShower.error(
            context: context,
            message: 'Please enter rental price.',
          );
          return false;
        }
        if (_locationController.text.trim().isEmpty) {
          _snackShower.error(
            context: context,
            message: 'Please enter location address.',
          );
          return false;
        }
        return true;

      case 1: // Amenities
        return true;

      case 2: // Photos
        if (_existingImages.isEmpty && _selectedImages.isEmpty) {
          _snackShower.error(
            context: context,
            message: 'Please upload at least 1 room photo.',
          );
          return false;
        }
        return true;

      default:
        return true;
    }
  }

  void _onStepTapped(int targetStep) {
    if (targetStep < _activeStep) {
      setState(() => _activeStep = targetStep);
    } else if (targetStep > _activeStep) {
      if (_validateCurrentStep()) {
        setState(() => _activeStep = targetStep);
      }
    }
  }

  void _handleNextStep() {
    if (_validateCurrentStep()) {
      if (_activeStep < 2) {
        setState(() => _activeStep++);
      } else {
        _submitForm();
      }
    }
  }

  Future<void> _submitForm() async {
    final authUser = context.read<AuthenticationCubit>().user;
    if (authUser == null) {
      _snackShower.error(context: context, message: 'User session not found.');
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => _isUploading = true);

    List<RoomImageEntity> finalImages = List.from(_existingImages);

    try {
      final roomId =
          widget.room?.id ?? DateTime.now().millisecondsSinceEpoch.toString();

      if (_selectedImages.isNotEmpty) {
        final uploadedUrls = await ImageKitHelper.uploadImages(
          localFiles: _selectedImages,
          ownerId: authUser.id,
          roomId: roomId,
        );
        for (var url in uploadedUrls) {
          finalImages.add(
            RoomImageEntity(
              id: DateTime.now().microsecondsSinceEpoch.toString(),
              roomId: roomId,
              imageUrl: url,
              isPrimary: finalImages.isEmpty,
            ),
          );
        }
      }

      final roomEntity = RoomEntity(
        id: roomId,
        ownerId: authUser.id,
        roomTypeId: _selectedRoomType!,
        roomNumber: _roomNumberController.text.trim(),
        name: _nameController.text.trim(),
        floor: _floorController.text.trim(),
        maxGuests: _maxGuests,
        pricePerMonth: double.tryParse(_priceController.text.trim()) ?? 0.0,
        location: _locationController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        numberBedrooms: _numberBedrooms,
        roomSqft: double.tryParse(_sqftController.text.trim()) ?? 0.0,
        amenityIds: _selectedAmenityIds,
        images: finalImages,
        latitude: double.tryParse(_latController.text.trim()),
        longitude: double.tryParse(_lngController.text.trim()),
        status: widget.room?.status ?? _selectedStatus,
        createdAt: widget.room?.createdAt,
      );

      if (mounted) {
        if (!_isEditing) {
          await context.read<RoomCubit>().createRoom(roomEntity);
        } else {
          await context.read<RoomCubit>().updateRoom(roomEntity);
        }
      }
    } catch (e) {
      if (mounted) {
        _snackShower.error(context: context, message: 'Error saving room: $e');
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    required IconData prefixIcon,
    String? hintText,
    String? suffixText,
    bool alignLabelWithHint = false,
  }) {
    final theme = Theme.of(context);

    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      suffixText: suffixText,
      alignLabelWithHint: alignLabelWithHint,
      labelStyle: TextStyle(
        fontSize: 12,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      hintStyle: TextStyle(
        fontSize: 13,
        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
      ),
      suffixStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: theme.primaryColor,
      ),
      isDense: true,
      prefixIconConstraints: alignLabelWithHint
          ? const BoxConstraints(minWidth: 44, minHeight: 0)
          : const BoxConstraints(minWidth: 44, minHeight: 44),
      prefixIcon: alignLabelWithHint
          ? Padding(
              padding: const EdgeInsets.only(top: 10, left: 8, right: 6),
              child: Icon(
                prefixIcon,
                color: theme.primaryColor.withValues(alpha: 0.8),
                size: 20,
              ),
            )
          : Icon(
              prefixIcon,
              color: theme.primaryColor.withValues(alpha: 0.8),
              size: 20,
            ),
      filled: true,
      fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
        alpha: 0.3,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: theme.colorScheme.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: theme.colorScheme.error, width: 1.5),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, required IconData icon}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.primaryColor),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required List<Widget> children}) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final cardBackground = theme.cardColor;
    final borderColor = theme.dividerColor;

    return BlocConsumer<RoomCubit, RoomState>(
      listener: (context, state) {
        if (state is RoomSuccess) {
          _snackShower.success(context: context, message: state.message);
          context.pop(true);
        } else if (state is RoomFailure) {
          _snackShower.error(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        final isSubmitting =
            state is RoomLoading || _isUploading || _isLoadingMasterData;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: theme.colorScheme.surfaceContainerLowest,
            appBar: AppBar(
              title: Text(
                _isEditing ? 'Edit Room Listing' : 'Add New Room',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: theme.colorScheme.surface,
            ),
            body: _isLoadingMasterData
                ? const Center(child: CircularProgressIndicator.adaptive())
                : Column(
                    children: [
                      AppStepper(
                        activeStep: _activeStep,
                        onStepTapped: _onStepTapped,
                        steps: const [
                          StepData('Details', Icons.meeting_room_outlined),
                          StepData('Amenities', Icons.star_outline),
                          StepData('Photos', Icons.photo_library_outlined),
                        ],
                      ),
                      // STEP CONTENT AREA
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: _buildCurrentStepContent(isSubmitting),
                            ),
                          ),
                        ),
                      ),

                      // BOTTOM NAVIGATION BAR
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardBackground,
                          border: Border(top: BorderSide(color: borderColor)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_activeStep > 0)
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      theme.textTheme.bodyLarge?.color,
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: isSubmitting
                                    ? null
                                    : () {
                                        setState(() {
                                          _activeStep--;
                                        });
                                      },
                                child: const Text(
                                  'Back',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            else
                              const SizedBox.shrink(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: isSubmitting ? null : _handleNextStep,
                              child: isSubmitting
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator.adaptive(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      _activeStep < 2
                                          ? 'Next'
                                          : (_isEditing
                                                ? 'Update Room'
                                                : 'Create Room'),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentStepContent(bool isSubmitting) {
    switch (_activeStep) {
      case 0: // CASE 1: ALL DETAILS, PRICING, LOCATION & DESCRIPTION (NO TITLE HEADER)
        return Column(
          key: const ValueKey(0),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionCard(
              children: [
                TextFormField(
                  controller: _nameController,
                  enabled: !isSubmitting,
                  style: const TextStyle(fontSize: 14),
                  decoration: _buildInputDecoration(
                    labelText: 'Room Name / Title',
                    hintText: 'e.g. Cozy Deluxe Room 101',
                    prefixIcon: Icons.meeting_room_outlined,
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Please enter room name'
                      : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _roomNumberController,
                        enabled: !isSubmitting && !_isEditing,
                        style: const TextStyle(fontSize: 14),
                        decoration: _buildInputDecoration(
                          labelText: 'Room Number',
                          hintText: '101',
                          prefixIcon: Icons.tag,
                        ),
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Required' : null,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextFormField(
                        controller: _floorController,
                        enabled: !isSubmitting,
                        style: const TextStyle(fontSize: 14),
                        decoration: _buildInputDecoration(
                          labelText: 'Floor',
                          hintText: '1st Floor',
                          prefixIcon: Icons.layers_outlined,
                        ),
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Required' : null,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  value: _selectedRoomType,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  decoration: _buildInputDecoration(
                    labelText: 'Room Type',
                    prefixIcon: Icons.category_outlined,
                  ),
                  items: _roomTypes
                      .map(
                        (type) => DropdownMenuItem<String>(
                          value: type['id'] as String,
                          child: Text(
                            type['name'] as String,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: isSubmitting
                      ? null
                      : (v) => setState(() => _selectedRoomType = v),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Please select room type' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _sqftController,
                  enabled: !isSubmitting && !_isEditing,
                  style: const TextStyle(fontSize: 14),
                  keyboardType: TextInputType.number,
                  decoration: _buildInputDecoration(
                    labelText: 'Room Sqft',
                    hintText: 'e.g. 450',
                    prefixIcon: Icons.straighten_outlined,
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Enter room square footage'
                      : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _priceController,
                  enabled: !isSubmitting,
                  style: const TextStyle(fontSize: 14),
                  keyboardType: TextInputType.number,
                  decoration: _buildInputDecoration(
                    labelText: 'Price / Month',
                    hintText: 'e.g. 300000',
                    prefixIcon: Icons.payments_outlined,
                    suffixText: 'MMK',
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Enter price in MMK'
                      : null,
                ),
                const SizedBox(height: 14),
                CounterSelectorWidget(
                  label: 'Max Guests Allowed',
                  icon: Icons.group_outlined,
                  value: _maxGuests,
                  enabled: !isSubmitting,
                  onChanged: (val) => setState(() => _maxGuests = val),
                ),
                const SizedBox(height: 14),
                CounterSelectorWidget(
                  label: 'Number of Bedrooms',
                  icon: Icons.king_bed_outlined,
                  value: _numberBedrooms,
                  minValue: 0,
                  enabled: !isSubmitting,
                  onChanged: (val) => setState(() => _numberBedrooms = val),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _locationController,
                  enabled: !isSubmitting,
                  style: const TextStyle(fontSize: 14),
                  minLines: 2,
                  maxLines: 3,
                  decoration: _buildInputDecoration(
                    labelText: 'Location / Address',
                    hintText: 'Enter location',
                    prefixIcon: Icons.place_outlined,
                    alignLabelWithHint: true,
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Please enter location'
                      : null,
                  keyboardType: TextInputType.streetAddress,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _latController,
                        enabled: !isSubmitting,
                        style: const TextStyle(fontSize: 14),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                        decoration: _buildInputDecoration(
                          labelText: 'Latitude',
                          hintText: '16.8409',
                          prefixIcon: Icons.map_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _lngController,
                        enabled: !isSubmitting,
                        style: const TextStyle(fontSize: 14),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                        decoration: _buildInputDecoration(
                          labelText: 'Longitude',
                          hintText: '96.1735',
                          prefixIcon: Icons.explore_outlined,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: _navigateToUserGuidance,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 4.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.help_outline_rounded,
                            size: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'How to find Latitude & Longitude?',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  enabled: !isSubmitting,
                  style: const TextStyle(fontSize: 14),
                  minLines: 4,
                  maxLines: 6,
                  decoration: _buildInputDecoration(
                    labelText: 'Description (Optional)',
                    hintText:
                        'Enter room details, rules, amenities description...',
                    prefixIcon: Icons.description_outlined,
                    alignLabelWithHint: true,
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          ],
        );

      case 1: // CASE 2: AMENITIES (INCLUDES TITLE HEADER)
        return Column(
          key: const ValueKey(1),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(title: 'Amenities', icon: Icons.star_outline),
            _buildSectionCard(
              children: [
                RoomAmenitiesSelectorWidget(
                  amenitiesList: _amenitiesList,
                  selectedAmenityIds: _selectedAmenityIds,
                  isSubmitting: isSubmitting,
                  onAmenitySelected: (amenityId) {
                    setState(() {
                      if (_selectedAmenityIds.contains(amenityId)) {
                        _selectedAmenityIds.remove(amenityId);
                      } else {
                        _selectedAmenityIds.add(amenityId);
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        );

      case 2: // CASE 3: PHOTOS (NO TITLE HEADER)
      default:
        return Column(
          key: const ValueKey(2),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionCard(
              children: [
                RoomPhotoSelectorWidget(
                  existingImages: _existingImages,
                  selectedImages: _selectedImages,
                  isSubmitting: isSubmitting,
                  onPickImages: _pickImages,
                  onRemoveExistingImage: (index) {
                    setState(() {
                      _existingImages.removeAt(index);
                    });
                  },
                  onRemoveSelectedImage: (index) {
                    setState(() {
                      _selectedImages.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          ],
        );
    }
  }
}
