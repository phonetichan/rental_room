import 'package:injectable/injectable.dart';

import '../../core/core.dart';
import '../entity/contract_entity.dart';
import '../repository/contract_repository.dart';

@lazySingleton
class GetContractByBookingUseCase implements UseCase<DataState<ContractEntity?>, String> {
  final ContractRepository _repository;

  const GetContractByBookingUseCase(this._repository);

  @override
  Future<DataState<ContractEntity?>> call(String bookingId) async {
    try {
      final contract = await _repository.getContractByBookingId(bookingId);
      return Success(contract);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}
