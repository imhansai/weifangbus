import 'package:flutter/material.dart';
import 'package:weifangbus/ui/app.dart';
import 'package:flutter/services.dart';

void main() {
  // 强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(WeiFangBusApp());
  });
}
