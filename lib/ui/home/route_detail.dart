import 'package:flutter/material.dart';

class RouteDetail extends StatefulWidget {
  @override
  _RouteDetailState createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("线路详情"),
      ),
      body: Container(
        child: Center(
          child: Text("线路详情"),
        ),
      ),
    );
  }
}
