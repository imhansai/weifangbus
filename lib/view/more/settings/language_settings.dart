import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';
import 'package:weifangbus/util/language_util.dart';

class LanguageSettings extends StatefulWidget {
  @override
  _LanguageSettingsState createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  LanguagePreference _languagePreference = LanguagePreference.auto;

  /// 获取语言
  _getLanguage() async {
    var languagePreference = await LanguageUtil.getLanguagePreference();
    setState(() {
      _languagePreference = languagePreference;
    });
  }

  /// 展示和设置语言
  _showAndSetLanguage(
      BuildContext context, LanguagePreference languagePreference) {
    LanguageUtil.setLanguage(context, languagePreference);
    LanguageUtil.saveLanguageValue(languagePreference);
    setState(() {
      _languagePreference = languagePreference;
    });
  }

  @override
  Widget build(BuildContext context) {
    var tiles = LanguagePreference.values
        .map((e) => ListTile(
              title: Text(
                LanguageUtil.languageString(context, e),
              ),
              onTap: () {
                _showAndSetLanguage(context, e);
              },
              trailing: _languagePreference == e
                  ? Text(AppLocalizations.of(context)!.selected)
                  : SizedBox(),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.languageSettings),
      ),
      body: ListView(
        children: tiles,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getLanguage();
  }
}
