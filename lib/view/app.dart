import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/util/appearance.dart';
import 'package:weifangbus/util/theme_util.dart';
import 'package:weifangbus/view/home.dart';
import 'package:weifangbus/view/store/appearance_provider.dart';
import 'package:weifangbus/view/store/news_model.dart';

/// 设置 Provider
class WeiFangBusApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeiFangBusApp();
  }
}

class _WeiFangBusApp extends State<WeiFangBusApp> {
  /// 外观
  Appearance _appearance = Appearance.auto;

  /// 获取选择的外观值
  _getAppearance() async {
    var appearance = await AppearanceUtil.getAppearance();
    if (appearance != null && _appearance != appearance) {
      setState(() {
        _appearance = appearance;
      });
    }
  }

  /// 更改外观
  _changeAppearance(Appearance appearance) {
    if (appearance != null && _appearance != appearance) {
      _appearance = appearance;
    }
  }

  @override
  void initState() {
    super.initState();
    // 强制竖屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _getAppearance();
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
      ],
      child: Builder(
        builder: (context) {
          Appearance appearance =
              context.watch<AppearanceProvider>().appearance;
          _changeAppearance(appearance);
          return _appearance == Appearance.auto
              ? MaterialApp(
                  title: "潍坊公交",
                  theme: ThemeData(),
                  darkTheme: ThemeData.dark(),
                  home: Home(),
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: [
                    const Locale.fromSubtags(languageCode: 'zh'),
                  ],
                  locale: Locale.fromSubtags(languageCode: 'zh'),
                )
              : MaterialApp(
                  title: "潍坊公交",
                  theme: _appearance == Appearance.dark
                      ? ThemeData.dark()
                      : ThemeData(),
                  home: Home(),
                  localizationsDelegates: [
                    // 本地化的代理类
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: [
                    const Locale.fromSubtags(languageCode: 'zh'),
                  ],
                  locale: Locale.fromSubtags(languageCode: 'zh'),
                );
        },
      ),
    );
  }
}
