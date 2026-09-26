import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/services/snack_shower.dart';
import '../../../../di/di.dart';
import '../../../../domain/domain.dart';
import '../../../blocs/authentication_cubit/authentication_cubit.dart';
import '../../setting_pages/terms_n_conditions.dart';
import 'cubit/sign_up_cubit.dart';

class SignUpPage extends StatefulWidget {
  static const String routePath = '/sign-up';
  static const String routeName = 'sign-up';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _imageController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();
  final ISnackShower _snackShower = inject<ISnackShower>();

  UserRole _selectedRole = UserRole.tenant;
  bool _acceptedTerms = false;
  bool _obscurePassword = true;
  bool _obscureRetypePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _imageController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }

  void _onSignUpPressed() {
    if (!_acceptedTerms) {
      _snackShower.error(
        context: context,
        message: 'Please accept the Terms & Conditions to proceed.',
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      context.read<SignUpCubit>().signUp(
            name: _nameController.text,
            email: _emailController.text,
            phoneNumber: _phoneController.text,
            image: _imageController.text.trim().isNotEmpty
                ? _imageController.text.trim()
                : null,
            password: _passwordController.text,
            role: _selectedRole,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        elevation: 0,
      ),
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (user) {
              context.read<AuthenticationCubit>().authenticateUser(user: user);

              _snackShower.success(
                context: context,
                message: 'Account created as ${_selectedRole.value.toUpperCase()}!',
              );

              context.go('/');
            },
            failure: (error) {
              _snackShower.error(
                context: context,
                message: error,
              );
            },
            orElse: () {},
          );
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Join Rental Room',
                    style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Select your role and fill in your details to get started',
                    style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 24),

                  // ROLE SELECTOR
                  Text(
                    'I am registering as:',
                    style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _RoleCard(
                          title: 'Tenant',
                          subtitle: 'Search & rent rooms',
                          icon: Icons.person_outline_rounded,
                          isSelected: _selectedRole == UserRole.tenant,
                          onTap: () {
                            setState(() {
                              _selectedRole = UserRole.tenant;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _RoleCard(
                          title: 'Owner',
                          subtitle: 'List & manage rooms',
                          icon: Icons.real_estate_agent_outlined,
                          isSelected: _selectedRole == UserRole.owner,
                          onTap: () {
                            setState(() {
                              _selectedRole = UserRole.owner;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // FULL NAME FIELD
                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'John Doe',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // EMAIL FIELD
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'john@example.com',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value.trim())) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // PHONE NUMBER FIELD
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: '+1 234 567 8900',
                      prefixIcon: const Icon(Icons.phone_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (value.trim().length < 7) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // PASSWORD FIELD
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '••••••••',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // RE-TYPE PASSWORD FIELD
                  TextFormField(
                    controller: _retypePasswordController,
                    obscureText: _obscureRetypePassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _onSignUpPressed(),
                    decoration: InputDecoration(
                      labelText: 'Confirmed Password',
                      hintText: '••••••••',
                      prefixIcon: const Icon(Icons.lock_reset_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureRetypePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureRetypePassword = !_obscureRetypePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please re-type your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // TERMS & CONDITIONS CHECKBOX
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptedTerms,
                        onChanged: (val) {
                          setState(() {
                            _acceptedTerms = val ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _acceptedTerms = !_acceptedTerms;
                                });
                              },
                              child: Text(
                                'I agree to the ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark ? Colors.grey[300] : Colors.grey[800],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.push(TermsAndConditionsPage.routePath);
                              },
                              child: Text(
                                'Terms & Conditions',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _acceptedTerms = !_acceptedTerms;
                                });
                              },
                              child: Text(
                                ' and Privacy Policy',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark ? Colors.grey[300] : Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // SIGN UP BUTTON
                  BlocBuilder<SignUpCubit, SignUpState>(
                    builder: (context, state) {
                      final isLoading = state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );
                      return ElevatedButton(
                        onPressed: isLoading ? null : _onSignUpPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Sign Up as ${_selectedRole.value.toUpperCase()}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // ALREADY HAVE ACCOUNT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[700],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final isDark = theme.brightness == Brightness.dark;

    final cardBgColor = isSelected
        ? primaryColor.withValues(alpha: 0.12)
        : isDark
            ? theme.cardColor
            : Colors.grey.shade50;

    final cardBorderColor = isSelected
        ? primaryColor
        : isDark
            ? Colors.grey.shade800
            : Colors.grey.shade300;

    final textColor = isSelected
        ? primaryColor
        : isDark
            ? Colors.white
            : Colors.black87;

    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: cardBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? primaryColor : subTextColor,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: subTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
