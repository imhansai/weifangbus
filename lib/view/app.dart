import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/generated/l10n.dart';
import 'package:weifangbus/util/appearance.dart';
import 'package:weifangbus/util/language_util.dart';
import 'package:weifangbus/util/theme_util.dart';
import 'package:weifangbus/view/home.dart';
import 'package:weifangbus/view/store/appearance_provider.dart';
import 'package:weifangbus/view/store/locale_provider.dart';
import 'package:weifangbus/view/store/news_model.dart';

/// 起飞
class WeiFangBusApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeiFangBusApp();
  }
}

class _WeiFangBusApp extends State<WeiFangBusApp> {
  /// 外观
  late Appearance _appearance;

  /// 语言
  late Locale? _locale;

  /// 获取选择的外观与语言
  _getAppearanceAndLanguage() async {
    var appearance = await AppearanceUtil.getAppearance();
    var languagePreference = await LanguageUtil.getLanguagePreference();
    var locale = LanguageUtil.getLocale(languagePreference);
    setState(() {
      _locale = locale;
      _appearance = appearance;
    });
  }

  /// 更改外观
  _changeAppearance(Appearance appearance) {
    if (appearance != null) {
      _appearance = appearance;
    }
  }

  /// 更改语言
  _changeLocale(Locale? locale) {
    if (LocaleProvider.manuallyChangeLanguage) {
      _locale = locale;
    }
  }

  @override
  void initState() {
    super.initState();
    _getAppearanceAndLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 资讯信息
        ChangeNotifierProvider<NewsModel>(
          create: (_) => NewsModel(),
        ),
        // 外观
        ChangeNotifierProvider<AppearanceProvider>(
          create: (_) => AppearanceProvider(),
        ),
        // 语言
        ChangeNotifierProvider<LocaleProvider>(
          create: (_) => LocaleProvider(),
        ),
      ],
      child: Builder(
        builder: (context) {
          var appearance = context.watch<AppearanceProvider>().appearance;
          _changeAppearance(appearance);
          var locale = context.watch<LocaleProvider>().locale;
          _changeLocale(locale);
          return MaterialApp(
            onGenerateTitle: (context) {
              return S.of(context).AppName;
            },
            themeMode: _appearance == Appearance.auto
                ? ThemeMode.system
                : _appearance == Appearance.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            home: Home(),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: _locale,
          );
        },
      ),
    );
  }
}
