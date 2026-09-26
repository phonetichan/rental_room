import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/services/snack_shower.dart';
import '../../../../di/di.dart';
import '../../../../domain/usecase/update_password_usecase.dart';
import '../../../blocs/authentication_cubit/authentication_cubit.dart';
import 'cubit/edit_password_cubit.dart';

class EditPasswordScreen extends StatefulWidget {
  static const String routeName = 'edit-password';
  static const String routePath = '/edit-password';

  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final _passwordFormKey = GlobalKey<FormState>();
  final ISnackShower _snackShower = inject<ISnackShower>();

  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  Future<void> _submitPasswordForm() async {
    final user = context.read<AuthenticationCubit>().user;
    if (user == null) {
      _snackShower.error(context: context, message: 'User session not found.');
      return;
    }

    if (!_passwordFormKey.currentState!.validate()) return;

    if (_newPasswordController.text != _confirmPasswordController.text) {
      _snackShower.error(context: context, message: 'New passwords do not match.');
      return;
    }

    FocusScope.of(context).unfocus();
    context.read<EditPasswordCubit>().updatePassword(
          UpdatePasswordParams(
            currentPassword: _currentPasswordController.text,
            newPassword: _newPasswordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditPasswordCubit, EditPasswordState>(
      listener: (context, state) {
        if (state is EditPasswordSuccess) {
          if (context.mounted) {
            _snackShower.success(context: context, message: state.message);
            _clearForm();
          }
        } else if (state is EditPasswordFailure) {
          if (context.mounted) {
            if (state.message.contains('re-authentication') ||
                state.message.contains('sign in again') ||
                state.message.contains('sensitive')) {
              _snackShower.info(context: context, message: state.message);
            } else {
              _snackShower.error(context: context, message: state.message);
            }
          }
        }
      },
      builder: (context, state) {
        final isSubmitting = state is EditPasswordLoading;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              title: const Text(
                'Update Password',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _passwordFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Changing your password will require you to log in again.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    // CURRENT PASSWORD
                    TextFormField(
                      controller: _currentPasswordController,
                      enabled: !isSubmitting,
                      obscureText: _obscureCurrentPassword,
                      decoration: InputDecoration(
                        labelText: 'Current Password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureCurrentPassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscureCurrentPassword = !_obscureCurrentPassword),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      validator: (v) => v == null || v.isEmpty ? 'Please enter current password' : null,
                    ),
                    const SizedBox(height: 16),

                    // NEW PASSWORD
                    TextFormField(
                      controller: _newPasswordController,
                      enabled: !isSubmitting,
                      obscureText: _obscureNewPassword,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        prefixIcon: const Icon(Icons.lock_reset_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureNewPassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Please enter new password';
                        if (v.length < 6) return 'Password must be at least 6 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // CONFIRM NEW PASSWORD
                    TextFormField(
                      controller: _confirmPasswordController,
                      enabled: !isSubmitting,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm New Password',
                        prefixIcon: const Icon(Icons.lock_reset_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Please confirm new password';
                        if (v != _newPasswordController.text) return 'Passwords do not match';
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // UPDATE PASSWORD BUTTON
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
                        onPressed: isSubmitting ? null : _submitPasswordForm,
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
                          'Update Password',
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
            ),
          ),
        );
      },
    );
  }
}
