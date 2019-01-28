import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:weifangbus/entity/home/startUpBasicInfo_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/ui/home/news_detail.dart';
import 'package:weifangbus/utils/dioUtil.dart';
import 'package:weifangbus/utils/requestParamsUtil.dart';

/// 资讯列表页
class NewsListPage extends StatefulWidget {
  // 父 widget 传来的列表数据
  final List<Headline> showNewsList;
  final ValueChanged<List<Headline>> onChanged;

  const NewsListPage({Key key, this.showNewsList, this.onChanged}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  List<Headline> newsList = List();
  List<Headline> _showNewsList = List();
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  // 请求资讯列表数据
  Future<List<Headline>> getNewsList() async {
    try {
      var uri = "/BusService/Query_ByNewInfoPartNP?index=1&" + getSignString();
      Response response = await dio.get(uri);
      List<dynamic> list = response.data;
      List<Headline> newsList = list.map((dynamic) => EntityFactory.generateOBJ<Headline>(dynamic)).toList();
      print('请求资讯列表数据完毕');
      return newsList;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('response is not null');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print('response is null');
        print(e.request);
        print(e.message);
      }
      return Future.error(e);
    }
  }

  @override
  void initState() {
    print('资讯列表页初始化');
    super.initState();
    _showNewsList = widget.showNewsList;
  }

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
          child: new ListView.builder(
            //ListView的Item
            itemCount: _showNewsList.length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                child: Container(
                  height: 70.0,
                  child: Card(
                    child: new Center(
                      child: new Text(
                        _showNewsList[index].title,
                        maxLines: 1,
                        style: new TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return InformationDetail(
                          headLine: _showNewsList[index],
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
          onRefresh: () async {
            try {
              newsList = await getNewsList();
              widget.onChanged(newsList);
              print("子 widget 设置状态");
              setState(() {
                _showNewsList = newsList;
              });
            } catch (e) {
              print('刷新资讯列表出错');
              print(e);
            }
          },
          loadMore: () async {
            print('已经是全部了，俺也是有底线的');
          },
        ),
      ),
    );
  }
}
