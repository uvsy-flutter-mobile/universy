import 'package:flutter/material.dart';
import 'package:universy/system/locale.dart';

import 'i18n.dart';

class AppText {
  static AppText instance;

  Map<dynamic, dynamic> _localizedValues;
  Locale _locale;

  AppText(this._locale, this._localizedValues);

  static AppText getInstance() {
    if (hasSystemLocaleChanged() || instance == null) {
      Locale systemLocale = SystemLocale.getSystemLocale();
      Map<dynamic, dynamic> localizedValues = I18N[systemLocale.languageCode];

      instance = AppText(systemLocale, localizedValues);
    }
    return instance;
  }

  String get(String resources) {
    List<String> keys = resources.split(".");
    return _find(_localizedValues, keys);
  }

  String _find(Map<dynamic, dynamic> map, List<String> keys) {
    var value = map[keys[0]];
    if (value is Map) {
      return _find(value, keys.sublist(1));
    } else if (value is String) {
      return value;
    } else {
      throw Exception("The text resource could not be found. "
          "Check i18n_${_locale.languageCode}.dart file.");
    }
  }

  static bool hasSystemLocaleChanged() {
    if (instance != null) {
      return instance._locale.languageCode !=
          SystemLocale.getSystemLocale().languageCode;
    }
    return false;
  }
}
