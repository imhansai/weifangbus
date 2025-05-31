import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/util/appearance.dart';
import 'package:weifangbus/util/language_util.dart';
import 'package:weifangbus/util/theme_util.dart';
import 'package:weifangbus/view/home.dart';
import 'package:weifangbus/view/home/guide/guide.dart';
import 'package:weifangbus/view/home/news/news_list.dart';
import 'package:weifangbus/view/intro/Intro.dart';
import 'package:weifangbus/view/store/appearance_provider.dart';
import 'package:weifangbus/view/store/locale_provider.dart';
import 'package:weifangbus/view/store/news_model.dart';

/// 设置 Provider
class WeiFangBusApp extends StatefulWidget {
  final bool showIntro;

  const WeiFangBusApp({super.key, required this.showIntro});

  @override
  State<StatefulWidget> createState() {
    return _WeiFangBusApp();
  }
}

class _WeiFangBusApp extends State<WeiFangBusApp> {
  /// 外观
  Appearance _appearance = Appearance.auto;

  /// 语言
  Locale? _locale;

  /// 获取选择的外观
  _getAppearanceAndLanguage() async {
    var appearance = await AppearanceUtil.getAppearance();
    var languagePreference = await LanguageUtil.getLanguagePreference();
    var locale = LanguageUtil.getLocale(languagePreference);
    setState(() {
      _locale = locale;
    });
    if (_appearance != appearance) {
      setState(() {
        _appearance = appearance;
      });
    }
  }

  /// 更改外观
  _changeAppearance(Appearance? appearance) {
    if (appearance != null && _appearance != appearance) {
      _appearance = appearance;
    }
  }

  /// 更改语言
  _changeLocale(Locale? locale) {
    if (LocaleProvider.manuallyChangeLanguage && _locale != locale) {
      _locale = locale;
    }
  }

  @override
  void initState() {
    super.initState();
    // 强制竖屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
              return AppLocalizations.of(context)!.appName;
            },
            themeMode: _appearance == Appearance.auto
                ? ThemeMode.system
                : _appearance == Appearance.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
            theme: ThemeData(
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark(
              useMaterial3: true,
            ),
            home: widget.showIntro ? IntroPage() : Home(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: _locale,
            routes: {
              '/home': (context) => Home(),
              '/guide': (context) => Guide(),
              '/newsList': (context) => NewsListPage(),
            },
          );
        },
      ),
    );
  }
}
