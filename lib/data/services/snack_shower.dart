import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../l10n/app_localizations.dart';
import '../../presentation/navigation/navigation_key_provider.dart';
import '../../presentation/prompt/snacks.dart';

abstract interface class ISnackShower {
  void info({BuildContext? context, required String message, SnackGravity gravity = SnackGravity.top});

  void error({BuildContext? context, required String message, SnackGravity gravity = SnackGravity.top});

  void success({BuildContext? context, required String message, SnackGravity gravity = SnackGravity.top});
}

@LazySingleton(as: ISnackShower)
class SnackShowerImpl implements ISnackShower {
  final INavigationKeyProvider _navKeyProvider;

  SnackShowerImpl(this._navKeyProvider);

  String _localizeMessage(BuildContext ctx, String message) {
    final l10n = AppLocalizations.of(ctx);
    if (l10n == null) return message;

    final trimmed = message.trim();
    if (trimmed == 'User session not found.') {
      return l10n.userSessionNotFound;
    }
    if (trimmed == 'Password updated successfully! Please log in again.' ||
        trimmed == 'Password updated successfully!') {
      return l10n.passwordUpdatedSuccessfully;
    }
    if (trimmed == 'Profile updated successfully!') {
      return l10n.profileUpdatedSuccessfully;
    }
    if (trimmed == 'Location updated successfully' ||
        trimmed == 'Location updated successfully!') {
      return l10n.locationUpdatedSuccessfully;
    }
    if (trimmed == 'Please accept the Terms & Conditions to proceed.') {
      return l10n.pleaseAcceptTerms;
    }
    if (trimmed == 'Passwords do not match') {
      return l10n.passwordsDoNotMatch;
    }
    if (trimmed == 'Room created successfully!') {
      return l10n.roomCreatedSuccessfully;
    }
    if (trimmed == 'Room updated successfully!') {
      return l10n.roomUpdatedSuccessfully;
    }
    if (trimmed == 'Room deleted successfully!') {
      return l10n.roomDeletedSuccessfully;
    }
    if (trimmed == 'Booking request created successfully!') {
      return l10n.bookingCreatedSuccessfully;
    }
    if (trimmed == 'Booking updated successfully!') {
      return l10n.bookingUpdatedSuccessfully;
    }
    if (trimmed == 'Booking request is successfully deleted!') {
      return l10n.bookingDeletedSuccessfully;
    }
    if (trimmed == 'Contract created successfully!') {
      return l10n.contractCreatedSuccessfully;
    }
    if (trimmed == 'Contract updated successfully!') {
      return l10n.contractUpdatedSuccessfully;
    }
    if (trimmed == 'Owners cannot favorite their own rooms.') {
      return l10n.ownersCannotFavoriteOwnRooms;
    }
    if (trimmed == 'This phone number is already registered by another user.') {
      return l10n.thisPhoneAlreadyRegistered;
    }
    if (trimmed == 'The current password you entered is incorrect.') {
      return l10n.currentPasswordIncorrect;
    }
    if (trimmed.contains('invalid-credential') ||
        trimmed.contains('user-not-found') ||
        trimmed.contains('wrong-password')) {
      return l10n.invalidEmailOrPassword;
    }
    if (trimmed.contains('email-already-in-use')) {
      return l10n.emailAlreadyInUse;
    }
    if (trimmed == 'Please complete Phone Contact first.') {
      return l10n.pleaseCompletePhoneContactFirst;
    }
    if (trimmed == 'Please complete Room Visited first.') {
      return l10n.pleaseCompleteRoomVisitedFirst;
    }
    if (trimmed == 'Booking request is already submitted and cannot be changed.') {
      return l10n.bookingAlreadySubmitted;
    }
    if (trimmed == 'Voucher saved to Gallery successfully!') {
      return l10n.voucherSavedSuccessfully;
    }
    if (trimmed == 'Failed to save voucher.') {
      return l10n.failedToSaveVoucher;
    }
    if (trimmed == 'Phone call done') {
      return l10n.phoneCallDone;
    }
    if (trimmed == 'Visit done') {
      return l10n.visitDone;
    }

    return message;
  }

  @override
  void info({BuildContext? context, required String message, SnackGravity gravity = SnackGravity.top}) {
    final ctx = context ?? _navKeyProvider.scaffoldContext ?? _navKeyProvider.globalKey.currentContext;
    if (ctx != null) {
      final localized = _localizeMessage(ctx, message);
      Snacks.info(ctx, message: localized, gravity: gravity);
    }
  }

  @override
  void error({BuildContext? context, required String message, SnackGravity gravity = SnackGravity.top}) {
    final ctx = context ?? _navKeyProvider.scaffoldContext ?? _navKeyProvider.globalKey.currentContext;
    if (ctx != null) {
      final localized = _localizeMessage(ctx, message);
      Snacks.error(ctx, message: localized, gravity: gravity);
    }
  }

  @override
  void success({BuildContext? context, required String message, SnackGravity gravity = SnackGravity.top}) {
    final ctx = context ?? _navKeyProvider.scaffoldContext ?? _navKeyProvider.globalKey.currentContext;
    if (ctx != null) {
      final localized = _localizeMessage(ctx, message);
      Snacks.success(ctx, message: localized, gravity: gravity);
    }
  }
}
