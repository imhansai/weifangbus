import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/util/theme_util.dart';
import 'package:weifangbus/view/home.dart';
import 'package:weifangbus/view/store/news_model.dart';
import 'package:weifangbus/view/store/theme_provider.dart';

/// 设置 Provider
class WeiFangBusApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeiFangBusApp();
  }
}

class _WeiFangBusApp extends State<WeiFangBusApp> {
  /// 0/浅色 1/深色 2/跟随系统
  int _modelValue;

  /// 获取选择的外观值
  _getModelValue() async {
    var modelValue = await ThemeUtil.getModelValue();
    // print('app 持久化获取外观: $modelValue');
    if (_modelValue == null || _modelValue != modelValue) {
      // print('app 持久化设置外观: $modelValue 原外观: $_modelValue');
      setState(() {
        _modelValue = modelValue;
      });
    }
  }

  /// 更改外观
  _changeTheme(int modelValue) {
    // print('app 监听获取外观: $modelValue');
    if (modelValue != null && _modelValue != modelValue) {
      // print('app 监听设置外观: $modelValue 原外观: $_modelValue');
      _modelValue = modelValue;
    }
  }

  @override
  void initState() {
    super.initState();
    // 强制竖屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _getModelValue();
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
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Builder(
        builder: (context) {
          int modelValue = context.watch<ThemeProvider>().modelValue;
          _changeTheme(modelValue);
          // 0/浅色 1/深色 2/跟随系统
          return _modelValue == 2
              ? MaterialApp(
                  title: "潍坊公交",
                  theme: ThemeData(),
                  darkTheme: ThemeData.dark(),
                  home: Home(),
                )
              : MaterialApp(
                  title: "潍坊公交",
                  theme: _modelValue == 1 ? ThemeData.dark() : ThemeData(),
                  home: Home(),
                );
        },
      ),
    );
  }
}
