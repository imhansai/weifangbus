import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weifangbus/entity/headline_entity.dart';

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
            // 利用 Expanded 使用剩余全部空间，然后里面使用 SingleChildScrollView 防止溢出
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  40.w,
                  10.h,
                  40.w,
                  200.h,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(70.w),
                      child: Column(
                        children: <Widget>[
                          Text(
                            widget.headLine.title,
                            style: TextStyle(
                              fontSize: 53.ssp,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 31.h,
                            ),
                            child: Text(
                              '发布时间: ' +
                                  DateFormat("yyyy年MM月dd日 HH点mm分ss秒")
                                      .format(DateTime.parse(
                                          widget.headLine.realeasedatetime))
                                      .toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 38.ssp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Html(
                      data: widget.headLine.content,
                      style: {
                        "html": Style(
                          fontFamily: 'serif',
                          fontSize: FontSize(50.ssp),
                        )
                      },
                    ),
                  ],
                ),
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
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
            ),
    );
  }
}
