import 'package:shared_preferences/shared_preferences.dart';

/// 外观工具类
class ThemeUtil {
  static var prefs;

  static getPrefs() async {
    if (prefs == null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      prefs = sharedPreferences;
    }
    return prefs;
  }

  /// 获取选择的外观值
  static getModelValue() async {
    var prefs = await getPrefs();
    var modelValue = prefs.getInt('model_value') ?? 2;
    return modelValue;
  }

  /// 持久化选择的外观值
  static saveModelValue(int modelValue) async {
    var prefs = await getPrefs();
    prefs.setInt('model_value', modelValue);
  }

  /// 展示外观值
  static modelValue2String(int modelValue) {
    var str;
    switch (modelValue) {
      case 0:
        str = '浅色外观';
        break;
      case 1:
        str = '深色外观';
        break;
      default:
        str = '跟随系统';
    }
    return str;
  }
}
