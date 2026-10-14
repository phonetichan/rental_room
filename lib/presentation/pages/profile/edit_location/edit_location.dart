// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// // import '../../openstreetmap/location_picker_page.dart';
// //
// // class SelectLocationScreen extends StatefulWidget {
// //   static const String routeName = 'edit-location';
// //   static const String routePath = '/edit-location';
// //
// //   const SelectLocationScreen({super.key});
// //
// //   @override
// //   State<SelectLocationScreen> createState() => _SelectLocationScreenState();
// // }
// //
// // class _SelectLocationScreenState extends State<SelectLocationScreen> {
// //   final TextEditingController _latController = TextEditingController();
// //   final TextEditingController _lngController = TextEditingController();
// //
// //   @override
// //   void dispose() {
// //     _latController.dispose();
// //     _lngController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
// //           onPressed: () => context.pop(),
// //         ),
// //       ),
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
// //           child: Column(
// //             children: [
// //               const Spacer(),
// //               // Illustration/Graphic Placeholder
// //               Center(
// //                 child: Image.asset(
// //                   'assets/images/Group 2.png',
// //                   height: 220,
// //                   errorBuilder: (context, error, stackTrace) => Icon(
// //                     Icons.map_rounded,
// //                     size: 120,
// //                     color: Colors.deepPurple[200],
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 40),
// //               // Title text
// //               const Text(
// //                 'Hi, Nice to meet you !',
// //                 style: TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.black,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //               const SizedBox(height: 12),
// //               // Subtitle text
// //               Text(
// //                 'Choose your location to find property\naround you',
// //                 style: TextStyle(
// //                   fontSize: 15,
// //                   color: Colors.grey[600],
// //                   height: 1.4,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //               const Spacer(),
// //               // Select it manually button
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 54,
// //                 child: OutlinedButton(
// //                   onPressed: () async {
// //                     // Expect PickedLocation type returned from LocationPickerPage
// //                     final result = await context.push<PickedLocation>(LocationPickerPage.routePath);
// //
// //                     if (result != null && mounted) {
// //                       setState(() {
// //                         _latController.text = result.latLng.latitude.toString();
// //                         _lngController.text = result.latLng.longitude.toString();
// //                       });
// //
// //                       // Optional: If you want to return the picked location further up
// //                       // to a parent screen (like a form), pass it back via context.pop(result);
// //                     }
// //                   },
// //                   style: OutlinedButton.styleFrom(
// //                     foregroundColor: const Color(0xFF7F56D9),
// //                     side: const BorderSide(color: Color(0xFF7F56D9), width: 1.5),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(14),
// //                     ),
// //                   ),
// //                   child: const Text(
// //                     'Select it manually',
// //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 32),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // presentation/pages/profile/edit_location/edit_location.dart
// // presentation/pages/profile/edit_location/edit_location.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:latlong2/latlong.dart';
//
// // adjust these paths to your project
// import '../../../../data/services/snack_shower.dart';
// import '../../../../di/injector.dart';
// import '../../../../domain/domain.dart'; // UserEntity
// import '../../../blocs/authentication_cubit/authentication_cubit.dart';
// import '../../openstreetmap/location_widgets.dart'; // LocationField
// import '../../openstreetmap/picker_location.dart'; // the ONLY PickedLocation definition
// import 'cubit/location_cubit.dart';
//
// /// Profile -> Update Location.
// /// Tap the map card -> pick on map -> lat/lng fields auto-fill ->
// /// press "Update Location" -> saved to the user document.
// /// The user stays on this page after saving and sees a snackbar.
// class EditLocationScreen extends StatefulWidget {
//   static const String routeName = 'edit-location';
//   static const String routePath = '/edit-location';
//
//   const EditLocationScreen({super.key});
//
//   @override
//   State<EditLocationScreen> createState() => _EditLocationScreenState();
// }
//
// class _EditLocationScreenState extends State<EditLocationScreen> {
//   final _latController = TextEditingController();
//   final _lngController = TextEditingController();
//   final ISnackShower _snackShower = inject<ISnackShower>();
//
//   PickedLocation? _picked;
//   PickedLocation? _initial; // saved location, used to detect changes
//
//   /// True only after THIS screen pressed save. Prevents a stale
//   /// success/failure state left in LocationCubit from triggering
//   /// a snackbar as soon as the screen opens.
//   bool _submitted = false;
//
//   @override
//   void initState() {
//     super.initState();
//     final user = context.read<AuthenticationCubit>().user;
//     if (user != null && user.hasLocation) {
//       final point = LatLng(user.latitude!, user.longitude!);
//       final address = (user.address != null && user.address!.trim().isNotEmpty)
//           ? user.address!
//           : '${point.latitude.toStringAsFixed(6)}, ${point.longitude.toStringAsFixed(6)}';
//
//       _initial = PickedLocation(point, address);
//       _fill(_initial!);
//     }
//   }
//
//   @override
//   void dispose() {
//     _latController.dispose();
//     _lngController.dispose();
//     super.dispose();
//   }
//
//   /// Auto-fills the read-only lat/lng fields.
//   void _fill(PickedLocation loc) {
//     _picked = loc;
//     _latController.text = loc.latLng.latitude.toStringAsFixed(6);
//     _lngController.text = loc.latLng.longitude.toStringAsFixed(6);
//   }
//
//   void _onLocationChanged(PickedLocation loc) {
//     setState(() => _fill(loc));
//   }
//
//   /// Enabled only when a NEW location was picked.
//   bool get _canSave {
//     final p = _picked;
//     if (p == null) return false;
//     final i = _initial;
//     return i == null || i.latLng != p.latLng;
//   }
//
//   void _save() {
//     final user = context.read<AuthenticationCubit>().user;
//     final loc = _picked;
//     if (user == null || loc == null) return;
//
//     setState(() => _submitted = true);
//     context.read<LocationCubit>().updateLocation(
//       userId: user.id,
//       latitude: loc.latLng.latitude,
//       longitude: loc.latLng.longitude,
//       address: loc.address,
//     );
//   }
//
//   Future<void> _onSaved(UserEntity updatedUser) async {
//     await context.read<AuthenticationCubit>().authenticateUser(
//       user: updatedUser,
//     );
//     if (!mounted) return;
//
//     setState(() => _initial = _picked);
//
//     _snackShower.success(
//       context: context,
//       message: 'Location updated successfully',
//     );
//   }
//
//   InputDecoration _decoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       prefixIcon: const Icon(Icons.gps_fixed),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final address = _picked?.address ?? '';
//
//     return BlocListener<LocationCubit, LocationState>(
//       listener: (context, state) {
//         if (!_submitted) return; // ignore stale states
//
//         state.whenOrNull(
//           success: (updatedUser) {
//             setState(() => _submitted = false);
//             _onSaved(updatedUser);
//           },
//           failure: (error) {
//             setState(() => _submitted = false);
//             _snackShower.error(
//               context: context,
//               message: error,
//             );
//           },
//         );
//       },
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Update Location')),
//         body: SafeArea(
//           child: ListView(
//             padding: const EdgeInsets.all(16),
//             children: [
//               // ---- section header ----
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: theme.primaryColor.withValues(alpha: 0.1),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Icon(Icons.map_outlined,
//                         color: theme.primaryColor, size: 20),
//                   ),
//                   const SizedBox(width: 12),
//                   Text(
//                     'My Location',
//                     style: theme.textTheme.titleMedium
//                         ?.copyWith(fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//
//               // ---- section card ----
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: theme.cardColor,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withValues(alpha: 0.04),
//                       blurRadius: 12,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     // LocationField already shows the address under the map.
//                     LocationField(
//                       value: _picked,
//                       onChanged: _onLocationChanged,
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextFormField(
//                             controller: _latController,
//                             readOnly: true,
//                             decoration: _decoration('Latitude'),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: TextFormField(
//                             controller: _lngController,
//                             readOnly: true,
//                             decoration: _decoration('Longitude'),
//                           ),
//                         ),
//                       ],
//                     ),
//                     if (address.isEmpty && _picked == null) ...[
//                       const SizedBox(height: 12),
//                       Text(
//                         'Tap "Choose location on map" to set your location.',
//                         style: theme.textTheme.bodySmall
//                             ?.copyWith(color: Colors.grey),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//
//               // ---- Update Location button ----
//               BlocBuilder<LocationCubit, LocationState>(
//                 builder: (context, state) {
//                   // Only show loading if this screen started the save.
//                   final saving = _submitted &&
//                       state.maybeWhen(
//                         loading: () => true,
//                         orElse: () => false,
//                       );
//                   return SizedBox(
//                     height: 52,
//                     child: ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: theme.primaryColor,
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                       onPressed: (_canSave && !saving) ? _save : null,
//                       icon: saving
//                           ? const SizedBox(
//                         width: 18,
//                         height: 18,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: Colors.white,
//                         ),
//                       )
//                           : const Icon(Icons.location_on_outlined),
//                       label: const Text(
//                         'Update Location',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

// adjust these paths to your project
import '../../../../data/services/snack_shower.dart';
import '../../../../di/injector.dart';
import '../../../../domain/domain.dart'; // UserEntity
import '../../../../l10n/app_localizations.dart';
import '../../../blocs/authentication_cubit/authentication_cubit.dart';
import '../../openstreetmap/location_widgets.dart'; // LocationField
import '../../openstreetmap/picker_location.dart'; // the ONLY PickedLocation definition
import 'cubit/location_cubit.dart';

// TODO: Import your generated localization class
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditLocationScreen extends StatefulWidget {
  static const String routeName = 'edit-location';
  static const String routePath = '/edit-location';

  const EditLocationScreen({super.key});

  @override
  State<EditLocationScreen> createState() => _EditLocationScreenState();
}

class _EditLocationScreenState extends State<EditLocationScreen> {
  final _latController = TextEditingController();
  final _lngController = TextEditingController();
  final ISnackShower _snackShower = inject<ISnackShower>();

  PickedLocation? _picked;
  PickedLocation? _initial;

  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthenticationCubit>().user;
    if (user != null && user.hasLocation) {
      final point = LatLng(user.latitude!, user.longitude!);
      final address = (user.address != null && user.address!.trim().isNotEmpty)
          ? user.address!
          : '${point.latitude.toStringAsFixed(6)}, ${point.longitude.toStringAsFixed(6)}';

      _initial = PickedLocation(point, address);
      _fill(_initial!);
    }
  }

  @override
  void dispose() {
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  void _fill(PickedLocation loc) {
    _picked = loc;
    _latController.text = loc.latLng.latitude.toStringAsFixed(6);
    _lngController.text = loc.latLng.longitude.toStringAsFixed(6);
  }

  void _onLocationChanged(PickedLocation loc) {
    setState(() => _fill(loc));
  }

  void _save() {
    final user = context.read<AuthenticationCubit>().user;
    final loc = _picked;
    if (user == null || loc == null) return;

    setState(() => _submitted = true);
    context.read<LocationCubit>().updateLocation(
      userId: user.id,
      latitude: loc.latLng.latitude,
      longitude: loc.latLng.longitude,
      address: loc.address,
    );
  }

  Future<void> _onSaved(UserEntity updatedUser) async {
    await context.read<AuthenticationCubit>().authenticateUser(
      user: updatedUser,
    );
    if (!mounted) return;

    setState(() => _initial = _picked);

    final l10n = AppLocalizations.of(context)!;
    _snackShower.success(
      context: context,
      message: l10n.locationUpdatedSuccessfully,
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      prefixIcon: const Icon(Icons.gps_fixed),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final address = _picked?.address ?? '';

    return BlocListener<LocationCubit, LocationState>(
      listener: (context, state) {
        if (!_submitted) return;

        state.whenOrNull(
          success: (updatedUser) {
            setState(() => _submitted = false);
            _onSaved(updatedUser);
          },
          failure: (error) {
            setState(() => _submitted = false);
            _snackShower.error(
              context: context,
              message: error,
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.updateLocation)),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.map_outlined,
                        color: theme.primaryColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    l10n.myLocation,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    LocationField(
                      value: _picked,
                      onChanged: _onLocationChanged,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _latController,
                            readOnly: true,
                            decoration: _decoration(l10n.latitude),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _lngController,
                            readOnly: true,
                            decoration: _decoration(l10n.longitude),
                          ),
                        ),
                      ],
                    ),
                    if (address.isEmpty && _picked == null) ...[
                      const SizedBox(height: 12),
                      Text(
                        l10n.tapChooseLocationHint,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
              BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  final saving = _submitted &&
                      state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );
                  return SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        disabledBackgroundColor: theme.primaryColor,
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: (_picked != null && !saving) ? _save : null,
                      icon: saving
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Icon(Icons.location_on_outlined),
                      label: Text(
                        l10n.updateLocation,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}