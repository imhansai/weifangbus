import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
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
  ScrollController _controller = ScrollController();
  bool showToTopBtn = false; // 是否显示“返回到顶部”按钮

  @override
  void initState() {
    super.initState();
    // 监听滚动事件，打印滚动位置
    _controller.addListener(() {
      // 打印滚动位置
      // print('偏移量::: ' + _controller.offset.toString());
      if (_controller.offset < 60 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 60 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // 为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

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
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(0),
                          ScreenUtil().setHeight(31),
                          ScreenUtil().setWidth(0),
                          ScreenUtil().setHeight(0),
                        ),
                        child: Text(
                          '发布时间: ' +
                              DateFormat("yyyy年MM月dd日 HH点mm分ss秒")
                                  .format(DateTime.parse(widget.headLine.realeasedatetime))
                                  .toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: ScreenUtil().setSp(38),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 利用 Expanded 使用剩余全部空间，然后里面使用 SingleChildScrollView 防止溢出
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(40),
                  ScreenUtil().setHeight(10),
                  ScreenUtil().setWidth(40),
                  ScreenUtil().setHeight(200),
                ),
                child: HtmlWidget(widget.headLine.content),
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              tooltip: "返回顶部",
              onPressed: () {
                // 返回到顶部时执行动画
                _controller.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
            ),
    );
  }
}
