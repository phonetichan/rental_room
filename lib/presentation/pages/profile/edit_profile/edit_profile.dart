import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/services/image_kit.dart';
import '../../../../data/services/snack_shower.dart';
import '../../../../di/di.dart';
import '../../../../domain/entity/user/user_entity.dart';
import '../../../../domain/usecase/user/update_user_profile_param.dart';
import '../../../blocs/authentication_cubit/authentication_cubit.dart';
import 'cubit/edit_profile_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = 'edit-profile';
  static const String routePath = '/edit-profile';

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final ISnackShower _snackShower = inject<ISnackShower>();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  XFile? _selectedImageFile;
  String? _currentImageUrl;
  bool _isUploadingImage = false;
  UserEntity? _currentUser;

  @override
  void initState() {
    super.initState();

    _currentUser = context.read<AuthenticationCubit>().user;
    _nameController = TextEditingController(text: _currentUser?.name ?? '');
    _phoneController = TextEditingController(text: _currentUser?.phoneNumber ?? '');
    _currentImageUrl = _currentUser?.image;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _showImagePickerModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_rounded, color: Colors.blue),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  _pickImage(ImageSource.gallery);
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded, color: Colors.teal),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  _pickImage(ImageSource.camera);
                },
              ),
              if (_currentImageUrl != null || _selectedImageFile != null) ...[
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                  title: const Text(
                    'Remove Photo',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    setState(() {
                      _selectedImageFile = null;
                      _currentImageUrl = null;
                    });
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 800,
      );

      if (pickedFile != null && mounted) {
        setState(() {
          _selectedImageFile = pickedFile;
        });
      }
    } catch (e) {
      if (mounted) {
        _snackShower.error(context: context, message: 'Failed to pick image: $e');
      }
    }
  }

  Future<void> _submitForm() async {
    if (_currentUser == null) {
      _snackShower.error(context: context, message: 'User session not found.');
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    String? finalImageUrl = _currentImageUrl;

    if (_selectedImageFile != null) {
      setState(() => _isUploadingImage = true);

      try {
        finalImageUrl = await ImageKitHelper.uploadProfileImage(
          localFile: _selectedImageFile!,
          userId: _currentUser!.id,
        );
      } catch (e) {
        if (mounted) {
          setState(() => _isUploadingImage = false);
          _snackShower.error(context: context, message: 'Failed to upload profile image: $e');
        }
        return;
      } finally {
        if (mounted) setState(() => _isUploadingImage = false);
      }
    }

    if (mounted) {
      final updatedUser = _currentUser!.copyWith(
        name: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        image: finalImageUrl,
      );

      final params = UpdateUserProfileParams(user: updatedUser);
      context.read<EditProfileCubit>().updateUserProfile(params);
    }
  }

  ImageProvider? _getAvatarImage() {
    if (_selectedImageFile != null) {
      return FileImage(File(_selectedImageFile!.path));
    }
    if (_currentImageUrl != null && _currentImageUrl!.isNotEmpty) {
      return NetworkImage(
        ImageKitHelper.getUrl(_currentImageUrl!, width: 250, quality: 85),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: const Center(
          child: Text('Unable to load user profile. Please re-login.'),
        ),
      );
    }

    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          if (context.mounted) {
            _snackShower.success(context: context, message: 'Profile updated successfully!');
            setState(() {
              _currentUser = state.user;
              _currentImageUrl = state.user.image;
              _selectedImageFile = null;
            });
          }
        } else if (state is EditProfileFailure) {
          if (context.mounted) {
            _snackShower.error(context: context, message: state.message);
          }
        }
      },
      builder: (context, state) {
        final isSubmitting = state is EditProfileLoading || _isUploadingImage;
        final avatarImageProvider = _getAvatarImage();

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              title: const Text(
                'Edit Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // AVATAR IMAGE PICKER
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 54,
                        backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.12),
                        backgroundImage: avatarImageProvider,
                        child: avatarImageProvider == null
                            ? Icon(
                          Icons.person_rounded,
                          size: 60,
                          color: Theme.of(context).primaryColor,
                        )
                            : null,
                      ),
                      Material(
                        color: Theme.of(context).primaryColor,
                        shape: const CircleBorder(),
                        elevation: 3,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: isSubmitting ? null : _showImagePickerModal,
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // PROFILE EDIT FORM
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          enabled: !isSubmitting,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            hintText: 'John Doe',
                            prefixIcon: const Icon(Icons.person_outline_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          validator: (v) => v == null || v.trim().isEmpty ? 'Please enter your name' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _phoneController,
                          enabled: !isSubmitting,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: '+1 234 567 890',
                            prefixIcon: const Icon(Icons.phone_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          validator: (v) => v == null || v.trim().isEmpty ? 'Please enter your phone number' : null,
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            onPressed: isSubmitting ? null : _submitForm,
                            child: isSubmitting
                                ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                                : const Text(
                              'Save Changes',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
