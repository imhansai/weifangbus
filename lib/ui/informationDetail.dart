import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:weifangbus/entity/startUpBasicInfo_entity.dart';

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
      body: new HtmlWidget(widget.headLine.content),
    );
  }
}
