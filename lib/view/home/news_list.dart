import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/view/home/news_detail.dart';
import 'package:weifangbus/view/store/news_model.dart';

/// 资讯列表页
class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final GlobalKey<ScaffoldState> _newsListKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  // 展示 SnackBar
  void showSnackBar(String snackStr) {
    _newsListKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(snackStr),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _newsListKey,
      appBar: AppBar(
        title: Text("资讯列表"),
      ),
      body: Consumer<NewsModel>(
        builder: (context, _showNewsList, _) => Center(
          child: EasyRefresh.custom(
            header: PhoenixHeader(),
            footer: PhoenixFooter(),
            onRefresh: () async {
              var connectivityResult = await (Connectivity().checkConnectivity());
              if (connectivityResult != ConnectivityResult.none) {
                try {
                  Provider.of<NewsModel>(context, listen: false).refreshNewsList();
                  showSnackBar('刷新成功!');
                } catch (e) {
                  print('刷新资讯列表出错::: $e');
                  showSnackBar('请求数据失败，请尝试切换网络后重试!');
                }
              } else {
                showSnackBar('设备未连接到任何网络,请连接网络后重试!');
              }
            },
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return FlatButton(
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        height: ScreenUtil().setHeight(210),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(
                                ScreenUtil().setWidth(31),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    DateFormat("yyyy年MM月dd日")
                                        .format(DateTime.parse(_showNewsList.showNewsList[index].realeasetime))
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: ScreenUtil().setSp(50),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(31),
                                ),
                                child: Text(
                                  _showNewsList.showNewsList[index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(45),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: ScreenUtil().setHeight(1),
                              padding:
                                  EdgeInsets.only(left: ScreenUtil().setWidth(13), right: ScreenUtil().setWidth(13)),
                              child: Container(
                                color: Colors.black12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return InformationDetail(
                                headLine: _showNewsList.showNewsList[index],
                              );
                            },
                          ),
                        ),
                      },
                    );
                  },
                  childCount: _showNewsList.showNewsList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
