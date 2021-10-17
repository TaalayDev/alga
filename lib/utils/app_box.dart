import 'dart:ui';

import 'package:alga/models/token.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppBox {
  static const _defaultBox = 'algaAppBox';
  static const TOKEN_KEY = 'token';
  static const PHONE_KEY = 'phone';
  static const ABOUT_KEY = 'about_text';
  static const IS_LOGIN_KEY = 'is_login';
  static const NOTIFICATION_ENABLED_KEY = 'notification_enabled';
  static const _LANG_KEY = 'language_code';
  static const _LOCALE_KEY = 'locale_code';

  static Future<void> init() async {
    await Hive.initFlutter();

    _registerAdapters();
    await Hive.openBox(_defaultBox);
  }

  static void _registerAdapters() {
    Hive.registerAdapter(TokenAdapter());
  }

  static Token get token => _get<Token>(TOKEN_KEY) ?? Token();
  static set token(Token val) => _put(TOKEN_KEY, val);

  static String get phone => _get<String>(PHONE_KEY) ?? '';
  static set phone(String val) => _put(PHONE_KEY, val);

  static String get aboutText => _get<String>(ABOUT_KEY) ?? '';
  static set aboutText(String val) => _put(ABOUT_KEY, val);

  static bool get isLogin => _get<bool>(IS_LOGIN_KEY) ?? false;
  static set isLogin(bool val) => _put(IS_LOGIN_KEY, val);

  static String? get _languageCode => _get(_LANG_KEY);
  static set _languageCode(String? val) => _put(_LANG_KEY, val);
  static String? get _localeCode => _get(_LOCALE_KEY);
  static set _localeCode(String? val) => _put(_LOCALE_KEY, val);

  static Locale? get locale => _languageCode != null && _localeCode != null
      ? Locale(_languageCode ?? '', _localeCode)
      : null;
  static set locale(Locale? val) {
    _languageCode = val?.languageCode;
    _localeCode = val?.countryCode;
  }

  static String get identifier => _get('identifier');
  static set identifier(String val) => _put('identifier', val);

  static bool get fcmEnabled => _get(NOTIFICATION_ENABLED_KEY) ?? true;
  static set fcmEnabled(bool val) => _put(NOTIFICATION_ENABLED_KEY, val);

  static _put(String name, val) => Hive.box(_defaultBox).put(name, val);
  static T? _get<T>(String name) => Hive.box(_defaultBox).get(name) as T;

  static listen(String key, Function() listener) {
    Hive.box(_defaultBox).listenable(keys: [key]).addListener(listener);
  }

  static removeListener(String key, Function() listener) {
    Hive.box(_defaultBox).listenable(keys: [key]).removeListener(listener);
  }
}
