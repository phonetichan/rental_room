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

  Future<void> _confirmAndSave() async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.confirmUpdateLocationTitle),
        content: Text(
          l10n.confirmUpdateLocationMessage,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(l10n.change),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      _save();
    }
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
                      onPressed: (_picked != null && !saving) ? _confirmAndSave : null,
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
