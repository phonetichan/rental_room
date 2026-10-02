import 'package:injectable/injectable.dart';

import '../../core/core.dart';
import '../entity/contract_entity.dart';
import '../repository/contract_repository.dart';

@lazySingleton
class UpdateContractUseCase
    implements UseCase<DataState<ContractEntity>, ContractEntity> {
  final ContractRepository _repository;

  const UpdateContractUseCase(this._repository);

  @override
  Future<DataState<ContractEntity>> call(ContractEntity contract) async {
    try {
      final updated = await _repository.updateContract(contract);
      return Success(updated);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}