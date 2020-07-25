import 'package:flutter/material.dart';

const Locale SPANISH = const Locale("es");

class SystemLocale {
  static Locale _locale;

  static Locale getSystemLocale() {
    return _locale;
  }

  static void setSystemLocale(Locale locale) {
    _locale = locale;
  }
}
