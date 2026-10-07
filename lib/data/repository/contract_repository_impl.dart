import 'package:injectable/injectable.dart';

import '../../domain/entity/contract_entity.dart';
import '../../domain/repository/contract_repository.dart';
import '../datasource/remote/contract_data_source.dart';
import '../model/contract_model.dart';

@LazySingleton(as: ContractRepository)
class ContractRepositoryImpl implements ContractRepository {
  final ContractRemoteDataSource _remoteDataSource;

  ContractRepositoryImpl(this._remoteDataSource);

  @override
  Future<ContractEntity> createContract(ContractEntity contract) {
    final model = ContractModel.fromEntity(contract);
    return _remoteDataSource.createContract(model);
  }

  @override
  Future<ContractEntity?> getContractByBookingId(String bookingId) {
    return _remoteDataSource.getContractByBookingId(bookingId);
  }

  @override
  Future<ContractEntity> updateContract(ContractEntity contract) async {
    final model = ContractModel.fromEntity(contract);
    return _remoteDataSource.updateContract(model);
  }

  @override
  Future<List<ContractEntity>> getContractsByOwnerId(String ownerId) {
    return _remoteDataSource.getContractsByOwnerId(ownerId);
  }
}