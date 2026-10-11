import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../domain/domain.dart';
import 'package:rental_room/presentation/extensions/l10n.dart';
import 'widgets/widgets.dart';

class ContractDetailPage extends StatefulWidget {
  static const String routeName = 'contract-detail';
  static const String routePath = '/contract-detail';

  final String bookingId;

  const ContractDetailPage({super.key, required this.bookingId});

  @override
  State<ContractDetailPage> createState() => _ContractDetailPageState();
}

class _ContractDetailPageState extends State<ContractDetailPage> {
  bool _isLoading = true;
  bool _isSaving = false;
  bool _isCompleted = false;
  bool _hasNoContract = false;
  ContractEntity? _contract;
  RoomEntity? _room;
  String? _errorMessage;

  int _selectedDurationMonth = 3;
  late DateTime _startDate;
  late DateTime _endDate;
  late final TextEditingController _notesController;

  final List<int> _allowedDurations = [3, 6, 9, 12];

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _endDate = _startDate.add(const Duration(days: 90));
    _notesController = TextEditingController();
    _loadContract();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _recalculateEndDate() {
    if (_contract != null) {
      final days = _selectedDurationMonth * 30;
      setState(() {
        _endDate = _startDate.add(Duration(days: days));
      });
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        _recalculateEndDate();
      });
    }
  }

  Future<void> _loadContract() async {
    try {
      final getContractUseCase = inject<GetContractByBookingUseCase>();
      final result = await getContractUseCase(widget.bookingId);

      ContractEntity? foundContract;
      result.onSuccess((contract) {
        foundContract = contract;
      });

      if (foundContract == null) {
        if (mounted) {
          setState(() {
            _hasNoContract = true;
            _isLoading = false;
          });
        }
        return;
      }

      final bool isLocked =
          foundContract!.status == ContractStatus.active ||
              foundContract!.status == ContractStatus.expired ||
              foundContract!.status == ContractStatus.terminated;

      RoomEntity? loadedRoom;
      if (foundContract!.roomId.isNotEmpty) {
        try {
          loadedRoom = await inject<RoomRepository>().getRoomById(foundContract!.roomId);
        } catch (_) {}
      }

      if (mounted) {
        setState(() {
          _contract = foundContract;
          _room = loadedRoom;
          _selectedDurationMonth = foundContract!.durationMonth.clamp(3, 12);
          _startDate = foundContract!.startDate;
          _endDate = foundContract!.endDate;
          _notesController.text = foundContract!.description;
          _isCompleted = isLocked;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _saveContractChanges() async {
    if (_contract == null || _isSaving || _isCompleted) return;

    setState(() => _isSaving = true);
    try {
      final updateContractUseCase = inject<UpdateContractUseCase>();

      final updatedContract = _contract!.copyWith(
        durationMonth: _selectedDurationMonth,
        startDate: _startDate,
        endDate: _endDate,
        description: _notesController.text.trim(),
        status: ContractStatus.active,
      );

      final result = await updateContractUseCase(updatedContract);

      result.onSuccess((_) {
        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => ContractSuccessScreen(
            contract: updatedContract,
          ),
        );
      });

      result.onError((failure) {
        if (!mounted) return;
        final l10n = context.l10n;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.failedToUpdateContract(failure.reason))),
        );
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surfaceContainerLowest,
        title: Text(
          l10n.rentalAgreementVoucher,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : (_hasNoContract || _errorMessage != null)
            ? _buildErrorState(context, theme, colorScheme)
            : Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContractHeaderBanner(isCompleted: _isCompleted),
                    const SizedBox(height: 14),

                    // Interactive Voucher Card preview
                    ContractVoucherCard(
                      contract: _contract!.copyWith(
                        durationMonth: _selectedDurationMonth,
                        startDate: _startDate,
                        endDate: _endDate,
                        description: _notesController.text,
                      ),
                      room: _room,
                    ),
                    const SizedBox(height: 16),

                    ContractSummarySection(
                      allowedDurations: _allowedDurations,
                      selectedDurationMonth: _selectedDurationMonth,
                      onDurationSelected: (months) {
                        setState(() {
                          _selectedDurationMonth = months;
                          _recalculateEndDate();
                        });
                      },
                      startDate: _startDate,
                      endDate: _endDate,
                      onSelectStartDate: () => _selectStartDate(context),
                      isCompleted: _isCompleted,
                    ),
                  ],
                ),
              ),
            ),
            ContractBottomActionBar(
              isCompleted: _isCompleted,
              isSaving: _isSaving,
              onPressed: _saveContractChanges,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          _hasNoContract ? l10n.noContractFound : (_errorMessage ?? 'Error loading contract'),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.error),
        ),
      ),
    );
  }
}
