import 'package:injectable/injectable.dart';
import '../../domain.dart';
import 'expire_contract_usecase.dart';

@lazySingleton
class CheckAndExpireContractsUseCase {
  final ContractRepository _contractRepository;
  final ExpireContractUseCase _expireContractUseCase;

  const CheckAndExpireContractsUseCase(
    this._contractRepository,
    this._expireContractUseCase,
  );

  Future<void> call() async {
    try {
      final activeContracts = await _contractRepository.getAllActiveContracts();
      final now = DateTime.now();
      for (final c in activeContracts) {
        if (!c.endDate.isAfter(now)) {
          try {
            await _expireContractUseCase(c);
          } catch (_) {}
        }
      }
    } catch (_) {}
  }
}
