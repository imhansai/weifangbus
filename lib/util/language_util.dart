import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/util/sp_util.dart';
import 'package:weifangbus/view/store/locale_provider.dart';

/// 语言工具类
class LanguageUtil {
  /// 存储 key
  static String key = 'language';

  /// 获取选择的语言值
  static Future<LanguagePreference> getLanguagePreference() async {
    var prefs = await SharedPreferencesUtil.getPrefs();
    var languageValue = prefs?.getInt(key);
    return LanguagePreference.values
        .where((element) =>
            element.index == (languageValue ?? LanguagePreference.auto.index))
        .single;
  }

  /// 持久化选择的语言
  static saveLanguageValue(LanguagePreference languagePreference) async {
    var prefs = await SharedPreferencesUtil.getPrefs();
    prefs?.setInt(key, languagePreference.index);
  }

  /// 展示语言值
  static languageString(
      BuildContext context, LanguagePreference languagePreference) {
    var str;
    switch (languagePreference) {
      case LanguagePreference.auto:
        str = AppLocalizations.of(context)!.auto;
        break;
      case LanguagePreference.en:
        str = AppLocalizations.of(context)!.english;
        break;
      case LanguagePreference.zh:
        str = AppLocalizations.of(context)!.chinese;
        break;
      case LanguagePreference.ja:
        str = AppLocalizations.of(context)!.japanese;
        break;
    }
    return str;
  }

  /// 设置语言
  static setLanguage(
      BuildContext context, LanguagePreference languagePreference) {
    var str = languageString(context, languagePreference);
    print('语言切换至: $str');
    var locale;
    switch (languagePreference) {
      case LanguagePreference.auto:
        locale = null;
        break;
      case LanguagePreference.en:
        locale = Locale.fromSubtags(languageCode: 'en');
        break;
      case LanguagePreference.zh:
        locale = Locale.fromSubtags(languageCode: 'zh');
        break;
      case LanguagePreference.ja:
        locale = Locale.fromSubtags(languageCode: 'ja');
        break;
    }
    context
        .read<LocaleProvider>()
        .setLocale(locale);
  }

  /// 根据 [LanguagePreference] 获取 [Locale]
  static Locale? getLocale(LanguagePreference languagePreference) {
    switch (languagePreference) {
      case LanguagePreference.auto:
        return null;
      case LanguagePreference.en:
        return Locale.fromSubtags(languageCode: 'en');
      case LanguagePreference.zh:
        return Locale.fromSubtags(languageCode: 'zh');
      case LanguagePreference.ja:
        return Locale.fromSubtags(languageCode: 'ja');
      default:
        return null;
    }
  }

  /// 根据 [Locale] 获取 [LanguagePreference]
  static LanguagePreference getLanguage(Locale locale) {
    if (locale == Locale.fromSubtags(languageCode: 'en')) {
      return LanguagePreference.en;
    } else if (locale == Locale.fromSubtags(languageCode: 'zh')) {
      return LanguagePreference.zh;
    } else if (locale == Locale.fromSubtags(languageCode: 'ja')) {
      return LanguagePreference.ja;
    } else {
      return LanguagePreference.auto;
    }
  }
}

/// 语言首选项
enum LanguagePreference {
  /// 跟随系统
  auto,

  /// 英文
  en,

  /// 中文
  zh,

  /// 日本语
  ja,
}
