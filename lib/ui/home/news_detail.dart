import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:weifangbus/entity/home/startUpBasicInfo_entity.dart';

class InformationDetail extends StatefulWidget {
  final Headline headLine;

  const InformationDetail({Key key, this.headLine}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InformationDetail();
  }
}

class _InformationDetail extends State<InformationDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("资讯详情"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(35)),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(
                          ScreenUtil().setWidth(2),
                          ScreenUtil().setWidth(2),
                        ),
                        blurRadius: 4.0),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(35)),
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.headLine.title,
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: ScreenUtil().setSp(53),
                        ),
                      ),
                      Text(
                        '发布时间: ' + widget.headLine.realeasedatetime,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: ScreenUtil().setSp(38),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(40),
                vertical: ScreenUtil().setHeight(10),
              ),
              child: HtmlWidget(widget.headLine.content),
            ),
          ],
        ),
      ),
    );
  }
}
