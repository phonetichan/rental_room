import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:rental_room/presentation/pages/room/owner/widgets/add_edit_room_amenities_step.dart';
import 'package:rental_room/presentation/pages/room/owner/widgets/add_edit_room_form_step.dart';
import 'package:rental_room/presentation/pages/room/owner/widgets/add_edit_room_photos_step.dart';

import '../../../../data/data.dart';
import '../../../../data/services/image_kit.dart';
import '../../../../di/injector.dart';
import '../../../../domain/domain.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../blocs/blocs.dart';
import '../../../components/components.dart';
import '../../../extensions/l10n/l10n.dart';
import '../../openstreetmap/location_widgets.dart';
import '../../openstreetmap/picker_location.dart';

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
  late final TextEditingController _depositAmountController;
  late final TextEditingController _agentNameController;
  late final TextEditingController _agentFeesController;

  PickedLocation? _pickedLocation;

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
    _depositAmountController = TextEditingController(
      text: r?.depositeAmount?.toString() ?? '',
    );
    _agentNameController = TextEditingController(
      text: r?.agentName ?? '',
    );
    _agentFeesController = TextEditingController(
      text: r?.agentFees?.toString() ?? '',
    );

    if (r != null) {
      _selectedRoomType = r.roomTypeId;
      _maxGuests = r.maxGuests;
      _numberBedrooms = r.numberBedrooms;
      _selectedAmenityIds.addAll(r.amenityIds);
      _existingImages.addAll(r.images);

      if (r.latitude != null && r.longitude != null) {
        _pickedLocation = PickedLocation(
          LatLng(r.latitude!, r.longitude!),
          r.location,
        );
      }
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
    _depositAmountController.dispose();
    _agentNameController.dispose();
    _agentFeesController.dispose();
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

  void _onLocationChanged(PickedLocation picked) {
    setState(() {
      _pickedLocation = picked;
      _locationController.text = picked.address;
      _latController.text = picked.latLng.latitude.toString();
      _lngController.text = picked.latLng.longitude.toString();
    });
  }

  bool _validateCurrentStep() {
    FocusScope.of(context).unfocus();
    final l10n = context.l10n;

    switch (_activeStep) {
      case 0: // Details
        if (_nameController.text.trim().isEmpty) {
          _snackShower.error(context: context, message: l10n.pleaseEnterRoomName);
          return false;
        }
        if (_roomNumberController.text.trim().isEmpty) {
          _snackShower.error(context: context, message: l10n.pleaseEnterRoomNumber);
          return false;
        }
        if (_floorController.text.trim().isEmpty) {
          _snackShower.error(context: context, message: l10n.pleaseEnterFloorDetails);
          return false;
        }
        if (_selectedRoomType == null || _selectedRoomType!.isEmpty) {
          _snackShower.error(context: context, message: l10n.pleaseSelectRoomType);
          return false;
        }
        if (_sqftController.text.trim().isEmpty) {
          _snackShower.error(context: context, message: l10n.pleaseEnterSquareFootage);
          return false;
        }
        if (_priceController.text.trim().isEmpty) {
          _snackShower.error(context: context, message: l10n.pleaseEnterRentalPrice);
          return false;
        }
        return true;

      case 1: // Map
        if (_locationController.text.trim().isEmpty || _pickedLocation == null) {
          _snackShower.error(context: context, message: l10n.pleaseChooseLocationOnMap);
          return false;
        }
        if (_latController.text.trim().isEmpty || _lngController.text.trim().isEmpty) {
          _snackShower.error(context: context, message: l10n.latitudeAndLongitudeRequired);
          return false;
        }
        return true;

      case 2: // Amenities
        return true;

      case 3: // Photos
        if (_existingImages.isEmpty && _selectedImages.isEmpty) {
          _snackShower.error(context: context, message: l10n.pleaseUploadPhoto);
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
      if (_activeStep < 3) {
        setState(() => _activeStep++);
      } else {
        _submitForm();
      }
    }
  }

  Future<void> _submitForm() async {
    final authUser = context.read<AuthenticationCubit>().user;
    final l10n = AppLocalizations.of(context)!;
    if (authUser == null) {
      _snackShower.error(context: context, message: l10n.userSessionNotFound);
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

      final depositText = _depositAmountController.text.trim();
      final depositeAmount = depositText.isNotEmpty ? double.tryParse(depositText) : null;

      final agentNameText = _agentNameController.text.trim();
      final agentName = agentNameText.isEmpty ? null : agentNameText;

      final agentFeesText = _agentFeesController.text.trim();
      final agentFees = agentFeesText.isNotEmpty ? double.tryParse(agentFeesText) : null;

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
        depositeAmount: depositeAmount,
        agentName: agentName,
        agentFees: agentFees,
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
        final l10n = AppLocalizations.of(context)!;
        _snackShower.error(context: context, message: l10n.errorSavingRoom(e.toString()));
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
    final l10n = context.l10n;

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
                _isEditing ? l10n.editRoomListing : l10n.addRoomListing,
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
                  steps: [
                    StepData(l10n.details, Icons.meeting_room_outlined),
                    StepData(l10n.locationMap, Icons.map_outlined),
                    StepData(l10n.amenities, Icons.star_outline),
                    StepData(l10n.photos, Icons.photo_library_outlined),
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
                          child: Text(
                            l10n.cancel,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
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
                          _activeStep < 3
                              ? l10n.next
                              : (_isEditing
                              ? l10n.updateRoom
                              : l10n.createRoom),
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
    final l10n = context.l10n;

    switch (_activeStep) {
      case 0: // Details
        return Column(
          key: const ValueKey(0),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionCard(
              children: [
                AddEditRoomFormStep(
                  isSubmitting: isSubmitting,
                  isEditing: _isEditing,
                  nameController: _nameController,
                  roomNumberController: _roomNumberController,
                  floorController: _floorController,
                  sqftController: _sqftController,
                  priceController: _priceController,
                  depositAmountController: _depositAmountController,
                  agentNameController: _agentNameController,
                  agentFeesController: _agentFeesController,
                  descriptionController: _descriptionController,
                  selectedRoomType: _selectedRoomType,
                  roomTypes: _roomTypes,
                  maxGuests: _maxGuests,
                  numberBedrooms: _numberBedrooms,
                  onRoomTypeChanged: (v) => setState(() => _selectedRoomType = v),
                  onMaxGuestsChanged: (val) => setState(() => _maxGuests = val),
                  onNumberBedroomsChanged: (val) => setState(() => _numberBedrooms = val),
                  inputDecorationBuilder: _buildInputDecoration,
                ),
              ],
            ),
          ],
        );
      case 1: // Map
        return Column(
          key: const ValueKey(1),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(title: l10n.roomLocation, icon: Icons.map_outlined),
            _buildSectionCard(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      LocationField(
                        value: _pickedLocation,
                        onChanged: _onLocationChanged,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _latController,
                              readOnly: true,
                              decoration: _buildInputDecoration(
                                labelText: l10n.latitude,
                                prefixIcon: Icons.gps_fixed,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _lngController,
                              readOnly: true,
                              decoration: _buildInputDecoration(
                                labelText: l10n.longitude,
                                prefixIcon: Icons.gps_fixed,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      case 2: // Amenities
        return Column(
          key: const ValueKey(2),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(title: l10n.amenities, icon: Icons.star_outline),
            _buildSectionCard(
              children: [
                AddEditRoomAmenitiesStep(
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
      case 3: // Photos
      default:
        return Column(
          key: const ValueKey(3),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(title: l10n.roomPhotos, icon: Icons.photo_library_outlined),
            _buildSectionCard(
              children: [
                AddEditRoomPhotosStep(
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