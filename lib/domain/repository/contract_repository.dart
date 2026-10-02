import '../entity/contract_entity.dart';

abstract class ContractRepository {
  Future<ContractEntity> createContract(ContractEntity contract);
  Future<ContractEntity?> getContractByBookingId(String bookingId);
  Future<ContractEntity> updateContract(ContractEntity contract);
}
