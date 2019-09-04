import 'package:flutter/material.dart';

class RouteDetail extends StatefulWidget {
  final String title;
  final int routeId;

  const RouteDetail({Key key, this.title, this.routeId}) : super(key: key);

  @override
  _RouteDetailState createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Text("线路详情"),
        ),
      ),
    );
  }
}
