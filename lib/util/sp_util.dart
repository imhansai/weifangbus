import 'package:shared_preferences/shared_preferences.dart';

/// 数据存储类
class SharedPreferencesUtil {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences?> getPrefs() async {
    if (_prefs == null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      _prefs = sharedPreferences;
    }
    return _prefs;
  }
}
