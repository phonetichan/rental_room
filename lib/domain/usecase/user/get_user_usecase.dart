import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../entity/user/user_entity.dart';
import '../../repository/auth/auth_repository.dart';

class GetUserParam {
  final String userId;

  const GetUserParam({
    required this.userId,
  });
}

@lazySingleton
class GetUserUseCase implements UseCase<DataState<UserEntity?>, GetUserParam> {
  final AuthRepository _repository;

  const GetUserUseCase(this._repository);

  @override
  Future<DataState<UserEntity?>> call(GetUserParam param) async {
    try {
      final user = await _repository.getCurrentUser();
      return Success(user);
    } on FirebaseAuthException catch (e) {
      return Failed(DbFailure(e.message ?? 'Failed to get user (${e.code})'));
    } on RemoteException catch (e) {
      return Failed(e.toFailure());
    } catch (e) {
      final cleanMsg = e
          .toString()
          .replaceAll('Exception: ', '')
          .replaceAll(RegExp(r'\[.*?\]\s*'), '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}
