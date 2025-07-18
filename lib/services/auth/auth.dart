import 'dart:convert';
import 'dart:developer';
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

  void onInit() async {
    try {
      var read = await secureStorage.read(
        key: _key,
      );

      if (read != null) {
        Map<String, dynamic> map = jsonDecode(read);
        AuthModel authModel = AuthModel.fromJson(map);
        user = authModel;
      }
       print("token: ${user.token}");


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

  Future<void> login(AuthModel data) async {
    user = data;
    _writeToCache();
  }

  _writeToCache() {
    log(jsonEncode(user), name: 'user');
    secureStorage.write(key: _key, value: jsonEncode(user));
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

  Future<void> setCurrency(String currencyCode) async {
    await secureStorage.write(key: "CURRENCY", value: currencyCode);
  }

  Future<String> getCurrency() async {
    final language = await secureStorage.read(key: "CURRENCY");
    return language ?? "YER";
  }
}
