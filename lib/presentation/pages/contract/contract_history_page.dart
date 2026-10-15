import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_room/domain/domain.dart';
import 'package:rental_room/di/di.dart';
import 'package:rental_room/l10n/app_localizations.dart';
import 'package:rental_room/presentation/blocs/blocs.dart';
import 'package:rental_room/presentation/extensions/contract/contract_extensions.dart';
import 'package:rental_room/presentation/pages/contract/voucher_detail_page.dart';
import 'widgets/widgets.dart';

class ContractHistoryPage extends StatelessWidget {
  static const String routeName = 'contract-history';
  static const String routePath = '/contract-history';

  final UserEntity user;

  const ContractHistoryPage({super.key, required this.user});

  bool get _isOwner => user.role == UserRole.owner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => inject<ContractCubit>()..loadContractHistory(user.id, _isOwner),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.contractHistory),
          elevation: 0,
        ),
        body: BlocBuilder<ContractCubit, ContractState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<ContractCubit>().loadContractHistory(user.id, _isOwner);
              },
              child: state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                failure: (message) => ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline_rounded,
                                  size: 48, color: theme.colorScheme.error),
                              const SizedBox(height: 12),
                              Text(message, textAlign: TextAlign.center),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => context.read<ContractCubit>().loadContractHistory(user.id, _isOwner),
                                child: Text(l10n.retry),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                historyLoaded: (contracts, roomsByRoomId) {
                  if (contracts.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Center(
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
                          ),
                        ),
                      ],
                    );
                  }

                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: contracts.length,
                    itemBuilder: (context, index) {
                      final contract = contracts[index];
                      final room = roomsByRoomId[contract.roomId];

                      return ContractCard(
                        contract: contract,
                        room: room,
                        currentUser: user,
                        onTap: () async {
                          final result = await context.pushNamed<bool>(
                            VoucherDetailPage.routeName,
                            extra: contract,
                          );
                          if (result == true && context.mounted) {
                            context.read<ContractCubit>().loadContractHistory(user.id, _isOwner);
                          }
                        },
                      );
                    },
                  );
                },
                orElse: () => const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        ),
      ),
    );
  }
}
