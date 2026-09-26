import '../core.dart';

abstract class RemoteException implements Exception {
  final String message;
  final String? codeStatus;

  const RemoteException(this.message, [this.codeStatus]);

  Failure toFailure([String? reason]) => DbFailure(reason ??
      message
          .toString()
          .replaceAll(RegExp(r'Exception:\s*'), '')
          .replaceAll(RegExp(r'\[.*?\]\s*'), ''));
}

final class DatabaseException extends RemoteException {
  const DatabaseException(super.message, [super.statusCode]);

  @override
  Failure toFailure([String? reason]) => DbFailure(reason ??
      message
          .toString()
          .replaceAll(RegExp(r'Exception:\s*'), '')
          .replaceAll(RegExp(r'\[.*?\]\s*'), ''));
}
