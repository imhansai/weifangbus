import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/generated/l10n.dart';
import 'package:weifangbus/view/home/news/news_detail.dart';
import 'package:weifangbus/view/store/news_model.dart';

/// 资讯列表页
class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  /// 方便 showSnackBar
  final GlobalKey<ScaffoldState> _newsListKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  // 展示 SnackBar
  void showSnackBar(String snackStr) {
    _newsListKey.currentState!.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(snackStr),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 随着资讯信息的变化而变化
    var _showNewsList = context.watch<NewsModel>();
    // 是否有数据
    var noData = _showNewsList.showNewsList.isEmpty;

    var showNewsList = _showNewsList.showNewsList;

    return Scaffold(
      key: _newsListKey,
      appBar: AppBar(
        title: Text(S.of(context).News),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          var tiles = showNewsList
              .map((e) => ListTile(
                    trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text(
                      DateFormat(S.of(context).NewsDate)
                          .format(DateTime.parse(e.realeasetime))
                          .toString(),
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: orientation == Orientation.portrait
                            ? 43.ssp
                            : 21.ssp,
                      ),
                    ),
                    subtitle: AutoSizeText(
                      e.title,
                      style: TextStyle(
                        fontSize: orientation == Orientation.portrait
                            ? 40.ssp
                            : 20.ssp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return InformationDetail(
                              headLine: e,
                            );
                          },
                        ),
                      ),
                    },
                  ))
              .toList();
          return EasyRefresh.custom(
            header: PhoenixHeader(),
            footer: PhoenixFooter(),
            onRefresh: () async {
              var connectivityResult =
                  await (Connectivity().checkConnectivity());
              if (connectivityResult != ConnectivityResult.none) {
                try {
                  context.read<NewsModel>().refreshNewsList();
                  showSnackBar(S.of(context).RefreshSuccess);
                } catch (e) {
                  print('刷新资讯信息出错::: $e');
                  showSnackBar(S.of(context).RequestDataFailure);
                }
              } else {
                showSnackBar(S.of(context).NotConnectedToAnyNetwork);
              }
            },
            emptyWidget: noData
                ? Center(
                    child: Container(
                      width: 600.w,
                      child: Image.asset(
                        'assets/images/no_news.png',
                        width: 500.w,
                      ),
                    ),
                  )
                : null,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  ListTile.divideTiles(
                    tiles: tiles,
                    context: context,
                  ).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
