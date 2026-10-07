// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../../data/services/snack_shower.dart';
// import '../../../di/di.dart';
// import '../../../domain/domain.dart';
// import '../../helpers/image_helper/image_kit_helper.dart';
// import '../../presentation.dart';
// import 'widgets/counter_selector_widget.dart';
// import 'widgets/room_section_card_widget.dart';
// import 'widgets/room_photo_selector_widget.dart';
// import 'widgets/room_amenities_selector_widget.dart';
//
// class AddEditRoomScreen extends StatefulWidget {
//   static const String routeName = 'add-edit-room';
//   static const String routePath = '/add-edit-room';
//
//   final RoomEntity? room;
//
//   const AddEditRoomScreen({super.key, this.room});
//
//   @override
//   State<AddEditRoomScreen> createState() => _AddEditRoomScreenState();
// }
//
// class _AddEditRoomScreenState extends State<AddEditRoomScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker _picker = ImagePicker();
//   final ISnackShower _snackShower = inject<ISnackShower>();
//
//   late final TextEditingController _nameController;
//   late final TextEditingController _roomNumberController;
//   late final TextEditingController _floorController;
//   late final TextEditingController _priceController;
//   late final TextEditingController _locationController;
//   late final TextEditingController _descriptionController;
//   late final TextEditingController _sqftController;
//   late final TextEditingController _latController;
//   late final TextEditingController _lngController;
//
//   int _maxGuests = 1;
//   int _numberBedrooms = 1;
//   String? _selectedRoomType;
//   final String _selectedStatus = 'available';
//
//   final List<String> _selectedAmenityIds = [];
//   final List<RoomImageEntity> _existingImages = [];
//   final List<XFile> _selectedImages = [];
//   bool _isUploading = false;
//   bool _isLoadingMasterData = true;
//
//   List<Map<String, dynamic>> _roomTypes = [];
//   List<Map<String, dynamic>> _amenitiesList = [];
//
//   bool get _isEditing => widget.room != null;
//
//   @override
//   void initState() {
//     super.initState();
//     final r = widget.room;
//     _nameController = TextEditingController(text: r?.name ?? '');
//     _roomNumberController = TextEditingController(text: r?.roomNumber ?? '');
//     _floorController = TextEditingController(text: r?.floor ?? '');
//     _priceController = TextEditingController(
//       text: r?.pricePerMonth.toString() ?? '',
//     );
//     _locationController = TextEditingController(text: r?.location ?? '');
//     _descriptionController = TextEditingController(text: r?.description ?? '');
//     _sqftController = TextEditingController(text: r?.roomSqft.toString() ?? '');
//     _latController = TextEditingController(text: r?.latitude?.toString() ?? '');
//     _lngController = TextEditingController(
//       text: r?.longitude?.toString() ?? '',
//     );
//
//     if (r != null) {
//       _selectedRoomType = r.roomTypeId;
//       _maxGuests = r.maxGuests;
//       _numberBedrooms = r.numberBedrooms;
//       _selectedAmenityIds.addAll(r.amenityIds);
//       _existingImages.addAll(r.images);
//     }
//
//     _loadMasterData();
//   }
//
//   Future<void> _loadMasterData() async {
//     try {
//       final repo = inject<RoomRepository>();
//       final types = await repo.getRoomTypes();
//       final amenities = await repo.getAmenities();
//
//       if (mounted) {
//         setState(() {
//           _roomTypes = types;
//           _amenitiesList = amenities;
//           if (_selectedRoomType == null && _roomTypes.isNotEmpty) {
//             _selectedRoomType = _roomTypes.first['id'] as String;
//           }
//           _isLoadingMasterData = false;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => _isLoadingMasterData = false);
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _roomNumberController.dispose();
//     _floorController.dispose();
//     _priceController.dispose();
//     _locationController.dispose();
//     _descriptionController.dispose();
//     _sqftController.dispose();
//     _latController.dispose();
//     _lngController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _pickImages() async {
//     final List<XFile> pickedFiles = await _picker.pickMultiImage(
//       imageQuality: 80,
//     );
//     if (pickedFiles.isNotEmpty) {
//       setState(() {
//         _selectedImages.addAll(pickedFiles);
//       });
//     }
//   }
//
//   void _navigateToUserGuidance() {
//     context.push(UserGuidancePage.routePath);
//   }
//
//   Future<void> _submitForm() async {
//     final authUser = context.read<AuthenticationCubit>().user;
//     if (authUser == null) {
//       _snackShower.error(context: context, message: 'User session not found.');
//       return;
//     }
//
//     if (!_formKey.currentState!.validate()) return;
//     if (_selectedRoomType == null || _selectedRoomType!.isEmpty) {
//       _snackShower.error(
//         context: context,
//         message: 'Please select a room type.',
//       );
//       return;
//     }
//
//     FocusScope.of(context).unfocus();
//     setState(() => _isUploading = true);
//
//     List<RoomImageEntity> finalImages = List.from(_existingImages);
//
//     try {
//       final roomId =
//           widget.room?.id ?? DateTime.now().millisecondsSinceEpoch.toString();
//
//       if (_selectedImages.isNotEmpty) {
//         final uploadedUrls = await ImageKitHelper.uploadImages(
//           localFiles: _selectedImages,
//           ownerId: authUser.id,
//           roomId: roomId,
//         );
//         for (var url in uploadedUrls) {
//           finalImages.add(
//             RoomImageEntity(
//               id: DateTime.now().microsecondsSinceEpoch.toString(),
//               roomId: roomId,
//               imageUrl: url,
//               isPrimary: finalImages.isEmpty,
//             ),
//           );
//         }
//       }
//
//       final roomEntity = RoomEntity(
//         id: roomId,
//         ownerId: authUser.id,
//         roomTypeId: _selectedRoomType!,
//         roomNumber: _roomNumberController.text.trim(),
//         name: _nameController.text.trim(),
//         floor: _floorController.text.trim(),
//         maxGuests: _maxGuests,
//         pricePerMonth: double.tryParse(_priceController.text.trim()) ?? 0.0,
//         location: _locationController.text.trim(),
//         description: _descriptionController.text.trim().isEmpty
//             ? null
//             : _descriptionController.text.trim(),
//         numberBedrooms: _numberBedrooms,
//         roomSqft: double.tryParse(_sqftController.text.trim()) ?? 0.0,
//         amenityIds: _selectedAmenityIds,
//         images: finalImages,
//         latitude: double.tryParse(_latController.text.trim()),
//         longitude: double.tryParse(_lngController.text.trim()),
//         status: widget.room?.status ?? _selectedStatus,
//         createdAt: widget.room?.createdAt,
//       );
//
//       if (mounted) {
//         if (!_isEditing) {
//           await context.read<RoomCubit>().createRoom(roomEntity);
//         } else {
//           await context.read<RoomCubit>().updateRoom(roomEntity);
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         _snackShower.error(context: context, message: 'Error saving room: $e');
//       }
//     } finally {
//       if (mounted) setState(() => _isUploading = false);
//     }
//   }
//
//   InputDecoration _buildInputDecoration({
//     required String labelText,
//     required IconData prefixIcon,
//     String? hintText,
//     String? suffixText,
//     bool alignLabelWithHint = false,
//   }) {
//     final theme = Theme.of(context);
//     return InputDecoration(
//       labelText: labelText,
//       hintText: hintText,
//       suffixText: suffixText,
//       alignLabelWithHint: alignLabelWithHint,
//       prefixIcon: alignLabelWithHint
//           ? Padding(
//               padding: const EdgeInsets.only(bottom: 80),
//               child: Icon(
//                 prefixIcon,
//                 color: theme.primaryColor.withValues(alpha: 0.7),
//                 size: 20,
//               ),
//             )
//           : Icon(
//               prefixIcon,
//               color: theme.primaryColor.withValues(alpha: 0.7),
//               size: 20,
//             ),
//       filled: true,
//       fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
//         alpha: 0.3,
//       ),
//       // contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(
//           color: theme.colorScheme.outline.withValues(alpha: 0.4),
//           width: 1,
//         ),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(
//           color: theme.colorScheme.outline.withValues(alpha: 0.3),
//           width: 1,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(color: theme.colorScheme.error, width: 1),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(color: theme.colorScheme.error, width: 1.5),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = Theme.of(context).primaryColor;
//
//     return BlocConsumer<RoomCubit, RoomState>(
//       listener: (context, state) {
//         if (state is RoomSuccess) {
//           _snackShower.success(context: context, message: state.message);
//           context.pop(true);
//         } else if (state is RoomFailure) {
//           _snackShower.error(context: context, message: state.message);
//         }
//       },
//       builder: (context, state) {
//         final isSubmitting =
//             state is RoomLoading || _isUploading || _isLoadingMasterData;
//
//         return Scaffold(
//           backgroundColor: Theme.of(context).colorScheme.surface,
//           appBar: AppBar(
//             title: Text(
//               _isEditing ? 'Edit Room Listing' : 'Add New Room',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             centerTitle: true,
//             elevation: 0,
//           ),
//           body: _isLoadingMasterData
//               ? const Center(child: CircularProgressIndicator())
//               : SingleChildScrollView(
//                   // padding: const EdgeInsets.all(16.0),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // SECTION 1: BASIC INFORMATION
//                         RoomSectionCardWidget(
//                           title: 'Basic Details',
//                           icon: Icons.info_outline,
//                           children: [
//                             TextFormField(
//                               controller: _nameController,
//                               enabled: !isSubmitting,
//                               decoration: _buildInputDecoration(
//                                 labelText: 'Room Name / Title',
//                                 hintText: 'e.g. Cozy Deluxe Room 101',
//                                 prefixIcon: Icons.meeting_room_outlined,
//                               ),
//                               validator: (v) => v == null || v.trim().isEmpty
//                                   ? 'Please enter room name'
//                                   : null,
//                             ),
//                             const SizedBox(height: 12),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: TextFormField(
//                                     controller: _roomNumberController,
//                                     enabled: !isSubmitting && !_isEditing,
//                                     decoration: _buildInputDecoration(
//                                       labelText: 'Room Number',
//                                       hintText: '101',
//                                       prefixIcon: Icons.tag,
//                                     ),
//                                     validator: (v) =>
//                                         v == null || v.trim().isEmpty
//                                         ? 'Required'
//                                         : null,
//                                     keyboardType: TextInputType.text,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: TextFormField(
//                                     controller: _floorController,
//                                     enabled: !isSubmitting,
//                                     decoration: _buildInputDecoration(
//                                       labelText: 'Floor',
//                                       hintText: '1st Floor',
//                                       prefixIcon: Icons.layers_outlined,
//                                     ),
//                                     validator: (v) =>
//                                         v == null || v.trim().isEmpty
//                                         ? 'Required'
//                                         : null,
//                                     keyboardType: TextInputType.text,
//                                   ),
//                                 ),
//                                                               ],
//                             ),
//                             const SizedBox(height: 12),
//                             DropdownButtonFormField<String>(
//                               value: _selectedRoomType,
//                               decoration: _buildInputDecoration(
//                                 labelText: 'Room Type',
//                                 prefixIcon: Icons.category_outlined,
//                               ),
//                               items: _roomTypes
//                                   .map(
//                                     (type) => DropdownMenuItem<String>(
//                                       value: type['id'] as String,
//                                       child: Text(type['name'] as String),
//                                     ),
//                                   )
//                                   .toList(),
//                               onChanged: isSubmitting
//                                   ? null
//                                   : (v) =>
//                                         setState(() => _selectedRoomType = v),
//                               validator: (v) => v == null || v.isEmpty
//                                   ? 'Please select room type'
//                                   : null,
//                             ),
//                             const SizedBox(height: 12),
//                             TextFormField(
//                               controller: _sqftController,
//                               enabled: !isSubmitting && !_isEditing,
//                               keyboardType: TextInputType.number,
//                               decoration: _buildInputDecoration(
//                                 labelText: 'Room Sqft',
//                                 hintText: 'e.g. 450',
//                                 prefixIcon: Icons.straighten_outlined,
//                               ),
//                               validator: (v) => v == null || v.trim().isEmpty ? 'Enter room square footage' : null,
//                             ),
//                           ],
//
//                           ),
//                         // SECTION 2: PRICING
//                         RoomSectionCardWidget(
//                           title: 'Pricing',
//                           icon: Icons.payments_outlined,
//                           children: [
//                             TextFormField(
//                               controller: _priceController,
//                               enabled: !isSubmitting,
//                               keyboardType: TextInputType.number,
//                               decoration: _buildInputDecoration(
//                                 labelText: 'Price / Month',
//                                 hintText: 'e.g. 300000',
//                                 prefixIcon: Icons.payments_outlined,
//                                 suffixText: 'MMK',
//                               ),
//                               validator: (v) => v == null || v.trim().isEmpty
//                                   ? 'Enter price in MMK'
//                                   : null,
//                             ),
//                           ],
//                         ),
//
//                         // SECTION 3: CAPACITY
//                         RoomSectionCardWidget(
//                           title: 'Capacity',
//                           icon: Icons.group_outlined,
//                           children: [
//                             CounterSelectorWidget(
//                               label: 'Max Guests Allowed',
//                               icon: Icons.group_outlined,
//                               value: _maxGuests,
//                               enabled: !isSubmitting,
//                               onChanged: (val) =>
//                                   setState(() => _maxGuests = val),
//                             ),
//                             const SizedBox(height: 12),
//                             CounterSelectorWidget(
//                               label: 'Number of Bedrooms',
//                               icon: Icons.king_bed_outlined,
//                               value: _numberBedrooms,
//                               minValue: 0,
//                               enabled: !isSubmitting,
//                               onChanged: (val) =>
//                                   setState(() => _numberBedrooms = val),
//                             ),
//                           ],
//                         ),
//
//                         // SECTION 3: LOCATION & DESCRIPTION
//                         RoomSectionCardWidget(
//                           title: 'Location & Description',
//                           icon: Icons.location_on_outlined,
//                           children: [
//                             TextFormField(
//                               controller: _locationController,
//                               enabled: !isSubmitting,
//                               minLines: 2,
//                               maxLines: 3,
//                               decoration: _buildInputDecoration(
//                                 labelText: 'Location / Address',
//                                 prefixIcon: Icons.place_outlined,
//                                 alignLabelWithHint: true,
//                               ),
//                               validator: (v) => v == null || v.trim().isEmpty
//                                   ? 'Please enter location'
//                                   : null,
//                               keyboardType: TextInputType.streetAddress,
//                             ),
//                             const SizedBox(height: 12),
//                             TextFormField(
//                               controller: _latController,
//                               enabled: !isSubmitting,
//                               keyboardType:
//                                   const TextInputType.numberWithOptions(
//                                     decimal: true,
//                                     signed: true,
//                                   ),
//                               decoration: _buildInputDecoration(
//                                 labelText: 'Latitude',
//                                 hintText: '16.8409',
//                                 prefixIcon: Icons.map_outlined,
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             TextFormField(
//                               controller: _lngController,
//                               enabled: !isSubmitting,
//                               keyboardType:
//                                   const TextInputType.numberWithOptions(
//                                     decimal: true,
//                                     signed: true,
//                                   ),
//                               decoration: _buildInputDecoration(
//                                 labelText: 'Longitude',
//                                 hintText: '96.1735',
//                                 prefixIcon: Icons.explore_outlined,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: InkWell(
//                                 onTap: _navigateToUserGuidance,
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 6.0,
//                                     horizontal: 4.0,
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Icon(
//                                         Icons.help_outline_rounded,
//                                         size: 16,
//                                         color: primaryColor,
//                                       ),
//                                       const SizedBox(width: 6),
//                                       Text(
//                                         'How to find Latitude & Longitude?',
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w600,
//                                           color: primaryColor,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             TextFormField(
//                               controller: _descriptionController,
//                               enabled: !isSubmitting,
//                               minLines: 5,
//                               maxLines: 8,
//                               decoration: _buildInputDecoration(
//                                 labelText: 'Description (Optional)',
//                                 hintText: 'Enter room details, rules, amenities description...',
//                                 prefixIcon: Icons.description_outlined,
//                                 alignLabelWithHint: true,
//                               ),
//                               keyboardType: TextInputType.multiline,
//                             ),
//                           ],
//                         ),
//
//                         // SECTION 4: AMENITIES
//                         RoomSectionCardWidget(
//                           title: 'Amenities',
//                           icon: Icons.star_outline,
//                           children: [
//                             RoomAmenitiesSelectorWidget(
//                               amenitiesList: _amenitiesList,
//                               selectedAmenityIds: _selectedAmenityIds,
//                               isSubmitting: isSubmitting,
//                               onAmenitySelected: (amenityId) {
//                                 setState(() {
//                                   if (_selectedAmenityIds.contains(amenityId)) {
//                                     _selectedAmenityIds.remove(amenityId);
//                                   } else {
//                                     _selectedAmenityIds.add(amenityId);
//                                   }
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//
//                         // SECTION 5: GALLERY IMAGES
//                         RoomSectionCardWidget(
//                           title: 'Room Photos',
//                           icon: Icons.photo_library_outlined,
//                           children: [
//                             RoomPhotoSelectorWidget(
//                               existingImages: _existingImages,
//                               selectedImages: _selectedImages,
//                               isSubmitting: isSubmitting,
//                               onPickImages: _pickImages,
//                               onRemoveExistingImage: (index) {
//                                 setState(() {
//                                   _existingImages.removeAt(index);
//                                 });
//                               },
//                               onRemoveSelectedImage: (index) {
//                                 setState(() {
//                                   _selectedImages.removeAt(index);
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(height: 12),
//
//                         // SUBMIT BUTTON
//                         Container(
//                           width: double.infinity,
//                           height: 56,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: primaryColor.withValues(alpha: 0.3),
//                                 blurRadius: 12,
//                                 offset: const Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: primaryColor,
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               elevation: 0,
//                             ),
//                             onPressed: isSubmitting ? null : _submitForm,
//                             child: isSubmitting
//                                 ? const CircularProgressIndicator(
//                                     color: Colors.white,
//                                   )
//                                 : Text(
//                                     _isEditing
//                                         ? 'Update Room Listing'
//                                         : 'Create Room Listing',
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       letterSpacing: 0.5,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                       ],
//                     ),
//                   ),
//                 ),
//         );
//       },
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../../data/services/snack_shower.dart';
// import '../../../di/di.dart';
// import '../../../domain/domain.dart';
// import '../../helpers/image_helper/image_kit_helper.dart';
// import '../../presentation.dart';
// import 'widgets/counter_selector_widget.dart';
// import 'widgets/room_photo_selector_widget.dart';
// import 'widgets/room_amenities_selector_widget.dart';
//
// class AddEditRoomScreen extends StatefulWidget {
//   static const String routeName = 'add-edit-room';
//   static const String routePath = '/add-edit-room';
//
//   final RoomEntity? room;
//
//   const AddEditRoomScreen({super.key, this.room});
//
//   @override
//   State<AddEditRoomScreen> createState() => _AddEditRoomScreenState();
// }
//
// class _AddEditRoomScreenState extends State<AddEditRoomScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker _picker = ImagePicker();
//   final ISnackShower _snackShower = inject<ISnackShower>();
//
//   late final TextEditingController _nameController;
//   late final TextEditingController _roomNumberController;
//   late final TextEditingController _floorController;
//   late final TextEditingController _priceController;
//   late final TextEditingController _locationController;
//   late final TextEditingController _descriptionController;
//   late final TextEditingController _sqftController;
//   late final TextEditingController _latController;
//   late final TextEditingController _lngController;
//
//   int _maxGuests = 1;
//   int _numberBedrooms = 1;
//   String? _selectedRoomType;
//   final String _selectedStatus = 'available';
//
//   final List<String> _selectedAmenityIds = [];
//   final List<RoomImageEntity> _existingImages = [];
//   final List<XFile> _selectedImages = [];
//   bool _isUploading = false;
//   bool _isLoadingMasterData = true;
//
//   List<Map<String, dynamic>> _roomTypes = [];
//   List<Map<String, dynamic>> _amenitiesList = [];
//
//   bool get _isEditing => widget.room != null;
//
//   @override
//   void initState() {
//     super.initState();
//     final r = widget.room;
//     _nameController = TextEditingController(text: r?.name ?? '');
//     _roomNumberController = TextEditingController(text: r?.roomNumber ?? '');
//     _floorController = TextEditingController(text: r?.floor ?? '');
//     _priceController = TextEditingController(
//       text: r?.pricePerMonth.toString() ?? '',
//     );
//     _locationController = TextEditingController(text: r?.location ?? '');
//     _descriptionController = TextEditingController(text: r?.description ?? '');
//     _sqftController = TextEditingController(text: r?.roomSqft.toString() ?? '');
//     _latController = TextEditingController(text: r?.latitude?.toString() ?? '');
//     _lngController = TextEditingController(
//       text: r?.longitude?.toString() ?? '',
//     );
//
//     if (r != null) {
//       _selectedRoomType = r.roomTypeId;
//       _maxGuests = r.maxGuests;
//       _numberBedrooms = r.numberBedrooms;
//       _selectedAmenityIds.addAll(r.amenityIds);
//       _existingImages.addAll(r.images);
//     }
//
//     _loadMasterData();
//   }
//
//   Future<void> _loadMasterData() async {
//     try {
//       final repo = inject<RoomRepository>();
//       final types = await repo.getRoomTypes();
//       final amenities = await repo.getAmenities();
//
//       if (mounted) {
//         setState(() {
//           _roomTypes = types;
//           _amenitiesList = amenities;
//           if (_selectedRoomType == null && _roomTypes.isNotEmpty) {
//             _selectedRoomType = _roomTypes.first['id'] as String;
//           }
//           _isLoadingMasterData = false;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => _isLoadingMasterData = false);
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _roomNumberController.dispose();
//     _floorController.dispose();
//     _priceController.dispose();
//     _locationController.dispose();
//     _descriptionController.dispose();
//     _sqftController.dispose();
//     _latController.dispose();
//     _lngController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _pickImages() async {
//     final List<XFile> pickedFiles = await _picker.pickMultiImage(
//       imageQuality: 80,
//     );
//     if (pickedFiles.isNotEmpty) {
//       setState(() {
//         _selectedImages.addAll(pickedFiles);
//       });
//     }
//   }
//
//   void _navigateToUserGuidance() {
//     context.push(UserGuidancePage.routePath);
//   }
//
//   Future<void> _submitForm() async {
//     final authUser = context.read<AuthenticationCubit>().user;
//     if (authUser == null) {
//       _snackShower.error(context: context, message: 'User session not found.');
//       return;
//     }
//
//     if (!_formKey.currentState!.validate()) return;
//     if (_selectedRoomType == null || _selectedRoomType!.isEmpty) {
//       _snackShower.error(
//         context: context,
//         message: 'Please select a room type.',
//       );
//       return;
//     }
//
//     FocusScope.of(context).unfocus();
//     setState(() => _isUploading = true);
//
//     List<RoomImageEntity> finalImages = List.from(_existingImages);
//
//     try {
//       final roomId =
//           widget.room?.id ?? DateTime.now().millisecondsSinceEpoch.toString();
//
//       if (_selectedImages.isNotEmpty) {
//         final uploadedUrls = await ImageKitHelper.uploadImages(
//           localFiles: _selectedImages,
//           ownerId: authUser.id,
//           roomId: roomId,
//         );
//         for (var url in uploadedUrls) {
//           finalImages.add(
//             RoomImageEntity(
//               id: DateTime.now().microsecondsSinceEpoch.toString(),
//               roomId: roomId,
//               imageUrl: url,
//               isPrimary: finalImages.isEmpty,
//             ),
//           );
//         }
//       }
//
//       final roomEntity = RoomEntity(
//         id: roomId,
//         ownerId: authUser.id,
//         roomTypeId: _selectedRoomType!,
//         roomNumber: _roomNumberController.text.trim(),
//         name: _nameController.text.trim(),
//         floor: _floorController.text.trim(),
//         maxGuests: _maxGuests,
//         pricePerMonth: double.tryParse(_priceController.text.trim()) ?? 0.0,
//         location: _locationController.text.trim(),
//         description: _descriptionController.text.trim().isEmpty
//             ? null
//             : _descriptionController.text.trim(),
//         numberBedrooms: _numberBedrooms,
//         roomSqft: double.tryParse(_sqftController.text.trim()) ?? 0.0,
//         amenityIds: _selectedAmenityIds,
//         images: finalImages,
//         latitude: double.tryParse(_latController.text.trim()),
//         longitude: double.tryParse(_lngController.text.trim()),
//         status: widget.room?.status ?? _selectedStatus,
//         createdAt: widget.room?.createdAt,
//       );
//
//       if (mounted) {
//         if (!_isEditing) {
//           await context.read<RoomCubit>().createRoom(roomEntity);
//         } else {
//           await context.read<RoomCubit>().updateRoom(roomEntity);
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         _snackShower.error(context: context, message: 'Error saving room: $e');
//       }
//     } finally {
//       if (mounted) setState(() => _isUploading = false);
//     }
//   }
//
//   InputDecoration _buildInputDecoration({
//     required String labelText,
//     required IconData prefixIcon,
//     String? hintText,
//     String? suffixText,
//     bool alignLabelWithHint = false,
//   }) {
//     final theme = Theme.of(context);
//
//     return InputDecoration(
//       labelText: labelText,
//       hintText: hintText,
//       suffixText: suffixText,
//       alignLabelWithHint: alignLabelWithHint,
//       labelStyle: const TextStyle(fontSize: 14),
//       hintStyle: const TextStyle(fontSize: 13),
//       suffixStyle: const TextStyle(fontSize: 13),
//       isDense: true,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//
//       // Force icon bounds to align at top left for multiline inputs
//       prefixIconConstraints: alignLabelWithHint
//           ? const BoxConstraints(minWidth: 40, minHeight: 0)
//           : null,
//
//       prefixIcon: alignLabelWithHint
//           ? Padding(
//         // Push down slightly from top to align with first line of text
//         padding: const EdgeInsets.only(top: 12, left: 12, right: 8),
//         child: Icon(
//           prefixIcon,
//           color: theme.primaryColor.withValues(alpha: 0.7),
//           size: 18,
//         ),
//       )
//           : Icon(
//         prefixIcon,
//         color: theme.primaryColor.withValues(alpha: 0.7),
//         size: 18,
//       ),
//       filled: true,
//       fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
//         alpha: 0.3,
//       ),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide(
//           color: theme.colorScheme.outline.withValues(alpha: 0.4),
//           width: 1,
//         ),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide(
//           color: theme.colorScheme.outline.withValues(alpha: 0.3),
//           width: 1,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide(color: theme.colorScheme.error, width: 1),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide(color: theme.colorScheme.error, width: 1.5),
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader({required String title, required IconData icon}) {
//     final theme = Theme.of(context);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             Icon(icon, size: 18, color: theme.primaryColor),
//             const SizedBox(width: 8),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//                 color: theme.colorScheme.onSurface,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 6),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = Theme.of(context).primaryColor;
//
//     return BlocConsumer<RoomCubit, RoomState>(
//       listener: (context, state) {
//         if (state is RoomSuccess) {
//           _snackShower.success(context: context, message: state.message);
//           context.pop(true);
//         } else if (state is RoomFailure) {
//           _snackShower.error(context: context, message: state.message);
//         }
//       },
//       builder: (context, state) {
//         final isSubmitting =
//             state is RoomLoading || _isUploading || _isLoadingMasterData;
//
//         return GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Scaffold(
//             backgroundColor: Theme.of(context).colorScheme.surface,
//             appBar: AppBar(
//               title: Text(
//                 _isEditing ? 'Edit Room Listing' : 'Add New Room',
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               centerTitle: true,
//               elevation: 0,
//             ),
//             body: _isLoadingMasterData
//                 ? const Center(child: CircularProgressIndicator())
//                 : SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // SECTION 1: BASIC DETAILS
//                     _buildSectionHeader(
//                       title: 'Basic Details',
//                       icon: Icons.info_outline,
//                     ),
//                     TextFormField(
//                       controller: _nameController,
//                       enabled: !isSubmitting,
//                       style: const TextStyle(fontSize: 14),
//                       decoration: _buildInputDecoration(
//                         labelText: 'Room Name / Title',
//                         hintText: 'e.g. Cozy Deluxe Room 101',
//                         prefixIcon: Icons.meeting_room_outlined,
//                       ),
//                       validator: (v) => v == null || v.trim().isEmpty
//                           ? 'Please enter room name'
//                           : null,
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextFormField(
//                             controller: _roomNumberController,
//                             enabled: !isSubmitting && !_isEditing,
//                             style: const TextStyle(fontSize: 14),
//                             decoration: _buildInputDecoration(
//                               labelText: 'Room Number',
//                               hintText: '101',
//                               prefixIcon: Icons.tag,
//                             ),
//                             validator: (v) => v == null || v.trim().isEmpty
//                                 ? 'Required'
//                                 : null,
//                             keyboardType: TextInputType.text,
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         Expanded(
//                           child: TextFormField(
//                             controller: _floorController,
//                             enabled: !isSubmitting,
//                             style: const TextStyle(fontSize: 14),
//                             decoration: _buildInputDecoration(
//                               labelText: 'Floor',
//                               hintText: '1st Floor',
//                               prefixIcon: Icons.layers_outlined,
//                             ),
//                             validator: (v) => v == null || v.trim().isEmpty
//                                 ? 'Required'
//                                 : null,
//                             keyboardType: TextInputType.text,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     DropdownButtonFormField<String>(
//                       value: _selectedRoomType,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Theme.of(context).colorScheme.onSurface,
//                       ),
//                       decoration: _buildInputDecoration(
//                         labelText: 'Room Type',
//                         prefixIcon: Icons.category_outlined,
//                       ),
//                       items: _roomTypes
//                           .map(
//                             (type) => DropdownMenuItem<String>(
//                           value: type['id'] as String,
//                           child: Text(
//                             type['name'] as String,
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                         ),
//                       )
//                           .toList(),
//                       onChanged: isSubmitting
//                           ? null
//                           : (v) => setState(() => _selectedRoomType = v),
//                       validator: (v) => v == null || v.isEmpty
//                           ? 'Please select room type'
//                           : null,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: _sqftController,
//                       enabled: !isSubmitting && !_isEditing,
//                       style: const TextStyle(fontSize: 14),
//                       keyboardType: TextInputType.number,
//                       decoration: _buildInputDecoration(
//                         labelText: 'Room Sqft',
//                         hintText: 'e.g. 450',
//                         prefixIcon: Icons.straighten_outlined,
//                       ),
//                       validator: (v) => v == null || v.trim().isEmpty
//                           ? 'Enter room square footage'
//                           : null,
//                     ),
//                     const SizedBox(height: 12),
//
//                     // SECTION 2: PRICING
//                     _buildSectionHeader(
//                       title: 'Pricing',
//                       icon: Icons.payments_outlined,
//                     ),
//                     TextFormField(
//                       controller: _priceController,
//                       enabled: !isSubmitting,
//                       style: const TextStyle(fontSize: 14),
//                       keyboardType: TextInputType.number,
//                       decoration: _buildInputDecoration(
//                         labelText: 'Price / Month',
//                         hintText: 'e.g. 300000',
//                         prefixIcon: Icons.payments_outlined,
//                         suffixText: 'MMK',
//                       ),
//                       validator: (v) => v == null || v.trim().isEmpty
//                           ? 'Enter price in MMK'
//                           : null,
//                     ),
//                     const SizedBox(height: 12),
//
//                     // SECTION 3: CAPACITY
//                     _buildSectionHeader(
//                       title: 'Capacity',
//                       icon: Icons.group_outlined,
//                     ),
//                     const SizedBox(height: 4),
//                     CounterSelectorWidget(
//                       label: 'Max Guests Allowed',
//                       icon: Icons.group_outlined,
//                       value: _maxGuests,
//                       enabled: !isSubmitting,
//                       onChanged: (val) => setState(() => _maxGuests = val),
//                     ),
//                     const SizedBox(height: 12),
//                     CounterSelectorWidget(
//                       label: 'Number of Bedrooms',
//                       icon: Icons.king_bed_outlined,
//                       value: _numberBedrooms,
//                       minValue: 0,
//                       enabled: !isSubmitting,
//                       onChanged: (val) =>
//                           setState(() => _numberBedrooms = val),
//                     ),
//                     const SizedBox(height: 12),
//
//                     // SECTION 4: LOCATION & DESCRIPTION
//                     _buildSectionHeader(
//                       title: 'Location & Description',
//                       icon: Icons.location_on_outlined,
//                     ),
//                     TextFormField(
//                       controller: _locationController,
//                       enabled: !isSubmitting,
//                       style: const TextStyle(fontSize: 14),
//                       minLines: 2,
//                       maxLines: 3,
//                       decoration: _buildInputDecoration(
//                         labelText: 'Location / Address',
//                         hintText: 'Enter location',
//                         prefixIcon: Icons.place_outlined,
//                       ).copyWith(
//                         alignLabelWithHint: false, // Forces label to stay centered on load
//                         prefixIcon: const Icon(Icons.place_outlined),
//                         prefixIconConstraints: const BoxConstraints(
//                           minWidth: 48,
//                           minHeight: 48, // Matches default height to keep icon vertically centered
//                         ),
//                       ),
//                       validator: (v) => v == null || v.trim().isEmpty
//                           ? 'Please enter location'
//                           : null,
//                       keyboardType: TextInputType.streetAddress,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: _latController,
//                       enabled: !isSubmitting,
//                       style: const TextStyle(fontSize: 14),
//                       keyboardType: const TextInputType.numberWithOptions(
//                         decimal: true,
//                         signed: true,
//                       ),
//                       decoration: _buildInputDecoration(
//                         labelText: 'Latitude',
//                         hintText: '16.8409',
//                         prefixIcon: Icons.map_outlined,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: _lngController,
//                       enabled: !isSubmitting,
//                       style: const TextStyle(fontSize: 14),
//                       keyboardType: const TextInputType.numberWithOptions(
//                         decimal: true,
//                         signed: true,
//                       ),
//                       decoration: _buildInputDecoration(
//                         labelText: 'Longitude',
//                         hintText: '96.1735',
//                         prefixIcon: Icons.explore_outlined,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     InkWell(
//                       onTap: _navigateToUserGuidance,
//                       borderRadius: BorderRadius.circular(8),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 2.0,
//                           horizontal: 2.0,
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               Icons.help_outline_rounded,
//                               size: 15,
//                               color: primaryColor,
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               'How to find Latitude & Longitude?',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: primaryColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: _descriptionController,
//                       enabled: !isSubmitting,
//                       style: const TextStyle(fontSize: 14),
//                       minLines: 4,
//                       maxLines: 6,
//                       decoration: _buildInputDecoration(
//                         labelText: 'Description (Optional)',
//                         hintText: 'Enter room details, rules, amenities description...',
//                         prefixIcon: Icons.description_outlined,
//                       ).copyWith(
//                         alignLabelWithHint: false, // Forces label to stay vertically centered in default state
//                         prefixIcon: const Icon(Icons.description_outlined),
//                         prefixIconConstraints: const BoxConstraints(
//                           minWidth: 48,
//                           minHeight: 48, // Keeps icon centered regardless of input box height
//                         ),
//                       ),
//                       keyboardType: TextInputType.multiline,
//                     ),
//                     const SizedBox(height: 12),
//
//                     // SECTION 5: AMENITIES
//                     _buildSectionHeader(
//                       title: 'Amenities',
//                       icon: Icons.star_outline,
//                     ),
//                     RoomAmenitiesSelectorWidget(
//                       amenitiesList: _amenitiesList,
//                       selectedAmenityIds: _selectedAmenityIds,
//                       isSubmitting: isSubmitting,
//                       onAmenitySelected: (amenityId) {
//                         setState(() {
//                           if (_selectedAmenityIds.contains(amenityId)) {
//                             _selectedAmenityIds.remove(amenityId);
//                           } else {
//                             _selectedAmenityIds.add(amenityId);
//                           }
//                         });
//                       },
//                     ),
//
//                     // SECTION 6: GALLERY IMAGES
//                     _buildSectionHeader(
//                       title: 'Room Photos',
//                       icon: Icons.photo_library_outlined,
//                     ),
//                     RoomPhotoSelectorWidget(
//                       existingImages: _existingImages,
//                       selectedImages: _selectedImages,
//                       isSubmitting: isSubmitting,
//                       onPickImages: _pickImages,
//                       onRemoveExistingImage: (index) {
//                         setState(() {
//                           _existingImages.removeAt(index);
//                         });
//                       },
//                       onRemoveSelectedImage: (index) {
//                         setState(() {
//                           _selectedImages.removeAt(index);
//                         });
//                       },
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     // SUBMIT BUTTON
//                     SizedBox(
//                       width: double.infinity,
//                       height: 52,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: primaryColor,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           elevation: 0,
//                         ),
//                         onPressed: isSubmitting ? null : _submitForm,
//                         child: isSubmitting
//                             ? const CircularProgressIndicator(
//                           color: Colors.white,
//                         )
//                             : Text(
//                           _isEditing
//                               ? 'Update Room Listing'
//                               : 'Create Room Listing',
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/services/snack_shower.dart';
import '../../../di/di.dart';
import '../../../domain/domain.dart';
import '../../helpers/image_helper/image_kit_helper.dart';
import '../../presentation.dart';
import 'widgets/counter_selector_widget.dart';
import 'widgets/room_amenities_selector_widget.dart';
import 'widgets/room_photo_selector_widget.dart';

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

  Future<void> _submitForm() async {
    final authUser = context.read<AuthenticationCubit>().user;
    if (authUser == null) {
      _snackShower.error(context: context, message: 'User session not found.');
      return;
    }

    if (!_formKey.currentState!.validate()) return;
    if (_selectedRoomType == null || _selectedRoomType!.isEmpty) {
      _snackShower.error(
        context: context,
        message: 'Please select a room type.',
      );
      return;
    }

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
        fontSize: 14,
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      prefixIconConstraints: alignLabelWithHint
          ? const BoxConstraints(minWidth: 44, minHeight: 0)
          : const BoxConstraints(minWidth: 44, minHeight: 44),
      prefixIcon: alignLabelWithHint
          ? Padding(
        padding: const EdgeInsets.only(top: 14, left: 12, right: 8),
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
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: theme.colorScheme.surface,
            ),
            body: _isLoadingMasterData
                ? const Center(child: CircularProgressIndicator.adaptive())
                : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SECTION 1: BASIC DETAILS
                    _buildSectionHeader(
                      title: 'Basic Details',
                      icon: Icons.info_outline,
                    ),
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
                                validator: (v) => v == null || v.trim().isEmpty
                                    ? 'Required'
                                    : null,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            const SizedBox(width: 12),
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
                                validator: (v) => v == null || v.trim().isEmpty
                                    ? 'Required'
                                    : null,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: _selectedRoomType,
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.colorScheme.onSurface,
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
                          validator: (v) => v == null || v.isEmpty
                              ? 'Please select room type'
                              : null,
                        ),
                        const SizedBox(height: 12),
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
                      ],
                    ),
                    const SizedBox(height: 20),

                    // SECTION 2: PRICING & CAPACITY
                    _buildSectionHeader(
                      title: 'Pricing & Capacity',
                      icon: Icons.payments_outlined,
                    ),
                    _buildSectionCard(
                      children: [
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
                        const SizedBox(height: 12),
                        CounterSelectorWidget(
                          label: 'Max Guests Allowed',
                          icon: Icons.group_outlined,
                          value: _maxGuests,
                          enabled: !isSubmitting,
                          onChanged: (val) => setState(() => _maxGuests = val),
                        ),
                        const SizedBox(height: 12),
                        CounterSelectorWidget(
                          label: 'Number of Bedrooms',
                          icon: Icons.king_bed_outlined,
                          value: _numberBedrooms,
                          minValue: 0,
                          enabled: !isSubmitting,
                          onChanged: (val) =>
                              setState(() => _numberBedrooms = val),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // SECTION 3: LOCATION & DESCRIPTION
                    _buildSectionHeader(
                      title: 'Location & Description',
                      icon: Icons.location_on_outlined,
                    ),
                    _buildSectionCard(
                      children: [
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
                                keyboardType:
                                const TextInputType.numberWithOptions(
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
                                keyboardType:
                                const TextInputType.numberWithOptions(
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
                                    color: primaryColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'How to find Latitude & Longitude?',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
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
                    const SizedBox(height: 20),

                    // SECTION 4: AMENITIES
                    _buildSectionHeader(
                      title: 'Amenities',
                      icon: Icons.star_outline,
                    ),
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
                    const SizedBox(height: 20),

                    // SECTION 5: GALLERY IMAGES
                    _buildSectionHeader(
                      title: 'Room Photos',
                      icon: Icons.photo_library_outlined,
                    ),
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
                    const SizedBox(height: 24),

                    // SUBMIT BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        onPressed: isSubmitting ? null : _submitForm,
                        child: isSubmitting
                            ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 2.5,
                            valueColor:
                            AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                            : Text(
                          _isEditing
                              ? 'Update Room Listing'
                              : 'Create Room Listing',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}