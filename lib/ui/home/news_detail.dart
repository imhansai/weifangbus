import 'package:flutter/material.dart';
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
              padding: EdgeInsets.all(15),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                  boxShadow: [
                    BoxShadow(color: Colors.black54, offset: Offset(2.0, 2.0), blurRadius: 4.0),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.headLine.title,
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '发布时间:' + widget.headLine.realeasedatetime,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: HtmlWidget(widget.headLine.content),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
