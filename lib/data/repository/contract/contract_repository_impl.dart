import 'package:injectable/injectable.dart';

import '../../../domain/entity/contract/contract_entity.dart';
import '../../../domain/repository/contract/contract_repository.dart';
import '../../datasource/remote/firebase_api/owner_data_source/contract_data_source.dart';
import 'package:rental_room/data/data.dart';

@LazySingleton(as: ContractRepository)
class ContractRepositoryImpl implements ContractRepository {
  final ContractRemoteDataSource _remoteDataSource;

  ContractRepositoryImpl(this._remoteDataSource);

  @override
  Future<ContractEntity> createContract(ContractEntity contract) async {
    final model = ContractModel.fromEntity(contract);
    final created = await _remoteDataSource.createContract(model);
    return created.toEntity();
  }

  @override
  Future<ContractEntity?> getContractByBookingId(String bookingId) async {
    final model = await _remoteDataSource.getContractByBookingId(bookingId);
    return model?.toEntity();
  }

  @override
  Future<ContractEntity> updateContract(ContractEntity contract) async {
    final model = ContractModel.fromEntity(contract);
    final updated = await _remoteDataSource.updateContract(model);
    return updated.toEntity();
  }

  @override
  Future<List<ContractEntity>> getContractsByOwnerId(String ownerId) async {
    final models = await _remoteDataSource.getContractsByOwnerId(ownerId);
    return models.map((e) => e.toEntity()).toList();
  }
}
