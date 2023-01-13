import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:weifangbus/entity/head_line_entity.dart';

class InformationDetail extends StatefulWidget {
  final HeadLineEntity headLine;

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
        title: Text(AppLocalizations.of(context)!.newsDetail),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // 利用 Expanded 使用剩余全部空间，然后里面使用 SingleChildScrollView 防止溢出
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  40,
                  10,
                  40,
                  200,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(70),
                      child: Column(
                        children: <Widget>[
                          Text(
                            widget.headLine.Title!,
                            style: TextStyle(
                              fontSize: 53,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 31,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.releaseTime +
                                  DateFormat(AppLocalizations.of(context)!
                                          .newsDetailDate)
                                      .format(DateTime.parse(
                                          widget.headLine.RealeaseDateTime!))
                                      .toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 38,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    HtmlWidget(
                      widget.headLine.Content!,
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
              tooltip: AppLocalizations.of(context)!.backToTop,
              onPressed: () {
                // 返回到顶部时执行动画
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
            ),
    );
  }
}
