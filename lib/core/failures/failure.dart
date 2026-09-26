abstract class Failure {
  final String reason;
  const Failure(this.reason);
}

class DbFailure extends Failure {
  const DbFailure(super.reason);
}
