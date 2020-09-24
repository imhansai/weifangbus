import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        title: AutoSizeText(
          widget.title,
          style: TextStyle(fontSize: ScreenUtil().setSp(45)),
          maxLines: 2,
        ),
      ),
      body: Container(
        child: Center(
          child: Text("线路详情"),
        ),
      ),
    );
  }
}
