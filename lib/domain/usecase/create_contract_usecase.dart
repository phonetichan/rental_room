import 'package:injectable/injectable.dart';

import '../../core/core.dart';
import '../entity/contract_entity.dart';
import '../repository/contract_repository.dart';

@lazySingleton
class CreateContractUseCase implements UseCase<DataState<ContractEntity>, ContractEntity> {
  final ContractRepository _repository;

  const CreateContractUseCase(this._repository);

  @override
  Future<DataState<ContractEntity>> call(ContractEntity param) async {
    try {
      // Validate minimum duration of 3 months
      if (param.durationMonth < 3) {
        return const Failed(DbFailure('Minimum contract duration is 3 months.'));
      }

      final created = await _repository.createContract(param);
      return Success(created);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}
