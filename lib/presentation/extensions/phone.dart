import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/services/snack_shower.dart';
import '../../di/injector.dart';

extension PhoneCallExtension on String {
  Future<void> makeCall({BuildContext? context, ISnackShower? snackShower}) async {
    final uri = Uri.parse('tel:$this');
    final shower = snackShower ?? inject<ISnackShower>();
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        shower.error(
          context: context,
          message: 'Could not launch call for $this',
        );
      }
    } catch (e) {
      shower.error(
        context: context,
        message: 'Error making call: $e',
      );
    }
  }
}
