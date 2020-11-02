import 'package:shared_preferences/shared_preferences.dart';

/// 数据存储类
class SharedPreferencesUtil {
  static SharedPreferences prefs;

  static Future<SharedPreferences> getPrefs() async {
    if (prefs == null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      prefs = sharedPreferences;
    }
    return prefs;
  }
}
