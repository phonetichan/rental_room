enum ContractStatus {
  pending('PENDING'),
  active('ACTIVE'),
  expired('EXPIRED'),
  terminated('TERMINATED');

  final String value;
  const ContractStatus(this.value);

  /// Helper method to safely convert String from Firestore into ContractStatus enum
  static ContractStatus fromString(String val) {
    return ContractStatus.values.firstWhere(
          (e) => e.value.toUpperCase() == val.toUpperCase(),
      orElse: () => ContractStatus.pending,
    );
  }
}