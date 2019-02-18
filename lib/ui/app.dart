import 'package:flutter/material.dart';
import 'package:weifangbus/ui/home.dart';

class WeiFangBusApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeiFangBusApp();
  }
}

class _WeiFangBusApp extends State<WeiFangBusApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "潍坊公交",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
