import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
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
    var appearance = context.watch<AppearanceProvider>().appearance;
    var locale = context.watch<LocaleProvider>().locale;
    if (locale != null) {
      var languagePreference = LanguageUtil.getLanguage(locale);
      _languagePreference = languagePreference;
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
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.nights_stay,
              color: Colors.blue,
            ),
            title: Text(AppLocalizations.of(context)!.appearanceManagement),
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
            trailing: Text(AppearanceUtil.appearanceStr(context, _appearance)),
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.teal,
            ),
            title: Text(AppLocalizations.of(context)!.languageSettings),
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
            trailing: Text(LanguageUtil.languageString(context, _languagePreference)),
          ),
        ],
      ),
    );
  }

  /// 获取外观和语言
  _getAppearance() async {
    var appearance = await AppearanceUtil.getAppearance();
    setState(() {
      _appearance = appearance;
    });
  }

  _getLanguage() async {
    var languagePreference = await LanguageUtil.getLanguagePreference();
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
