import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weifangbus/view/app.dart';

/// 入口方法，设置竖屏
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool showIntro = prefs.getBool('show_intro') ?? true;

  runApp(WeiFangBusApp(showIntro: showIntro));
}
