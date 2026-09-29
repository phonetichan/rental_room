extension NumberFormatting on num {
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
}
