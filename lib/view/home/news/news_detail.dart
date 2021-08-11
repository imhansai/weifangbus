import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weifangbus/entity/headline_entity.dart';
import 'package:weifangbus/generated/l10n.dart';

class InformationDetail extends StatefulWidget {
  final Headline headLine;

  const InformationDetail({Key? key, required this.headLine}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InformationDetail();
  }
}

class _InformationDetail extends State<InformationDetail> {
  ScrollController _controller = ScrollController();

  // 是否显示“返回到顶部”按钮
  bool showToTopBtn = false;

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
        title: Text(S.of(context).NewsDetail),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) => Container(
          child: Column(
            children: <Widget>[
              // 利用 Expanded 使用剩余全部空间，然后里面使用 SingleChildScrollView 防止溢出
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    orientation == Orientation.portrait ? 40.w : 20.w,
                    orientation == Orientation.portrait ? 10.h : 20.h,
                    orientation == Orientation.portrait ? 40.w : 20.w,
                    orientation == Orientation.portrait ? 200.h : 400.h,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(
                            orientation == Orientation.portrait ? 70.w : 35.w),
                        child: Column(
                          children: <Widget>[
                            Text(
                              widget.headLine.title,
                              style: TextStyle(
                                fontSize: orientation == Orientation.portrait
                                    ? 53.ssp
                                    : 26.ssp,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: orientation == Orientation.portrait
                                    ? 31.h
                                    : 62.h,
                              ),
                              child: Text(
                                S.of(context).ReleaseTime +
                                    DateFormat(S.of(context).NewsDetailDate)
                                        .format(DateTime.parse(
                                            widget.headLine.realeasedatetime))
                                        .toString(),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: orientation == Orientation.portrait
                                      ? 38.ssp
                                      : 19.ssp,
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
                            fontSize: FontSize(
                              orientation == Orientation.portrait
                                  ? 50.ssp
                                  : 25.ssp,
                            ),
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
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              tooltip: S.of(context).BackToTop,
              onPressed: () {
                // 返回到顶部时执行动画
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
            ),
    );
  }
}
