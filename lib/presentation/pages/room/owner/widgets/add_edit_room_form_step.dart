import 'package:flutter/material.dart';

import '../../../../extensions/l10n.dart';
import 'counter_selector_widget.dart';

class AddEditRoomFormStep extends StatelessWidget {
  final bool isSubmitting;
  final bool isEditing;
  final TextEditingController nameController;
  final TextEditingController roomNumberController;
  final TextEditingController floorController;
  final TextEditingController sqftController;
  final TextEditingController priceController;
  final TextEditingController? depositAmountController;
  final TextEditingController? agentNameController;
  final TextEditingController? agentFeesController;
  final TextEditingController descriptionController;
  final String? selectedRoomType;
  final List<Map<String, dynamic>> roomTypes;
  final int maxGuests;
  final int numberBedrooms;
  final ValueChanged<String?> onRoomTypeChanged;
  final ValueChanged<int> onMaxGuestsChanged;
  final ValueChanged<int> onNumberBedroomsChanged;
  // final VoidCallback onNavigateToUserGuidance;
  final InputDecoration Function({
  required String labelText,
  required IconData prefixIcon,
  String? hintText,
  String? suffixText,
  bool alignLabelWithHint,
  }) inputDecorationBuilder;

  const AddEditRoomFormStep({
    super.key,
    required this.isSubmitting,
    required this.isEditing,
    required this.nameController,
    required this.roomNumberController,
    required this.floorController,
    required this.sqftController,
    required this.priceController,
    required this.depositAmountController,
    this.agentNameController,
    this.agentFeesController,
    required this.descriptionController,
    required this.selectedRoomType,
    required this.roomTypes,
    required this.maxGuests,
    required this.numberBedrooms,
    required this.onRoomTypeChanged,
    required this.onMaxGuestsChanged,
    required this.onNumberBedroomsChanged,
    // required this.onNavigateToUserGuidance,
    required this.inputDecorationBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      key: const ValueKey(0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: nameController,
          enabled: !isSubmitting,
          style: const TextStyle(fontSize: 14),
          decoration: inputDecorationBuilder(
            labelText: l10n.roomNameTitle,
            hintText: l10n.roomNameHint,
            prefixIcon: Icons.meeting_room_outlined,
          ),
          validator: (v) =>
          v == null || v.trim().isEmpty ? l10n.pleaseEnterRoomName : null,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: roomNumberController,
                enabled: !isSubmitting && !isEditing,
                style: const TextStyle(fontSize: 14),
                decoration: inputDecorationBuilder(
                  labelText: l10n.roomNumber,
                  hintText: '101',
                  prefixIcon: Icons.tag,
                ),
                validator: (v) =>
                v == null || v.trim().isEmpty ? l10n.required : null,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: TextFormField(
                controller: floorController,
                enabled: !isSubmitting,
                style: const TextStyle(fontSize: 14),
                decoration: inputDecorationBuilder(
                  labelText: l10n.floor,
                  hintText: '1st Floor',
                  prefixIcon: Icons.layers_outlined,
                ),
                validator: (v) =>
                v == null || v.trim().isEmpty ? l10n.required : null,
                keyboardType: TextInputType.text,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          initialValue: selectedRoomType,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: inputDecorationBuilder(
            labelText: l10n.roomType,
            prefixIcon: Icons.category_outlined,
          ),
          items: roomTypes
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
          onChanged: isSubmitting ? null : onRoomTypeChanged,
          validator: (v) =>
          v == null || v.isEmpty ? l10n.pleaseSelectRoomType : null,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: sqftController,
          enabled: !isSubmitting && !isEditing,
          style: const TextStyle(fontSize: 14),
          keyboardType: TextInputType.number,
          decoration: inputDecorationBuilder(
            labelText: l10n.roomSqft,
            hintText: 'e.g. 450',
            prefixIcon: Icons.straighten_outlined,
          ),
          validator: (v) => v == null || v.trim().isEmpty
              ? l10n.pleaseEnterSquareFootage
              : null,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: priceController,
          enabled: !isSubmitting,
          style: const TextStyle(fontSize: 14),
          keyboardType: TextInputType.number,
          decoration: inputDecorationBuilder(
            labelText: l10n.pricePerMonth,
            hintText: 'e.g. 300000',
            prefixIcon: Icons.payments_outlined,
            suffixText: 'MMK',
          ),
          validator: (v) =>
          v == null || v.trim().isEmpty ? l10n.pleaseEnterRentalPrice : null,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: depositAmountController,
          enabled: !isSubmitting,
          style: const TextStyle(fontSize: 14),
          keyboardType: TextInputType.number,
          decoration: inputDecorationBuilder(
            labelText: l10n.depositAmountOptional,
            hintText: 'e.g. 500000',
            prefixIcon: Icons.account_balance_wallet_outlined,
            suffixText: 'MMK',
          ),
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: agentNameController,
          enabled: !isSubmitting,
          style: const TextStyle(fontSize: 14),
          decoration: inputDecorationBuilder(
            labelText: 'Agent Name (Optional)',
            hintText: 'e.g. U Aung',
            prefixIcon: Icons.person_outline,
          ),
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: agentFeesController,
          enabled: !isSubmitting,
          style: const TextStyle(fontSize: 14),
          keyboardType: TextInputType.number,
          decoration: inputDecorationBuilder(
            labelText: 'Agent Fees (Optional)',
            hintText: 'e.g. 50000',
            prefixIcon: Icons.handshake_outlined,
            suffixText: 'MMK',
          ),
        ),
        const SizedBox(height: 14),
        CounterSelectorWidget(
          label: l10n.maxGuestsAllowed,
          icon: Icons.group_outlined,
          value: maxGuests,
          enabled: !isSubmitting,
          onChanged: onMaxGuestsChanged,
        ),
        const SizedBox(height: 14),
        CounterSelectorWidget(
          label: l10n.numberOfBedrooms,
          icon: Icons.king_bed_outlined,
          value: numberBedrooms,
          minValue: 0,
          enabled: !isSubmitting,
          onChanged: onNumberBedroomsChanged,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: descriptionController,
          enabled: !isSubmitting,
          style: const TextStyle(fontSize: 14),
          minLines: 6,
          maxLines: 8,
          decoration: inputDecorationBuilder(
            labelText: l10n.descriptionOptional,
            hintText: l10n.descriptionHint,
            prefixIcon: Icons.description_outlined,
            alignLabelWithHint: true,
          ),
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }
}