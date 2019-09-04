import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weifangbus/view/app.dart';

void main() {
  // 强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(WeiFangBusApp());
  });
}
