import 'package:flutter/material.dart';

/// 语言
class LocaleProvider extends ChangeNotifier {
  /// 是否手动切换语言
  static bool manuallyChangeLanguage = false;

  late Locale? _locale;

  Locale? get locale => _locale;

  setLocale(Locale? locale) {
    if (_locale != locale) {
      manuallyChangeLanguage = true;
      _locale = locale;
      notifyListeners();
    }
  }
}
