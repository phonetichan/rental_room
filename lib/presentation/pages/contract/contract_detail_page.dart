// import 'package:flutter/material.dart';
//
// import '../../../di/di.dart';
// import '../../../domain/domain.dart';
// import 'widgets/contract_success_screen.dart';
// import 'widgets/contract_voucher_card.dart';
//
// class ContractDetailPage extends StatefulWidget {
//   static const String routeName = 'contract-detail';
//   static const String routePath = '/contract-detail';
//
//   final String bookingId;
//
//   const ContractDetailPage({super.key, required this.bookingId});
//
//   @override
//   State<ContractDetailPage> createState() => _ContractDetailPageState();
// }
//
// class _ContractDetailPageState extends State<ContractDetailPage> {
//   bool _isLoading = true;
//   bool _isSaving = false;
//   bool _isCompleted = false; // Tracks if the contract is already finalized/created
//   ContractEntity? _contract;
//   String? _errorMessage;
//
//   // Form State
//   int _selectedDurationMonth = 3;
//   late DateTime _startDate;
//   late DateTime _endDate;
//   final TextEditingController _notesController = TextEditingController();
//
//   final List<int> _allowedDurations = [3, 6, 12];
//
//   @override
//   void initState() {
//     super.initState();
//     _startDate = DateTime.now();
//     _recalculateEndDate();
//     _loadContract();
//   }
//
//   @override
//   void dispose() {
//     _notesController.dispose();
//     super.dispose();
//   }
//
//   void _recalculateEndDate() {
//     int targetYear = _startDate.year;
//     int targetMonth = _startDate.month + _selectedDurationMonth;
//     while (targetMonth > 12) {
//       targetMonth -= 12;
//       targetYear += 1;
//     }
//     int targetDay = _startDate.day;
//     final lastDayOfMonth = DateTime(targetYear, targetMonth + 1, 0).day;
//     if (targetDay > lastDayOfMonth) {
//       targetDay = lastDayOfMonth;
//     }
//     _endDate = DateTime(targetYear, targetMonth, targetDay);
//   }
//
//   Future<void> _loadContract() async {
//     try {
//       final getContractUseCase = inject<GetContractByBookingUseCase>();
//       final createContractUseCase = inject<CreateContractUseCase>();
//       final bookingRepo = inject<BookingRepository>();
//       final roomRepo = inject<RoomRepository>();
//
//       // Fetch real booking and room data from Firestore
//       BookingEntity? booking;
//       RoomEntity? room;
//       try {
//         booking = await bookingRepo.getBookingById(widget.bookingId);
//         if (booking != null && booking.roomId.isNotEmpty) {
//           room = await roomRepo.getRoomById(booking.roomId);
//         }
//       } catch (_) {}
//
//       final realMonthlyRent = booking?.roomPrice ?? room?.pricePerMonth ?? 0.0;
//       final realRoomId = booking?.roomId ?? room?.id ?? '';
//       final realOwnerId = booking?.ownerId ?? room?.ownerId ?? '';
//       final realTenantId = booking?.userId ?? '';
//
//       ContractEntity? foundContract;
//       final result = await getContractUseCase(widget.bookingId);
//       result.onSuccess((contract) {
//         foundContract = contract;
//       });
//
//       bool isAlreadyCompleted = false;
//
//       if (foundContract == null) {
//         // Create initial draft contract once
//         final now = DateTime.now();
//         int targetYear = now.year;
//         int targetMonth = now.month + 3;
//         while (targetMonth > 12) {
//           targetMonth -= 12;
//           targetYear += 1;
//         }
//         int targetDay = now.day;
//         final lastDayOfMonth = DateTime(targetYear, targetMonth + 1, 0).day;
//         if (targetDay > lastDayOfMonth) targetDay = lastDayOfMonth;
//         final endDate = DateTime(targetYear, targetMonth, targetDay);
//
//         final roomName = booking?.roomName ?? room?.name ?? 'Room';
//         final newContract = ContractEntity(
//           id: '',
//           bookingId: widget.bookingId,
//           roomId: realRoomId,
//           ownerId: realOwnerId,
//           tenantId: realTenantId,
//           startDate: now,
//           endDate: endDate,
//           durationMonth: 3,
//           monthlyRent: realMonthlyRent,
//           description: 'Standard Rental Lease Agreement for $roomName. Duration: 3 months.',
//           createdAt: now,
//         );
//         final createResult = await createContractUseCase(newContract);
//         createResult.onSuccess((created) {
//           foundContract = created;
//         });
//       } else {
//         // Contract already exists in database -> Mark as completed/readonly
//         isAlreadyCompleted = true;
//       }
//
//       if (mounted && foundContract != null) {
//         setState(() {
//           _contract = foundContract;
//           _selectedDurationMonth = foundContract!.durationMonth.clamp(3, 12);
//           _startDate = foundContract!.startDate;
//           _recalculateEndDate();
//           _notesController.text = foundContract!.description;
//           _isCompleted = isAlreadyCompleted;
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _errorMessage = e.toString();
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   Future<void> _saveContractChanges() async {
//     // Block action if missing contract, already saving, or already completed
//     if (_contract == null || _isSaving || _isCompleted) return;
//
//     setState(() => _isSaving = true);
//
//     try {
//       final updatedContract = _contract!.copyWith(
//         durationMonth: _selectedDurationMonth,
//         startDate: _startDate,
//         endDate: _endDate,
//         description: _notesController.text.trim(),
//       );
//
//       final createContractUseCase = inject<CreateContractUseCase>();
//       final result = await createContractUseCase(updatedContract);
//
//       result.onSuccess((saved) {
//         if (!mounted) return;
//         setState(() {
//           _contract = saved;
//           _isCompleted = true; // Mark as permanently completed
//         });
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (_) => ContractSuccessScreen(contract: saved),
//           ),
//         );
//       });
//       result.onError((failure) {
//         if (!mounted) return;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to update contract: ${failure.reason}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       });
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to update contract: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       if (mounted) setState(() => _isSaving = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     return Scaffold(
//       backgroundColor: colorScheme.surfaceContainerLowest,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: colorScheme.surfaceContainerLowest,
//         title: Text(
//           'Rental Agreement',
//           style: TextStyle(
//             color: colorScheme.onSurface,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator.adaptive())
//             : _errorMessage != null
//             ? _buildErrorState(theme, colorScheme)
//             : Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildHeaderBanner(theme, colorScheme),
//                     const SizedBox(height: 14),
//
//                     // Interactive Voucher Card preview
//                     ContractVoucherCard(
//                       contract: _contract!.copyWith(
//                         durationMonth: _selectedDurationMonth,
//                         startDate: _startDate,
//                         endDate: _endDate,
//                         description: _notesController.text,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//
//                     _buildEditableForm(theme, colorScheme),
//                   ],
//                 ),
//               ),
//             ),
//             _buildBottomActionBar(context, theme, colorScheme),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeaderBanner(ThemeData theme, ColorScheme colorScheme) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _isCompleted
//             ? Colors.green.withValues(alpha: 0.1)
//             : colorScheme.primaryContainer.withValues(alpha: 0.3),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: _isCompleted
//               ? Colors.green.withValues(alpha: 0.3)
//               : colorScheme.primary.withValues(alpha: 0.2),
//         ),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             _isCompleted ? Icons.check_circle_rounded : Icons.edit_calendar_rounded,
//             color: _isCompleted ? Colors.green : colorScheme.primary,
//             size: 24,
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   _isCompleted ? 'Contract Finalized' : 'Lease Period & Terms',
//                   style: theme.textTheme.titleSmall?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: colorScheme.onSurface,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   _isCompleted
//                       ? 'This agreement has been confirmed and locked.'
//                       : 'Select duration between 3 months (minimum) and 1 year (maximum).',
//                   maxLines: 2,
//                   style: theme.textTheme.bodySmall?.copyWith(
//                     color: colorScheme.onSurfaceVariant,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEditableForm(ThemeData theme, ColorScheme colorScheme) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Contract Details Form',
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//
//         // Duration Selection
//         Text(
//           'Select Duration',
//           style: theme.textTheme.labelLarge?.copyWith(
//             fontWeight: FontWeight.bold,
//             color: colorScheme.onSurface,
//           ),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           children: _allowedDurations.map((months) {
//             final isSelected = _selectedDurationMonth == months;
//             final label = months == 12 ? '1 Year' : '$months Months';
//
//             return Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(12),
//                   onTap: _isCompleted
//                       ? null // Readonly when completed
//                       : () {
//                     if (!isSelected) {
//                       setState(() {
//                         _selectedDurationMonth = months;
//                         _recalculateEndDate();
//                       });
//                     }
//                   },
//         //           child: AnimatedContainer(
//         //             duration: const Duration(milliseconds: 200),
//         //             padding: const EdgeInsets.symmetric(vertical: 12),
//         //             decoration: BoxDecoration(
//         //               color: isSelected
//         //                   ? (_isCompleted
//         //                   ? colorScheme.outline
//         //                   : colorScheme.primary)
//         //                   : colorScheme.surfaceContainerHigh,
//         //               borderRadius: BorderRadius.circular(12),
//         //               border: Border.all(
//         //                 color: isSelected
//         //                     ? (_isCompleted
//         //                     ? colorScheme.outline
//         //                     : colorScheme.primary)
//         //                     : colorScheme.outlineVariant.withValues(alpha: 0.5),
//         //                 width: 1.5,
//         //               ),
//         //             ),
//         //             child: Text(
//         //               label,
//         //               textAlign: TextAlign.center,
//         //               maxLines: 1,
//         //               overflow: TextOverflow.ellipsis,
//         //               style: TextStyle(
//         //                 fontSize: 13,
//         //                 fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//         //                 color: isSelected
//         //                     ? colorScheme.onPrimary
//         //                     : colorScheme.onSurface,
//         //               ),
//         //             ),
//         //           ),
//         //         ),
//         //       ),
//         //     );
//         //   }).toList(),
//         // ),
//
//                   child: AnimatedContainer(
//                     duration:
//                     const Duration(milliseconds: 200),
//                     padding:
//                     const EdgeInsets.symmetric(vertical: 12),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? colorScheme.primary
//                           : colorScheme.surfaceContainerHigh,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: isSelected
//                             ? colorScheme.primary
//                             : colorScheme.outlineVariant
//                             .withValues(alpha: 0.5),
//                         width: 1.5,
//                       ),
//                     ),
//                     child: Text(
//                       label,
//                       textAlign: TextAlign.center,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: isSelected
//                             ? FontWeight.bold
//                             : FontWeight.w500,
//                         color: isSelected
//                             ? colorScheme.onPrimary
//                             : colorScheme.onSurface,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: 20),
//
//         // Start Date Selector
//         Text(
//           'Start Date',
//           style: theme.textTheme.labelLarge?.copyWith(
//             fontWeight: FontWeight.bold,
//             color: colorScheme.onSurface,
//           ),
//         ),
//         const SizedBox(height: 8),
//         InkWell(
//           onTap: _isCompleted ? null : _pickStartDate, // Readonly when completed
//           borderRadius: BorderRadius.circular(12),
//           child: Container(
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(
//               color: colorScheme.surfaceContainerHigh,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: colorScheme.outlineVariant.withValues(alpha: 0.3),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '${_startDate.day.toString().padLeft(2, '0')}/${_startDate.month.toString().padLeft(2, '0')}/${_startDate.year}',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Icon(Icons.calendar_today_outlined,
//                     size: 18,
//                     color: _isCompleted
//                         ? colorScheme.outline
//                         : colorScheme.primary),
//               ],
//             ),
//           ),
//         ),
//
//         const SizedBox(height: 16),
//
//         // End Date Readout
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//           decoration: BoxDecoration(
//             color: colorScheme.surfaceContainerLow,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Calculated End Date',
//                 style: theme.textTheme.bodyMedium?.copyWith(
//                   color: colorScheme.onSurfaceVariant,
//                 ),
//               ),
//               Text(
//                 '${_endDate.day.toString().padLeft(2, '0')}/${_endDate.month.toString().padLeft(2, '0')}/${_endDate.year}',
//                 style: theme.textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: colorScheme.primary,
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         const SizedBox(height: 20),
//       ],
//     );
//   }
//
//   Future<void> _pickStartDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _startDate,
//       firstDate: DateTime.now().subtract(const Duration(days: 7)),
//       lastDate: DateTime.now().add(const Duration(days: 90)),
//     );
//     if (picked != null) {
//       setState(() {
//         _startDate = picked;
//         _recalculateEndDate();
//       });
//     }
//   }
//
//   Widget _buildBottomActionBar(
//       BuildContext context,
//       ThemeData theme,
//       ColorScheme colorScheme,
//       ) {
//     final bool canSubmit = !_isSaving && !_isCompleted;
//
//     return Container(
//       padding: const EdgeInsets.all(20.0),
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         border: Border(
//           top: BorderSide(
//             color: colorScheme.outlineVariant.withValues(alpha: 0.5),
//           ),
//         ),
//       ),
//       child: SizedBox(
//         width: double.infinity,
//         height: 50,
//         child: ElevatedButton.icon(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: canSubmit ? colorScheme.primary : colorScheme.surfaceContainerHighest,
//             foregroundColor: canSubmit ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           icon: _isSaving
//               ? const SizedBox(
//             width: 20,
//             height: 20,
//             child: CircularProgressIndicator(
//               strokeWidth: 2,
//               color: Colors.white,
//             ),
//           )
//               : Icon(
//             _isCompleted ? Icons.lock_outline : Icons.check_circle_outline,
//             size: 20,
//           ),
//           label: Text(
//             _isSaving
//                 ? 'Saving...'
//                 : _isCompleted
//                 ? 'Contract Already Confirmed'
//                 : 'Confirm & Save Voucher',
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//             ),
//           ),
//           onPressed: canSubmit ? _saveContractChanges : null, // Null disables the button
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorState(ThemeData theme, ColorScheme colorScheme) {
//     return Center(
//       child: Text(_errorMessage ?? 'Error loading contract'),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../domain/domain.dart';
import '../../../domain/entity/contract_status.dart';
import '../../../domain/usecase/update_contract_usecase.dart';
import 'widgets/contract_success_screen.dart';
import 'widgets/contract_voucher_card.dart';

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
  bool _isCompleted = false; // Prevents further edits once finalized/updated
  ContractEntity? _contract;
  String? _errorMessage;

  // Form State for initial sync/update
  int _selectedDurationMonth = 3;
  late DateTime _startDate;
  late DateTime _endDate;
  final TextEditingController _notesController = TextEditingController();

  final List<int> _allowedDurations = [3, 6, 12];

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _recalculateEndDate();
    _loadContract();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _recalculateEndDate() {
    int targetYear = _startDate.year;
    int targetMonth = _startDate.month + _selectedDurationMonth;
    while (targetMonth > 12) {
      targetMonth -= 12;
      targetYear += 1;
    }
    int targetDay = _startDate.day;
    final lastDayOfMonth = DateTime(targetYear, targetMonth + 1, 0).day;
    if (targetDay > lastDayOfMonth) {
      targetDay = lastDayOfMonth;
    }
    _endDate = DateTime(targetYear, targetMonth, targetDay);
  }

  /// Opens the DatePicker dialog allowing users to pick a start date
  Future<void> _selectStartDate(BuildContext context) async {
    if (_isCompleted) return;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)), // Allow up to 30 days in the past if needed
      lastDate: DateTime.now().add(const Duration(days: 365)), // Up to 1 year ahead
    );

    if (pickedDate != null && pickedDate != _startDate) {
      setState(() {
        _startDate = pickedDate;
        _recalculateEndDate();
      });
    }
  }

  Future<void> _loadContract() async {
    try {
      final getContractUseCase = inject<GetContractByBookingUseCase>();

      ContractEntity? foundContract;
      final result = await getContractUseCase(widget.bookingId);
      result.onSuccess((contract) {
        foundContract = contract;
      });

      if (foundContract == null) {
        if (mounted) {
          setState(() {
            _errorMessage = 'No contract found for this booking. Contract must be issued by owner.';
            _isLoading = false;
          });
        }
        return;
      }
      // Check contract status to decide if it's already locked/active
      final bool isLocked =
          foundContract!.status == ContractStatus.active ||
              foundContract!.status == ContractStatus.expired ||
              foundContract!.status == ContractStatus.terminated;

      if (mounted) {
        setState(() {
          _contract = foundContract;
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
      final updatedContract = _contract!.copyWith(
        durationMonth: _selectedDurationMonth,
        startDate: _startDate,
        endDate: _endDate,
        description: _notesController.text.trim(),
        status: ContractStatus.active,
      );

      final updateContractUseCase = inject<UpdateContractUseCase>();
      final result = await updateContractUseCase(updatedContract);

      result.onSuccess((saved) {
        if (!mounted) return;
        setState(() {
          _contract = saved;
          _isCompleted = true;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ContractSuccessScreen(contract: saved),
          ),
        );
      });

      result.onError((failure) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update contract: ${failure.reason}'),
            backgroundColor: Colors.red,
          ),
        );
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update contract: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surfaceContainerLowest,
        title: Text(
          'Rental Agreement',
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
            : _errorMessage != null
            ? _buildErrorState(theme, colorScheme)
            : Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderBanner(theme, colorScheme),
                    const SizedBox(height: 14),

                    // Interactive Voucher Card preview
                    ContractVoucherCard(
                      contract: _contract!.copyWith(
                        durationMonth: _selectedDurationMonth,
                        startDate: _startDate,
                        endDate: _endDate,
                        description: _notesController.text,
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildContractSummary(theme, colorScheme),
                  ],
                ),
              ),
            ),
            _buildBottomActionBar(context, theme, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBanner(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isCompleted
            ? Colors.green.withValues(alpha: 0.1)
            : colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isCompleted
              ? Colors.green.withValues(alpha: 0.3)
              : colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _isCompleted
                ? Icons.check_circle_rounded
                : Icons.lock_clock_outlined,
            color: _isCompleted ? Colors.green : colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isCompleted
                      ? 'Contract Confirmed'
                      : 'Owner-Confirmed Contract',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _isCompleted
                      ? 'This agreement is finalized and locked.'
                      : 'Review the terms set by the owner before saving.',
                  maxLines: 2,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractSummary(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Agreement Details',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Duration Display / Selection
        Text(
          'Lease Duration',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: _allowedDurations.map((months) {
            final isSelected = _selectedDurationMonth == months;
            final label = months == 12 ? '1 Year' : '$months Months';

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: GestureDetector(
                  onTap: _isCompleted
                      ? null
                      : () {
                    setState(() {
                      _selectedDurationMonth = months;
                      _recalculateEndDate();
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (_isCompleted
                          ? colorScheme.secondaryContainer
                          : colorScheme.primary)
                          : colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? (_isCompleted
                            ? colorScheme.secondary
                            : colorScheme.primary)
                            : colorScheme.outlineVariant.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? (_isCompleted
                            ? colorScheme.onSecondaryContainer
                            : colorScheme.onPrimary)
                            : colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Start Date Selection Widget
        Text(
          'Start Date',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _isCompleted ? null : () => _selectStartDate(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: _isCompleted ? 0.1 : 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_startDate.day.toString().padLeft(2, '0')}/${_startDate.month.toString().padLeft(2, '0')}/${_startDate.year}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.calendar_month_rounded,
                  size: 20,
                  color: _isCompleted
                      ? colorScheme.outline
                      : colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Calculated End Date Readout
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lease Expiry Date',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '${_endDate.day.toString().padLeft(2, '0')}/${_endDate.month.toString().padLeft(2, '0')}/${_endDate.year}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBottomActionBar(
      BuildContext context,
      ThemeData theme,
      ColorScheme colorScheme,
      ) {
    final bool canSubmit = !_isSaving && !_isCompleted;

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: canSubmit
                ? colorScheme.primary
                : colorScheme.surfaceContainerHighest,
            foregroundColor: canSubmit
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: _isSaving
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : Icon(
            _isCompleted
                ? Icons.lock_outline
                : Icons.check_circle_outline,
            size: 20,
          ),
          label: Text(
            _isSaving
                ? 'Updating...'
                : _isCompleted
                ? 'Contract Finalized'
                : 'Acknowledge & Confirm',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          onPressed: canSubmit ? _saveContractChanges : null,
        ),
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme, ColorScheme colorScheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          _errorMessage ?? 'Error loading contract',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.error),
        ),
      ),
    );
  }
}