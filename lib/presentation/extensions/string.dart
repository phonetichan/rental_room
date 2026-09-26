import 'package:intl/intl.dart';

extension StringExtension on String {
  String get formatWithCommas {
    final double value = double.parse(this);
    final formatter = NumberFormat.decimalPattern();
    return formatter.format(value);
  }

  String maskAndShowLastThree() {
    if (length <= 3) {
      return '*' * length;
    }

    String masked = '*' * (length - 3) + substring(length - 3);

    return masked;
  }

  String mask() {
    String masked = '*' * length;

    return masked;
  }
}
