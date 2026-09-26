import 'package:injectable/injectable.dart';
import 'package:rental_room/core/core.dart';
import 'package:rental_room/domain/domain.dart';

@lazySingleton
class SignOutUseCase implements UseCase<DataState<void>, void> {
  final AuthRepository _repository;

  const SignOutUseCase(this._repository);

  @override
  Future<DataState<void>> call([void param]) async {
    try {
      await _repository.signOut();
      return const Success(null);
    } on RemoteException catch (e) {
      return Failed(e.toFailure());
    }
  }
}