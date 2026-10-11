import '../../domain.dart';

class ExpireContractUseCase {
  final ContractRepository _repository;
  ExpireContractUseCase(this._repository);

  Future<ContractEntity> call(ContractEntity contract) {
    return _repository.updateContract(
      contract.copyWith(status: ContractStatus.expired),
    );
  }
}