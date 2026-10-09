import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entity/user/user_entity.dart';
import '../../../domain/enum/role.dart';
import 'package:rental_room/data/data.dart';

@lazySingleton
class AppStorage {
  final SharedPreferences _prefs;

  AppStorage(this._prefs);

  static const String _keyIsNewInstall = 'is_new_install';
  static const String _keyUser = 'saved_user_info';
  static const String _keyThemeMode = 'theme_mode';

  // --- Synchronous Getters ---

  bool get isNewInstall => _prefs.getBool(_keyIsNewInstall) ?? true;

  ThemeMode get themeMode {
    final modeStr = _prefs.getString(_keyThemeMode);
    if (modeStr == 'dark') return ThemeMode.dark;
    return ThemeMode.light;
  }

  UserEntity? get savedUserInfo {
    final jsonStr = _prefs.getString(_keyUser);
    if (jsonStr == null || jsonStr.isEmpty) return null;
    try {
      final map = jsonDecode(jsonStr) as Map<String, dynamic>;
      return UserModel.fromMap(map, map['id'] as String? ?? '').toEntity();
    } catch (_) {
      return null;
    }
  }

  // --- Async Setters ---

  Future<void> setIsNewInstall(bool value) async {
    await _prefs.setBool(_keyIsNewInstall, value);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(_keyThemeMode, mode == ThemeMode.dark ? 'dark' : 'light');
  }

  Future<void> saveUserInfo(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    final map = {
      'id': userModel.id,
      'name': userModel.name,
      'email': userModel.email,
      'phoneNumber': userModel.phoneNumber,
      'image': userModel.image,
      'role': userModel.role.value,
      'createdAt': userModel.createdAt.toIso8601String(),
      'lastLogin': userModel.lastLogin.toIso8601String(),
    };
    await _prefs.setString(_keyUser, jsonEncode(map));
  }

  Future<void> torchAllLocalUserData() async {
    await _prefs.remove(_keyUser);
  }
}