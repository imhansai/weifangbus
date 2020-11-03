import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/generated/l10n.dart';
import 'package:weifangbus/util/appearance.dart';
import 'package:weifangbus/util/language_util.dart';
import 'package:weifangbus/util/theme_util.dart';
import 'package:weifangbus/view/more/settings/language_settings.dart';
import 'package:weifangbus/view/more/settings/theme_manager.dart';
import 'package:weifangbus/view/store/appearance_provider.dart';
import 'package:weifangbus/view/store/locale_provider.dart';

/// 设置页
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  /// 外观
  Appearance _appearance = Appearance.auto;

  /// 语言
  LanguagePreference _languagePreference = LanguagePreference.auto;

  @override
  Widget build(BuildContext context) {
    print('开始构建');
    var appearance = context.watch<AppearanceProvider>().appearance;
    var locale = context.watch<LocaleProvider>().locale;
    print('locale: $locale');
    if (locale != null) {
      var languagePreference = LanguageUtil.getLanguage(locale);
      if (languagePreference != null) {
        _languagePreference = languagePreference;
      }
    } else {
      if (LocaleProvider.manuallyChangeLanguage) {
        _languagePreference = LanguagePreference.auto;
      }
    }
    if (appearance != null) {
      _appearance = appearance;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              leading: Icon(
                Icons.nights_stay,
                color: Colors.blue,
              ),
              title: Text('外观管理'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AppearanceManager();
                    },
                  ),
                );
              },
              trailing: Text(AppearanceUtil.appearanceStr(_appearance)),
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.teal,
              ),
              title: Text(S.of(context).LanguageSettings),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LanguageSettings();
                    },
                  ),
                );
              },
              trailing: Text(LanguageUtil.languageString(_languagePreference)),
            ),
          ],
        ).toList(),
      ),
    );
  }

  /// 获取外观和语言
  _getAppearance() async {
    var appearance = await AppearanceUtil.getAppearance();
    print('appearance: $appearance');
    setState(() {
      _appearance = appearance;
    });
  }

  _getLanguage() async {
    var languagePreference = await LanguageUtil.getLanguagePreference();
    print('languagePreference: $languagePreference');
    setState(() {
      _languagePreference = languagePreference;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAppearance();
    _getLanguage();
  }
}