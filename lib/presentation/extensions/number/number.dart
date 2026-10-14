extension NumberFormatting on num {
  /// Formats as 'Ks X.Xk / month' or 'Ks X / month'
  String get toKsFormat {
    if (this >= 1000) {
      final double kValue = this / 1000;
      if (kValue % 1 == 0) {
        return 'Ks ${kValue.toInt()}K / month';
      } else {
        return 'Ks ${kValue.toStringAsFixed(1)}K / month';
      }
    } else {
      return 'Ks ${toStringAsFixed(0)} / month';
    }
  }

  /// Formats as 'Ks X.Xk' or 'Ks X' (without / month)
  String get toKsShortFormat {
    if (this >= 1000) {
      final double kValue = this / 1000;
      if (kValue % 1 == 0) {
        return 'Ks ${kValue.toInt()}K';
      } else {
        return 'Ks ${kValue.toStringAsFixed(1)}K';
      }
    } else {
      return 'Ks ${toStringAsFixed(0)}';
    }
  }

  /// Formats as 'X.Xk Ks' or 'X Ks' (e.g. for cards or badges)
  String get toKsLabelFormat {
    if (this >= 1000) {
      final double kValue = this / 1000;
      if (kValue % 1 == 0) {
        return '${kValue.toInt()}K Ks';
      } else {
        return '${kValue.toStringAsFixed(1)}K Ks';
      }
    } else {
      return '${toStringAsFixed(0)} Ks';
    }
  }

  /// Formats as 'X.Xk Ks / month' or 'X Ks / month'
  String get toKsMonthlyLabelFormat {
    if (this >= 1000) {
      final double kValue = this / 1000;
      if (kValue % 1 == 0) {
        return '${kValue.toInt()}K Ks / month';
      } else {
        return '${kValue.toStringAsFixed(1)}K Ks / month';
      }
    } else {
      return '${toStringAsFixed(0)} Ks / month';
    }
  }
}
