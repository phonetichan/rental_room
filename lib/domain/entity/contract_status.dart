enum ContractStatus {
  pending('pending'),
  active('active'),
  expired('expired'),
  terminated('terminated');

  final String value;
  const ContractStatus(this.value);

  /// Converts String from Firestore into ContractStatus enum strictly matching active status
  static ContractStatus fromString(String val) {
    return ContractStatus.values.firstWhere(
      (e) => e.value.toLowerCase() == val.toLowerCase().trim(),
      orElse: () => ContractStatus.pending,
    );
  }
}
