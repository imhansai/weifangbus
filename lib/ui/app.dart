import 'package:flutter/material.dart';
import 'package:weifangbus/ui/home.dart';

class WeiFangBusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '潍坊公交',
      home: HomePage(),
    );
  }
}
