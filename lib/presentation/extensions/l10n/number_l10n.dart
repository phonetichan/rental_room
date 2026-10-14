import 'package:flutter/widgets.dart';

extension NumberL10nX on BuildContext {
  bool get isMyanmar => Localizations.localeOf(this).languageCode == 'my';

  /// Converts digits in [value] to Myanmar numerals if the app locale is Myanmar.
  /// 4 -> "၄" (mm) or "4" (en); "4+" -> "၄+" or "4+"
  String localizedNumber(Object value) {
    final text = value.toString();
    if (!isMyanmar) return text;

    const mmDigits = ['၀', '၁', '၂', '၃', '၄', '၅', '၆', '၇', '၈', '၉'];
    return text.replaceAllMapped(
      RegExp(r'\d'),
          (m) => mmDigits[int.parse(m[0]!)],
    );
  }
}
