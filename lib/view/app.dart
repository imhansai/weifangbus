import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/view/home.dart';
import 'package:weifangbus/view/store/NewsListModel.dart';

/// 设置极光推送及 Provider
class WeiFangBusApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeiFangBusApp();
  }
}

class _WeiFangBusApp extends State<WeiFangBusApp> {
  String debugLable = 'Unknown';
  final JPush jpush = new JPush();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => NewsListModel()),
      ],
      child: Consumer(
        builder: (context, NewsListModel _showNewsList, _) {
          return MaterialApp(
            title: "潍坊公交",
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Home(),
          );
        },
      ),
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

    // Platform messages may fail, so we use a try/catch PlatformException.
    // 获取 registrationId，这个 JPush 运行通过 registrationId 来进行推送.
    jpush.getRegistrationID().then((rid) {
      setState(() {
        debugLable = "flutter getRegistrationID: $rid";
      });
    });

    jpush.setup(
      appKey: "f0ac3212b863478a3ee578d5",
      channel: "theChannel",
      production: false,
      debug: true, // 设置是否打印 debug 日志
    );
    // 申请推送权限，注意这个方法只会向用户弹出一次推送权限请求（如果用户不同意，之后只能用户到设置页面里面勾选相应权限），需要开发者选择合适的时机调用。
    // 注意： iOS10+ 可以通过该方法来设置推送是否前台展示，是否触发声音，是否设置应用角标 badge
    jpush.applyPushAuthority(new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    try {
      // 添加事件监听方法
      jpush.addEventHandler(
        // 接收通知回调方法
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
          setState(() {
            debugLable = "flutter onReceiveNotification: $message";
          });
        },
        // 点击通知回调方法
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");
          setState(() {
            debugLable = "flutter onOpenNotification: $message";
          });
        },
        // 接收自定义消息回调方法
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
          setState(() {
            debugLable = "flutter onReceiveMessage: $message";
          });
        },
      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      debugLable = platformVersion;
    });
  }
}
