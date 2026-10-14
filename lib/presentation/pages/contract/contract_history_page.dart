import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_room/domain/domain.dart';
import 'package:rental_room/di/di.dart';
import 'package:rental_room/l10n/app_localizations.dart';
import 'package:rental_room/presentation/extensions/contract/contract_extensions.dart';
import 'package:rental_room/presentation/pages/contract/voucher_detail_page.dart';
import 'widgets/widgets.dart';

class ContractHistoryPage extends StatefulWidget {
  static const String routeName = 'contract-history';
  static const String routePath = '/contract-history';

  final UserEntity user;

  const ContractHistoryPage({super.key, required this.user});

  @override
  State<ContractHistoryPage> createState() => _ContractHistoryPageState();
}

class _ContractHistoryPageState extends State<ContractHistoryPage> {
  bool _isLoading = true;
  List<ContractEntity> _contracts = [];
  Map<String, RoomEntity> _roomsByRoomId = {};
  String? _errorMessage;

  bool get _isOwner => widget.user.role == UserRole.owner;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (_contracts.isEmpty) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    } else {
      setState(() {
        _errorMessage = null;
      });
    }

    try {
      final contractRepo = inject<ContractRepository>();
      final roomRepo = inject<RoomRepository>();
      final expireContractUseCase = inject<ExpireContractUseCase>();

      final contractsList = _isOwner
          ? await contractRepo.getContractsByOwnerId(widget.user.id)
          : await contractRepo.getContractsByTenantId(widget.user.id);

      final List<ContractEntity> activeContracts = [];
      for (final c in contractsList) {
        final isExpired = ContractStatusX(c).isExpired || c.status == ContractStatus.expired;
        if (isExpired) {
          try {
            await expireContractUseCase(c);
          } catch (_) {}
        } else if (c.status == ContractStatus.active) {
          activeContracts.add(c);
        }
      }

      final roomIds = activeContracts
          .map((c) => c.roomId)
          .where((id) => id.isNotEmpty)
          .toSet()
          .toList();

      final roomsList = await Future.wait(
        roomIds.map((id) => roomRepo.getRoomById(id)),
      );
      final roomsMap = {
        for (final r in roomsList.whereType<RoomEntity>()) r.id: r,
      };

      if (mounted) {
        setState(() {
          _contracts = activeContracts;
          _roomsByRoomId = roomsMap;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceAll('Exception: ', '');
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.contractHistory),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline_rounded,
                              size: 48, color: theme.colorScheme.error),
                          const SizedBox(height: 12),
                          Text(_errorMessage!, textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadData,
                            child: Text(l10n.retry),
                          ),
                        ],
                      ),
                    ),
                  )
                : _contracts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.assignment_outlined,
                                size: 64, color: Colors.grey.shade400),
                            const SizedBox(height: 16),
                            Text(
                              l10n.noContractFound,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: _contracts.length,
                        itemBuilder: (context, index) {
                          final contract = _contracts[index];
                          final room = _roomsByRoomId[contract.roomId];

                          return ContractCard(
                            contract: contract,
                            room: room,
                            currentUser: widget.user,
                            onTap: () async {
                              final result = await context.pushNamed<bool>(
                                VoucherDetailPage.routeName,
                                extra: contract,
                              );
                              if (result == true && context.mounted) {
                                _loadData();
                              }
                            },
                          );
                        },
                      ),
      ),
    );
  }
}
