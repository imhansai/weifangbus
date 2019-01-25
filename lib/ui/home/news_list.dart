import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// 资讯列表页
class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  List<String> addStr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  List<String> str = [];
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("资讯列表"),
      ),
      body: Center(
        child: new EasyRefresh(
          key: _easyRefreshKey,
          refreshHeader: PhoenixHeader(
            key: _headerKey,
          ),
          refreshFooter: PhoenixFooter(
            key: _footerKey,
          ),
          firstRefresh: true,
          firstRefreshWidget: new Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black12,
            child: new Center(
              child: SizedBox(
                height: 200.0,
                width: 300.0,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 50.0,
                        height: 50.0,
                        child: SpinKitFadingCube(
                          color: Theme.of(context).primaryColor,
                          size: 25.0,
                        ),
                      ),
                      Container(
                        child: Text("玩命加载中..."),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          child: new ListView.builder(
            //ListView的Item
            itemCount: str.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  height: 70.0,
                  child: Card(
                    child: new Center(
                      child: new Text(
                        str[index],
                        style: new TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ));
            },
          ),
          onRefresh: () async {
            await new Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                str.clear();
                str.addAll(addStr);
              });
            });
          },
          loadMore: () async {
            print('没有分页，已经是全部了，俺也是有底线的');
          },
        ),
      ),
    );
  }
}
