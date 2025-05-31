import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:weifangbus/entity/new_info_summary_entity.dart';
import 'package:weifangbus/view/home/news/photo_view.dart';

class InformationDetail extends StatefulWidget {
  final NewInfoSummaryEntity headLine;

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
    var releaseTime = AppLocalizations.of(context)!.releaseTime + widget.headLine.releaseTime!;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.newsDetail),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          40,
          10,
          40,
          100,
        ),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  widget.headLine.title!,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                  ),
                  child: Text(
                    '$releaseTime',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 13.0),
              child: HtmlWidget(
                textStyle: TextStyle(
                  fontSize: 18,
                ),
                widget.headLine.summary!,
              ),
            ),
            Visibility(
              visible: widget.headLine.imageList!.length > 0,
              child: Container(
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: widget.headLine.imageList!
                      .map((imageUrl) => GestureDetector(
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhotoViewPage(imageUrl: imageUrl),
                                ),
                              );
                            },
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        controller: _controller,
      ),
      floatingActionButton: Visibility(
        visible: showToTopBtn,
        child: FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          tooltip: AppLocalizations.of(context)!.backToTop,
          onPressed: () {
            // 返回到顶部时执行动画
            _controller.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
          },
        ),
      ),
    );
  }
}
