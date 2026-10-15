import 'package:flutter/widgets.dart';
import 'package:rental_room/presentation/extensions/l10n/number_l10n.dart';

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

  /// Localized formatting where 'K' means 'သောင်း' in Myanmar locale
  String toLocalizedKsFormat(BuildContext context) {
    final isMyanmar = context.isMyanmar;
    final unit = isMyanmar ? 'သောင်း' : 'K';
    
    if (this >= 1000) {
      final double kValue = this / 1000;
      final valStr = (kValue % 1 == 0) ? kValue.toInt().toString() : kValue.toStringAsFixed(1);
      final localizedVal = context.localizedNumber(valStr);
      if (isMyanmar) {
        return '$localizedVal $unit / လ';
      } else {
        return 'Ks $valStr$unit / month';
      }
    } else {
      final localizedVal = context.localizedNumber(toStringAsFixed(0));
      if (isMyanmar) {
        return '$localizedVal ကျပ် / လ';
      } else {
        return 'Ks $localizedVal / month';
      }
    }
  }

  String toLocalizedKsShortFormat(BuildContext context) {
    final isMyanmar = context.isMyanmar;
    final unit = isMyanmar ? 'သောင်း' : 'K';
    
    if (this >= 1000) {
      final double kValue = this / 1000;
      final valStr = (kValue % 1 == 0) ? kValue.toInt().toString() : kValue.toStringAsFixed(1);
      final localizedVal = context.localizedNumber(valStr);
      if (isMyanmar) {
        return '$localizedVal $unit';
      } else {
        return 'Ks $valStr$unit';
      }
    } else {
      final localizedVal = context.localizedNumber(toStringAsFixed(0));
      if (isMyanmar) {
        return '$localizedVal ကျပ်';
      } else {
        return 'Ks $localizedVal';
      }
    }
  }

  String toLocalizedKsLabelFormat(BuildContext context) {
    final isMyanmar = context.isMyanmar;
    final unit = isMyanmar ? 'သောင်း' : 'K';
    
    if (this >= 1000) {
      final double kValue = this / 1000;
      final valStr = (kValue % 1 == 0) ? kValue.toInt().toString() : kValue.toStringAsFixed(1);
      final localizedVal = context.localizedNumber(valStr);
      if (isMyanmar) {
        return '$localizedVal $unit ကျပ်';
      } else {
        return '$valStr$unit Ks';
      }
    } else {
      final localizedVal = context.localizedNumber(toStringAsFixed(0));
      if (isMyanmar) {
        return '$localizedVal ကျပ်';
      } else {
        return '$localizedVal Ks';
      }
    }
  }
}
