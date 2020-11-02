import 'package:weifangbus/util/appearance.dart';
import 'package:weifangbus/util/sp_util.dart';

/// 外观工具类
class AppearanceUtil {
  /// 存储的key
  static var key = 'appearance';

  /// 获取选择的外观
  static Future<Appearance> getAppearance() async {
    var prefs = await SharedPreferencesUtil.getPrefs();
    var value = prefs.getInt(key);
    return Appearance.values
        .where((element) => element.index == (value ?? Appearance.auto.index))
        .single;
  }

  /// 持久化选择的外观
  static void saveAppearance(Appearance appearance) async {
    var prefs = await SharedPreferencesUtil.getPrefs();
    prefs.setInt(key, appearance.index);
  }

  /// 展示外观
  static String appearanceStr(Appearance appearance) {
    var str;
    switch (appearance) {
      case Appearance.light:
        str = '浅色模式';
        break;
      case Appearance.dark:
        str = '暗黑模式';
        break;
      case Appearance.auto:
        str = '跟随系统';
    }
    return str;
  }
}
