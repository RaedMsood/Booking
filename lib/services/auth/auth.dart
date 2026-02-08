import 'dart:convert';
import 'dart:developer';
import 'package:booking/features/properties/cities/data/model/city_model.dart';
import 'package:flutter/cupertino.dart';

import '../../core/local/secure_storage.dart';
import '../../features/user/data/model/auth_model.dart';
import '../../injection.dart';

class Auth {
  factory Auth() {
    _instance ??= Auth._();

    return _instance!;
  }

  final String _key = 'user';
  final WingsSecureStorage secureStorage = sl<WingsSecureStorage>();

  Auth._() {
    onInit();
  }

  Future<void> onInit() async {
    try {
      var read = await secureStorage.read(
        key: _key,
      );

      if (read != null) {
        Map<String, dynamic> map = jsonDecode(read);
        AuthModel authModel = AuthModel.fromJson(map);
        user = authModel;
      }
      debugPrint("token: ${user.token}");
    } catch (ex) {
      throw '$ex';
    }
  }

  static Auth? _instance;

  AuthModel user = AuthModel.empty();

  bool get loggedIn => user.token.isNotEmpty;

  String get token => user.token;

  String get name => user.user.name;

  String get phoneNumber => user.user.phoneNumber;

  String get email => user.user.email;

  String get gender => user.user.gender;

  String? get date => user.user.birthDay;

  /// Nullable-safe city getter.
  ///
  /// City can be null for new users or when cache hasn't been populated yet.
  CityModel? get city => user.user.city;

  Future<void> login(AuthModel data) async {
    user = data;
    _writeToCache();
  }

  _writeToCache() {
    final cacheMap = user.toJsonForCache();
    log(jsonEncode(cacheMap), name: 'user');
    secureStorage.write(key: _key, value: jsonEncode(cacheMap));
  }

  Future logout() async {
    await secureStorage.delete(key: 'fcmToken');
    user = AuthModel.empty();
    await secureStorage.delete(key: _key);
  }

  Future<void> setLanguage(String languageCode) async {
    await secureStorage.write(key: "LANGUAGE", value: languageCode);
  }

  Future<String> getLanguage() async {
    final language = await secureStorage.read(key: "LANGUAGE");
    return language ?? "ar";
  }

  Future<void> cacheOnBoarding(bool value) async {
    await secureStorage.write(key: "SPLASH_SCREEN", value: jsonEncode(value));
  }

  Future<bool> getOnBoarding() async {
    final fingerprintValue = await secureStorage.read(key: "SPLASH_SCREEN");
    if (fingerprintValue != null) {
      return jsonDecode(fingerprintValue) as bool;
    }
    return false;
  }

  Future<void> updateUserData({
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? birthDay,
    CityModel? city,
  }) async {
    final updatedUser = user.user.copyWith(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      gender: gender,
      birthDay: birthDay,
      city: city,
    );

    user = user.copyWith(user: updatedUser);

    _writeToCache();
  }

  Future<void> setFcmToken(String fcmToken) async {
    await secureStorage.write(key: "fcm_token", value: fcmToken);
  }

  Future<String> getFcmToken() async {
    final fcmToken = await secureStorage.read(key: "fcm_token");
    return fcmToken ?? "";
  }
}
