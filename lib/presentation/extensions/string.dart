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

  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) {
      if (word.isEmpty) return word;
      return '${word[0].toUpperCase()}${word.substring(1)}';
    }).join(' ');
  }
}
